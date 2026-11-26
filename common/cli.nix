{pkgs, ...}: {
  home.packages = with pkgs; [
    _1password-cli
    confluent-cli
    gh
  ];
}
