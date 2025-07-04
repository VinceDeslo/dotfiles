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
            gs="git status";
            ga="git add .";
            gc="git commit";
            gp="git push";
            gd="git diff";
            gl="git log --oneline -n 10 --pretty=format:'%C(yellow)%H%C(reset) - %s %C(cyan)(%an)%C(reset)' --color=always";
            grv="gh repo view -w";
        };
        initContent = ''
            export GPG_TTY=$(tty)

            # Nix
            if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
                . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
            fi

            . "$HOME/.cargo/env"

            eval "$(direnv hook zsh)"

            source <(kubectl completion zsh)
            source <(helm completion zsh)
            source <(op completion zsh)
            source <(gh completion -s zsh)
            source <(just --completions zsh)
        '';
        plugins = [
            {
                name = "snyk-work";
                src = builtins.fetchGit {
                    url = "git@github.com:VinceDeslo/snyk-work-zsh-plugin.git";
                    rev = "ac1c4d5bdbd1c61bc4fac5d9c87baac4665ac932";
                };
            }
        ];
    };
}
