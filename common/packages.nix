{pkgs}: let 
    ai = import ./ai.nix {inherit pkgs;};
    cli = import ./cli.nix {inherit pkgs;};
    cloud = import ./cloud.nix {inherit pkgs;};
    core = import ./core.nix {inherit pkgs;};
    docs = import ./docs.nix {inherit pkgs;};
    network = import ./network.nix {inherit pkgs;};
    utils = import ./utils.nix {inherit pkgs;};
in (
    ai ++
    cli ++
    cloud ++
    core ++ 
    docs ++
    network ++
    utils
)
