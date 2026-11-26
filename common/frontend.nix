{pkgs, ...}: {
  home.packages = with pkgs; [
    agent-browser
  ];
}
