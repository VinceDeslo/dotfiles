{pkgs}: let
  backend = import ./backend.nix {inherit pkgs;};
  cli = import ./cli.nix {inherit pkgs;};
  cloud = import ./cloud.nix {inherit pkgs;};
  core = import ./core.nix {inherit pkgs;};
  docs = import ./docs.nix {inherit pkgs;};
  langs = import ./langs.nix {inherit pkgs;};
  obs = import ./observability.nix {inherit pkgs;};
  sandbox = import ./sandbox.nix {inherit pkgs;};
  utils = import ./utils.nix {inherit pkgs;};
in (
  backend
  ++ cli
  ++ cloud
  ++ core
  ++ docs
  ++ langs
  ++ obs
  ++ sandbox
  ++ utils
)
