{pkgs, ...}: {
  home.packages = with pkgs; [
    mdbook
    mdbook-mermaid
  ];
}
