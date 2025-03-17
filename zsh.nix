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
            nixd="nix develop -c $SHELL";
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
        '';
        plugins = [
            {
                name = "snyk-work";
                src = builtins.fetchGit {
                    url = "git@github.com:VinceDeslo/snyk-work-zsh-plugin.git";
                    rev = "9178be1c902d6ccf8c2500ec5f94403c62a75b95";
                };
            }
        ];
    };
}
