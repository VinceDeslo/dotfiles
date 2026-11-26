{pkgs, ...}: {
  home.packages = with pkgs; [
    gcx
    datadog-pup
  ];
}
