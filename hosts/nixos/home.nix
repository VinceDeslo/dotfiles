{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../common/starship.nix
  ];

  # username/homeDirectory come from users.users.vince via the NixOS module
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  # Replace with zsh after initial setup
  programs.bash.enable = true;

  # Hyprland config: symlinked to the repo checkout, so edits apply without a rebuild
  xdg.configFile."hypr/hyprland.lua".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/hosts/nixos/hypr/hyprland.lua";
}
