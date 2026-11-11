{
  config,
  pkgs,
  ...
}: let
  agentSocketDir = "${config.home.homeDirectory}/.ssh/agent";
  agentSocket = "${agentSocketDir}/ssh-agent.sock";
  askpassFromPass = pkgs.writeShellScriptBin "ssh-askpass-pass" ''
    ${pkgs.pass}/bin/pass show ssh/id_ed25519 | head -n1
  '';
in {
  home.packages = [askpassFromPass];

  launchd.agents.ssh-agent = {
    enable = true;
    config = {
      ProgramArguments = [
        "/bin/sh"
        "-c"
        "mkdir -p -m 700 ${agentSocketDir}; rm -f ${agentSocket}; exec ${pkgs.openssh}/bin/ssh-agent -D -a ${agentSocket}"
      ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  programs.zsh.initContent = ''
    export SSH_AUTH_SOCK="${agentSocket}"
    if ! ssh-add -l >/dev/null 2>&1; then
      SSH_ASKPASS=ssh-askpass-pass SSH_ASKPASS_REQUIRE=force ssh-add ~/.ssh/id_ed25519 </dev/null
    fi
  '';

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    extraOptionOverrides = {
      IgnoreUnknown = "UseKeychain";
    };
    includes = ["~/.orbstack/ssh/config"];
    settings = {
      kvm = {
        User = "root";
      };
      "*" = {
        UseKeychain = "yes";
        AddKeysToAgent = "yes";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
