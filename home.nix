{pkgs, ...}: {
	home.username = "vince";
	home.homeDirectory = "/home/vince";
	home.stateVersion = "24.05";
	programs.home-manager.enable = true;
	
	home.packages = [];
}
