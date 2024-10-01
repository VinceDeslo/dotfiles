{
	description = "Home Manager flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {nixpkgs, home-manager, ...}: {
		# For `nix run .` later
		defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;
		
		homeConfigurations = {
			"vince" = home-manager.lib.homeManagerConfiguration {
				# TODO: define this with flake-utils instead 
				pkgs = import nixpkgs { system = "aarch64-darwin"; };
				modules = [ ./home.nix ];
			};
		};
	};
}
