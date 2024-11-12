{pkgs, pdeconfig, ...}: let
  system = pkgs.system;
in {
    imports = [
        ./zsh.nix
        ./starship.nix
    ];

    home.username = "vince";
    home.homeDirectory = "/Users/vince";
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;

    programs.neovim = pdeconfig.lib.mkHomeManager {inherit system;};

    home.packages = with pkgs; [
        # Core tools
        zsh
        # git
        starship

        # Misc utils
        gh
        jq
        yq
        eza
        ripgrep
        bat
        fzf
        tokei
        just

        # Temporary language tooling
        # since not all projects on which I work have a flake
        fnm

        # Cloud tools
        awscli2
        google-cloud-sdk
        kubectl
        kubernetes-helm
        terraform
    ];
}
