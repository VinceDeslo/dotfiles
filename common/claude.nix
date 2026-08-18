{
  config,
  pkgs,
  ...
}: let
  # Claude resolves `@file` imports in ~/.claude/CLAUDE.md against the realpath
  # of the symlink, so every imported file must be a sibling of CLAUDE.md in the
  # same store directory. Pointing `source` at a path inside one derivation keeps
  # them together; a per-file `source = ./context/x.md` would instead copy each
  # file to its own store root path and break the imports.
  # RTK.md is managed outside of nix, so it is linked back into $HOME.
  context = pkgs.runCommand "claude-context" {} ''
    mkdir -p $out
    cp ${./context/CLAUDE.md} $out/CLAUDE.md
    cp ${./context/worktrees.md} $out/worktrees.md
    cp ${./context/locations.md} $out/locations.md
    cp ${./context/style.md} $out/style.md
    ln -s ${config.home.homeDirectory}/.claude/RTK.md $out/RTK.md
  '';
in {
  home.file.".claude/CLAUDE.md".source = "${context}/CLAUDE.md";
  home.file.".claude/worktrees.md".source = "${context}/worktrees.md";
  home.file.".claude/locations.md".source = "${context}/locations.md";
  home.file.".claude/style.md".source = "${context}/style.md";
}
