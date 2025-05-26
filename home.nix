{pkgs, pdeconfig, kin, ...}: let
  system = pkgs.system;
  kinCli = kin.packages.${system}.default;
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
        glow
        ngrok
        direnv

        # Temporary language tooling
        # since not all projects on which I work have a flake
        fnm

        # Cloud tools
        awscli2
        google-cloud-sdk
        kubectl
        kubernetes-helm
        terraform
        kinCli # Custom

        # AI tools
        aichat

        # Secrets
        _1password-cli

        # Data
        # snowsql -- need to update upstream support for arm64
        confluent-cli

        # Docs
        mdbook
        mdbook-mermaid
        mdbook-alerts
    ];
}
