{
  lib,
  pkgs,
  ...
}: let
  profilesDir = ./nono/profiles;
  expandCliContextsFilter = ./nono/expand-cli-contexts.jq;
  jq = "${pkgs.jq}/bin/jq";
  gcx = "${pkgs.gcx}/bin/gcx";
  kubectl = "${pkgs.kubectl}/bin/kubectl";
  agentStateDirs = [
    "$HOME/.artifacts"
    "$HOME/.opencode"
    "$HOME/.config/opencode"
    "$HOME/.cache/opencode"
    "$HOME/.local/share/opencode"
    "$HOME/.local/share/opentui"
    "$HOME/.local/state/opencode"
    "$HOME/.codex"
    "$HOME/.pi"
  ];
in {
  home.activation.ensureAgentStateDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir -p ${lib.concatStringsSep " " agentStateDirs}
  '';
  home.activation.renderNonoProfiles = lib.hm.dag.entryAfter ["linkGeneration"] ''
    gcxContexts=$(${gcx} config list-contexts -o json 2>/dev/null | ${jq} -c '[.contexts[].name | select(test("^[A-Za-z0-9._-]+$"))]' || echo '[]')
    kubectlContexts=$(${kubectl} config get-contexts -o name 2>/dev/null | ${jq} -Rsc '[split("\n")[] | select(test("^[A-Za-z0-9._:/@-]+$"))]' || echo '[]')
    cliContexts=$(${jq} -nc --argjson gcx "''${gcxContexts:-[]}" --argjson kubectl "''${kubectlContexts:-[]}" '{gcx: $gcx, kubectl: $kubectl}')
    nonoProfilesDir="$HOME/.config/nono/profiles"
    if [[ ! -v DRY_RUN ]]; then
      mkdir -p "$nonoProfilesDir"
      for profileSource in ${profilesDir}/*.json; do
        profileTarget="$nonoProfilesDir/$(basename "$profileSource")"
        ${jq} --argjson cliContexts "$cliContexts" -f ${expandCliContextsFilter} "$profileSource" > "$profileTarget.tmp"
        rm -f "$profileTarget"
        mv "$profileTarget.tmp" "$profileTarget"
      done
    fi
    verboseEcho "Rendered nono profiles with cli contexts: $cliContexts"
  '';
}
