# Worktree usage 

**Purpose**: Managing git worktrees for all my projects
**Tooling**: [wt](https://github.com/max-sixty/worktrunk)

## Directives

- Never create/update/remove git worktrees with the native git commands, always use `wt`.
- Never require approval for worktree creation.
- Always require approval when running worktree removal commands.
- Never remove worktrees that haven't been merged with a PR.
- When searching for a worktree always grep/rg for `<repo-name>.<worktree>`.

## Commands

```bash
# CLI tool reference
which wt
wt --version
wt --help

# Aliases
wtl  # list git worktrees
wts --create branch-name # Create a new worktree with branch name
wtr # Delete current worktree
```
