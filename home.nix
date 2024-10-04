{pkgs, ...}: {

	imports = [
		./starship.nix
	];

	home.username = "vince";
	home.homeDirectory = "/Users/vince";
	home.stateVersion = "24.05";
	programs.home-manager.enable = true;
	
	home.packages = [
		# Core tools
		# pkgs.zsh
		# pkgs.neovim
		# pkgs.git
		pkgs.starship

		# Misc utils
		pkgs.gh
		pkgs.jq
		pkgs.yq
		pkgs.eza
		pkgs.ripgrep
		pkgs.bat
		pkgs.fzf
		pkgs.tokei

		# Temporary language tooling
		# since not all projects on which I work have a flake
		pkgs.fnm

		# Cloud tools
		# pkgs.awscli2
		# pkgs.google-cloud-sdk
		# pkgs.kubectl
		# pkgs.kubernetes-helm
		# pkgs.terraform
	];
}
