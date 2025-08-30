{
	description = "Home Manager flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		pdeconfig.url = "github:VinceDeslo/pdeconfig.nvim";
	};

	outputs = {nixpkgs, home-manager, pdeconfig, ...}: {
		defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
		
		homeConfigurations = {
			darwin = home-manager.lib.homeManagerConfiguration {
				pkgs = import nixpkgs { 
                    system = "aarch64-darwin"; 
                    config = {
                        allowUnfree = true; 
                    }; 
                };
				modules = [ ./hosts/darwin/home.nix ];
				extraSpecialArgs = { inherit pdeconfig; };
			};
			linux = home-manager.lib.homeManagerConfiguration {
				pkgs = import nixpkgs { 
                    system = "x86_64-linux"; 
                    config = { 
                        allowUnfree = true; 
                    }; 
                };
				modules = [ ./hosts/linux/home.nix ];
				extraSpecialArgs = { inherit pdeconfig; };
			};
		};
	};
}
