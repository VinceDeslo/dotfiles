{pkgs, ...}: {
  home.packages = [pkgs.pinentry_mac];

  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
  '';
}
