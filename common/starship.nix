{pkgs, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = "$nix_shell$directory$git_branch$git_commit$git_state$git_status$character";
      right_format = "$aws$kubernetes";

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

      aws = {
        format = "[$profile( \\($region\\))]($style) ";
        style = "dimmed white";
      };

      kubernetes = {
        disabled = false;
        format = "[$symbol$context]($style)";
        style = "bright-blue";
        contexts = [
          { context_pattern = ".*:(?P<c>cluster/.*prod.*)"; context_alias = "$c"; style = "red bold"; }
          { context_pattern = ".*:(?P<c>cluster/.*dev.*)"; context_alias = "$c"; style = "bright-green"; }
        ];
      };
    };
  };
}
