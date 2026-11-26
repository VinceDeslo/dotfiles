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
    ../../common/ssh.nix
    ../../common/gpg.nix
    ../../common/git.nix
  ];

  home.username = "vince";
  home.homeDirectory = "/Users/vince";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # programs.neovim = pdeconfig.lib.mkHomeManager {inherit system;};
}
