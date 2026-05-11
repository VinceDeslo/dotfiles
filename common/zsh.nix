{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      v = "nvim";
      ls = "eza -la";
      cat = "bat";
      dots = "nvim ~/dotfiles";
      ghost-conf = "nvim ~/.config/ghostty/config";
      hms = "home-manager switch --flake .";
      k = "kubectl";
      klocal = "kubectl config use-context docker-desktop";
      aws-conf = "nvim ~/.aws/config";
      aws-creds = "nvim ~/.aws/credentials";
      print-path = "echo $PATH | tr : '\n'";
      get-uuid = "uuidgen | tr A-Z a-z | pbcopy";
      branch-cleanup = "git branch | grep -v 'main' | xargs git branch -D";
      nixd = "nix develop -c $SHELL";
      gs = "git status";
      ga = "git add .";
      gcb = "git checkout -b";
      gc = "git commit";
      gp = "git push";
      gd = "git diff";
      gds = "git diff --staged";
      gl = "git log --oneline -n 10 --pretty=format:'%C(yellow)%H%C(reset) - %s %C(cyan)(%an)%C(reset)' --color=always";
      grv = "gh repo view -w";
      wtl = "wt list";
      wts = "wt switch";
      wtr = "wt remove";
      oc = "opencode";
      oc-conf = "nvim ~/.config/opencode/opencode.json";
    };
    initContent = ''
      export GPG_TTY=$(tty)

      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      eval "$(direnv hook zsh)"
      eval "$(zoxide init zsh)"
      eval "$(fnm env --use-on-cd --shell zsh)"

      source <(kubectl completion zsh)
      source <(helm completion zsh)
      source <(op completion zsh)
      source <(gh completion -s zsh)
      source <(just --completions zsh)
      source <(fnm completions --shell zsh)
      source <(wt config shell init zsh)

      autoload -Uz compinit && compinit
      autoload bashcompinit && bashcompinit
      complete -C '${pkgs.awscli2}/bin/aws_completer' aws

      function aws-ctx() {
          export AWS_PROFILE="$(aws configure list-profiles | fzf)"
          echo "Switched to AWS profile ""$AWS_PROFILE""."
      }

      export PATH="$HOME/.local/bin:$PATH"
      export GITHUB_TOKEN=$(gh auth token)
    '';
    plugins = [
      {
        name = "ic-work";
        src = builtins.fetchGit {
          url = "git@github.com:VinceDeslo/ic-work-zsh-plugin.git";
          rev = "bbe9ed159acf23722f4e47c565f0ba58347215cf";
        };
      }
    ];
  };
}
