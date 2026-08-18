{
  config,
  lib,
  pkgs,
  ...
}: let
  # Shared context shipped to every agent.
  contextFiles = [
    ./context/worktrees.md
    ./context/locations.md
    ./context/style.md
  ];

  # Claude resolves `@file` imports in CLAUDE.md against the realpath of the
  # symlink, so every imported file must be a sibling of CLAUDE.md in the same
  # store directory. A per-file `source = ./context/x.md` would instead copy each
  # file to its own store root path and break the imports.
  # RTK.md is managed outside of nix, so it is linked back into $HOME.
  claudeContext = pkgs.runCommand "claude-context" {} ''
    mkdir -p $out
    cp ${./context/CLAUDE.md} $out/CLAUDE.md
    ${lib.concatMapStringsSep "\n" (f: "cp ${f} $out/${baseNameOf f}") contextFiles}
    ln -s ${config.home.homeDirectory}/.claude/RTK.md $out/RTK.md
  '';

  # opencode reads each instruction file verbatim and has no `@file` import
  # syntax, so the same context is concatenated into a single AGENTS.md.
  opencodeContext = pkgs.runCommand "opencode-context" {} ''
    mkdir -p $out
    touch $out/AGENTS.md
    ${lib.concatMapStringsSep "\n" (f: "cat ${f} >> $out/AGENTS.md && echo >> $out/AGENTS.md") contextFiles}
  '';
in {
  home.packages = with pkgs; [
    agent-browser
    github-copilot-cli
    ollama
    opencode
    pi-coding-agent
    skills
    herdr
    llmfit
  ];

  home.file.".claude/CLAUDE.md".source = "${claudeContext}/CLAUDE.md";
  home.file.".claude/worktrees.md".source = "${claudeContext}/worktrees.md";
  home.file.".claude/locations.md".source = "${claudeContext}/locations.md";
  home.file.".claude/style.md".source = "${claudeContext}/style.md";

  home.file.".config/opencode/AGENTS.md".source = "${opencodeContext}/AGENTS.md";
}
