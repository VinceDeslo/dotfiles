{pkgs, pdeconfig, kin, ...}: let
  system = pkgs.system;
  kinCli = kin.packages.${system}.default;
  commonPkgs = import ../../common/packages.nix {inherit pkgs;};
in {
    imports = [
        ../../common/zsh.nix
        ../../common/starship.nix
    ];

    home.username = "vince";
    home.homeDirectory = "/Users/vince";
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;

    programs.neovim = pdeconfig.lib.mkHomeManager {inherit system;};

    home.packages = commonPkgs ++ (with pkgs; [
        # extra packages for work
        fnm
        kinCli
    ]);
}
