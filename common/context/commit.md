# Commits

## Scope

- Applies to all code commits authored on my behalf.

## Directives

- NEVER add `Co-Authored-By:` on commits.
- NEVER use the `--author` flag to bypass the base user from the git credentials.
- ALWAYS sign commits with the configured SSH signing key.
- NEVER use `--no-gpg-sign`, `-c commit.gpgsign=false`, or other options that skip signing.
- Rebase, amend, cherry-pick, squash, and other history rewrites create new commits. These commits must be signed as well.
- BEFORE any push (including `--force-with-lease`), make sure that all commits to push are signed: `git log --format='%h %G? %s' @{u}..HEAD` (or `<base>..HEAD` with no upstream). Each commit must show a `G` or `U` status, not `N`.
- If a commit is not signed, do NOT push. Re-sign with `git rebase --exec 'git commit --amend --no-edit -S' <base>`, or stop and tell me.
