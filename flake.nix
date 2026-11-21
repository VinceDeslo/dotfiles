{
  description = "Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pdeconfig.url = "github:VinceDeslo/pdeconfig.nvim";
  };

  outputs = {
    nixpkgs,
    nixpkgs-nixos,
    home-manager,
    pdeconfig,
    ...
  }: let
    mkPkgs = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    hmArgs = {inherit pdeconfig;};
  in {
    packages.aarch64-darwin.default = home-manager.packages.aarch64-darwin.default;
    packages.x86_64-linux.default = home-manager.packages.x86_64-linux.default;

    homeConfigurations = {
      darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs "aarch64-darwin";
        modules = [./hosts/darwin/home.nix];
        extraSpecialArgs = hmArgs;
      };
      linux = home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs "x86_64-linux";
        modules = [./hosts/linux/home.nix];
        extraSpecialArgs = hmArgs;
      };
    };

    nixosConfigurations = {
      nixos = nixpkgs-nixos.lib.nixosSystem {
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.vince = import ./hosts/nixos/home.nix;
            };
          }
        ];
      };
    };
  };
}
