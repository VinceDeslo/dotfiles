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
in {
  home.file = profileLinks;
}
