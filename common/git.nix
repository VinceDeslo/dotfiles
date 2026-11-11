{config, ...}: let
  signingEmail = "51060280+VinceDeslo@users.noreply.github.com";
  signingPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0TjZpEmDZwui0bwboae30RPb7EFuy6waJlUolBfNTX";
  allowedSignersPath = ".ssh/allowed_signers";
in {
  home.file.${allowedSignersPath}.text = ''
    ${signingEmail} ${signingPublicKey}
  '';

  programs.git = {
    enable = true;
    package = null;
    signing.format = "ssh";
    settings.gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/${allowedSignersPath}";
  };
}
