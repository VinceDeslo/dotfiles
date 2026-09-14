{lib, ...}: let
  profilesDir = ./nono/profiles;
  profileFileNames = builtins.attrNames (
    lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".json" name) (builtins.readDir profilesDir)
  );
  profileLinks = lib.listToAttrs (map (fileName: {
      name = ".config/nono/profiles/${fileName}";
      value.source = "${profilesDir}/${fileName}";
    })
    profileFileNames);
  agentStateDirs = [
    "$HOME/.artifacts"
    "$HOME/.opencode"
    "$HOME/.config/opencode"
    "$HOME/.cache/opencode"
    "$HOME/.local/share/opencode"
    "$HOME/.local/share/opentui"
    "$HOME/.local/state/opencode"
  ];
in {
  home.file = profileLinks;
  home.activation.ensureAgentStateDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir -p ${lib.concatStringsSep " " agentStateDirs}
  '';
}
