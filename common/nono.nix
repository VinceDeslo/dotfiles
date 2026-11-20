{
  lib,
  pkgs,
  ...
}: let
  profilesDir = ./nono/profiles;
  expandGcxContextsFilter = ./nono/expand-gcx-contexts.jq;
  jq = "${pkgs.jq}/bin/jq";
  gcx = "${pkgs.gcx}/bin/gcx";
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
    nonoProfilesDir="$HOME/.config/nono/profiles"
    if [[ ! -v DRY_RUN ]]; then
      mkdir -p "$nonoProfilesDir"
      for profileSource in ${profilesDir}/*.json; do
        profileTarget="$nonoProfilesDir/$(basename "$profileSource")"
        ${jq} --argjson gcxContexts "''${gcxContexts:-[]}" -f ${expandGcxContextsFilter} "$profileSource" > "$profileTarget.tmp"
        rm -f "$profileTarget"
        mv "$profileTarget.tmp" "$profileTarget"
      done
    fi
    verboseEcho "Rendered nono profiles with gcx contexts: $gcxContexts"
  '';
}
