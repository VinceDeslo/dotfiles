{pkgs}: let
  # These tests need the host process table, unreadable from a nix build user.
  worktrunkWithoutHostDependentTests = pkgs.worktrunk.overrideAttrs (old: {
    checkFlags =
      old.checkFlags
      ++ [
        "--skip=shell::utils::tests::test_process_name_and_ppid_self"
        "--skip=shell::utils::tests::test_probe_reports_invoked_name_for_sh"
        "--skip=git::repository::tests::start_fsmonitor_daemon_skips_fork_when_daemon_answers"
      ];
  });
in
  with pkgs; [
    zsh
    starship
    git
    jujutsu
    worktrunkWithoutHostDependentTests
    gh
    tmux
    pass
    gnupg
    hunk
  ]
