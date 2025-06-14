__default:
	just --list

update:
    nix flake update

darwin:
    home-manager switch --flake .#darwin

linux:
    home-manager switch --flake .#linux
