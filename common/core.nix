{pkgs}: let
  # These tests need the host process table, unreadable from a nix build user.
  worktrunkWithoutProcessTableTests = pkgs.worktrunk.overrideAttrs (old: {
    checkFlags =
      old.checkFlags
      ++ [
        "--skip=shell::utils::tests::test_process_name_and_ppid_self"
        "--skip=shell::utils::tests::test_probe_reports_invoked_name_for_sh"
      ];
  });
in
  with pkgs; [
    zsh
    starship
    git
    jujutsu
    worktrunkWithoutProcessTableTests
    gh
    tmux
    pass
    gnupg
  ]
