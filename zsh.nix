{pkgs, ...}: {
    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        enableCompletion = true; 
        syntaxHighlighting.enable = true;
        shellAliases = {
            ls="eza -la";
            cat="bat";
            dots="nvim ~/dotfiles";
            hms="home-manager switch --flake .";
            k="kubectl";
            klocal="kubectl config use-context docker-desktop";
            aws-conf="nvim ~/.aws/config";
            aws-creds="nvim ~/.aws/credentials";
            todo="nvim ~/Repos/todo/README.md";
            scratch="nvim ~/Repos/scratch";
            print-path="echo $PATH | tr : '\n'";
            get-uuid="uuidgen | tr A-Z a-z | pbcopy";
            branch-cleanup="git branch | grep -v 'main' | xargs git branch -D";
        };
        initExtra = ''
            export GPG_TTY=$(tty)

            # Nix
            if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
                . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
            fi

            . "$HOME/.cargo/env"

            source <(kubectl completion zsh)
            source <(helm completion zsh)

            eval "$(fnm env --use-on-cd --shell zsh)"
        '';
    };
}
