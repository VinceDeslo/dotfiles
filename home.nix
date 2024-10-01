{pkgs, ...}: {

	imports = [
		./starship.nix
	];

	home.username = "vince";
	home.homeDirectory = "/Users/vince";
	home.stateVersion = "24.05";
	programs.home-manager.enable = true;
	
	home.packages = [
		pkgs.starship
	];
}
