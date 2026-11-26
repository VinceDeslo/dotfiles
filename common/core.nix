{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh
    starship
    git
    jujutsu
    worktrunk
    gh
    tmux
    pass
    openssh
    gnupg
    hunk
    _1password-cli
  ];
}
