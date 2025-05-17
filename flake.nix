{
	description = "Home Manager flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		pdeconfig.url = "github:VinceDeslo/pdeconfig.nvim";
        kin.url = "github:VinceDeslo/kin";
	};

	outputs = {nixpkgs, home-manager, pdeconfig, kin, ...}: {
		defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;
		
		homeConfigurations = {
			"vince" = home-manager.lib.homeManagerConfiguration {
				# TODO: define this with flake-utils or flake-parts instead
				pkgs = import nixpkgs { 
                    system = "aarch64-darwin"; 
                    config = { 
                        allowUnfree = true; 
                    }; 
                };
				modules = [ ./home.nix ];
				extraSpecialArgs = { inherit pdeconfig kin; };
			};
		};
	};
}
