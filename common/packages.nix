{pkgs}: let 
    ai = import ./ai.nix {inherit pkgs;};
    backend = import ./backend.nix {inherit pkgs;};
    cli = import ./cli.nix {inherit pkgs;};
    cloud = import ./cloud.nix {inherit pkgs;};
    core = import ./core.nix {inherit pkgs;};
    docs = import ./docs.nix {inherit pkgs;};
    utils = import ./utils.nix {inherit pkgs;};
    langs = import ./langs.nix {inherit pkgs;};
in (
    ai ++
    backend ++
    cli ++
    cloud ++
    core ++ 
    docs ++
    utils ++
    langs
)
