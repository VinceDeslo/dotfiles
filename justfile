__default:
	just --list

# Refresh flakes and lock
update:
    nix flake update

# Run home-manager for Darwin system
darwin: 
    home-manager switch --flake .#darwin

# Run home-manager for Linux system
linux:
    home-manager switch --flake .#linux

# Recursively format
fmt:
    alejandra .

# Validate the nono sandbox profiles shipped by this repo
nono-validate:
    for profile in common/nono/profiles/*.json; do nono profile validate "$profile"; done
