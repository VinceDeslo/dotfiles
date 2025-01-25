{pkgs, ...}: {
	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			add_newline = false;
			format = "$nix_shell$directory$git_branch$git_commit$git_state$git_status$character";
			right_format = "$kubernetes";

			nix_shell = {
				symbol = " ";
				format = "[$symbol$name]($style) ";
				style = "bright-blue bold";
			};
			directory = {
				truncation_length = 2;
				style = "cyan bold";
			};
			git_branch = {
				only_attached = true;
				format = "[$branch]($style) ";
				style = "green bold";
			};
			git_commit = {
				only_detached = true;
				format = "[$hash]($style) ";
				style = "red bold";
			};
			git_state = {
				style = "bright-purple bold";
			};
			git_status = {
				style = "bright-purple bold";
			};
			character = {
				success_symbol = "[❯](purple bold)";
				error_symbol = "[✖](red bold)";
			};

			# Language/tool specific features
			kubernetes = {
				disabled = false;
				format = "[$context]($style)";
				style = "bright-blue";
			};
		};
	};
}
