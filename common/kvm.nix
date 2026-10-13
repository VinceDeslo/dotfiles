{pkgs}: let
  kvmPower = pkgs.writeShellApplication {
    name = "kvm-power";
    runtimeInputs = with pkgs; [pass jq coreutils];
    excludeShellChecks = ["SC2029"];
    text = ''
      kvm_host="''${KVM_HOST:-kvm}"
      target_host="''${KVM_TARGET_HOST:-linux}"
      kvmd_user="''${KVMD_USER:-admin}"
      kvmd_pass_entry="''${KVMD_PASS_ENTRY:-kvm/kvmd}"
      boot_timeout_seconds="''${KVM_BOOT_TIMEOUT:-180}"

      usage() {
        echo "usage: kvm-power {status|on|off|off-hard|reset}" >&2
        exit 1
      }

      kvmd_request() {
        local method="$1" path="$2" password
        password="$(pass show "$kvmd_pass_entry" | head -n1)"
        printf 'X-KVMD-User: %s\nX-KVMD-Passwd: %s\n' "$kvmd_user" "$password" |
          ssh "$kvm_host" "curl -sf --unix-socket /run/kvmd/kvmd.sock -H @- -X $method 'http://localhost$path'"
      }

      atx_power_state() {
        kvmd_request GET /atx | jq -r '.result.leds.power'
      }

      atx_power_action() {
        kvmd_request POST "/atx/power?action=$1" >/dev/null
      }

      wait_for_target_ssh() {
        local deadline=$((SECONDS + boot_timeout_seconds)) last_ssh_error
        while true; do
          if last_ssh_error="$(ssh -o ConnectTimeout=5 -o BatchMode=yes "$target_host" true 2>&1)"; then
            return
          fi
          if [[ "$last_ssh_error" == *"Permission denied"* ]]; then
            return
          fi
          if ((SECONDS >= deadline)); then
            echo "timeout: $target_host not reachable after ''${boot_timeout_seconds}s" >&2
            echo "last ssh error: $last_ssh_error" >&2
            exit 1
          fi
          sleep 5
        done
      }

      case "''${1:-}" in
        status)
          echo "power: $(atx_power_state)"
          ;;
        on)
          if [[ "$(atx_power_state)" == "true" ]]; then
            echo "$target_host already on"
          else
            atx_power_action on
            echo "power on sent, waiting for $target_host"
          fi
          wait_for_target_ssh
          exec ssh "$target_host"
          ;;
        off)
          atx_power_action off
          ;;
        off-hard)
          atx_power_action off_hard
          ;;
        reset)
          atx_power_action reset_hard
          ;;
        *)
          usage
          ;;
      esac
    '';
  };
in [kvmPower]
