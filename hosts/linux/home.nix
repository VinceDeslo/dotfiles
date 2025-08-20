{pkgs, pdeconfig, ...}: let
  system = pkgs.system;
  commonPkgs = import ../../common/packages.nix {inherit pkgs;};
in {
    imports = [
        ../../common/zsh.nix
        ../../common/starship.nix
    ];

    home.username = "vince";
    home.homeDirectory = "/home/vince";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;

    programs.neovim = pdeconfig.lib.mkHomeManager {inherit system;};

    home.packages = commonPkgs ++ (with pkgs; [
        go
        delve
    ]);
}
