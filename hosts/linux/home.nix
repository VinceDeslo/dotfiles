{
  pkgs,
  pdeconfig,
  ...
}: let
  system = pkgs.system;
in {
  imports = [
    ../../common/packages.nix
    ../../common/zsh.nix
    ../../common/starship.nix
    ../../common/ai.nix
    ../../common/nono.nix
  ];

  home.username = "vince";
  home.homeDirectory = "/home/vince";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  programs.neovim = pdeconfig.lib.mkHomeManager {inherit system;};

  home.packages = with pkgs; [
    go
    delve
  ];
}
