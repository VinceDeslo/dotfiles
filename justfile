__default:
	just --list

update:
    nix flake update

switch:
    home-manager switch --flake .
