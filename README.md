# Dotfiles

My local development environment as code, with Nix flakes and Home Manager.

This repo is public so that I can share my setup. It also forces me to keep secrets out of these files.

> Note: This is a work in progress. I add configurations one at a time so that I do not break the setup that I use for work.

## Hosts

The flake (`flake.nix`) has two Home Manager configurations:

| Host     | System           | Entry point             | Specific modules                         |
| -------- | ---------------- | ----------------------- | ---------------------------------------- |
| `darwin` | `aarch64-darwin` | `hosts/darwin/home.nix` | `ssh`, `gpg`, `git`                      |
| `linux`  | `x86_64-linux`   | `hosts/linux/home.nix`  | Neovim from [pdeconfig.nvim][pdeconfig]  |

Both hosts import `zsh`, `starship`, `ai`, `nono`, and all of the packages in `common/packages.nix`.

Flake inputs:

- `nixpkgs` (unstable, unfree packages allowed)
- `home-manager`
- [`pdeconfig`][pdeconfig]: my Neovim configuration

## Layout

```text
.
├── flake.nix           # Inputs and host configurations
├── justfile            # Tasks
├── hosts/
│   ├── darwin/home.nix # Work laptop
│   └── linux/home.nix  # Personal system
└── common/
    ├── packages.nix    # Joins the package lists below
    ├── *.nix           # Package lists and Home Manager modules
    ├── context/        # Instructions for coding agents
    └── nono/profiles/  # Sandbox profiles for coding agents
```

## Packages

`common/packages.nix` joins the package lists. The main ones are:

| File                | Contents                                                        |
| ------------------- | --------------------------------------------------------------- |
| `core.nix`          | zsh, starship, git, jujutsu, worktrunk, gh, tmux, gnupg         |
| `langs.nix`         | Rust, Go, Nix (alejandra), TS/JS (fnm, bun), Python (uv), pwsh  |
| `backend.nix`       | buf, protobuf, grpcurl, NATS, PostgreSQL, SQLite, DuckDB        |
| `cloud.nix`         | AWS, Azure, Kubernetes tools, Helm, Terraform, OpenTofu, Tilt   |
| `cli.nix`           | Confluent CLI, gh                                               |
| `observability.nix` | gcx, Datadog pup                                                |
| `docs.nix`          | mdbook, mdbook-mermaid                                          |
| `sandbox.nix`       | nono                                                            |
| `utils.nix`         | bat, eza, fzf, ripgrep, jq, yq, just, direnv, zoxide, and more  |

## Modules

| File           | Function                                                                         |
| -------------- | -------------------------------------------------------------------------------- |
| `zsh.nix`      | Zsh with autosuggestions, highlighting, completions, aliases, and helpers        |
| `starship.nix` | Prompt with git status on the left and AWS profile and kube context on the right |
| `ai.nix`       | Coding agents and their shared instructions                                      |
| `nono.nix`     | Links the nono profiles and makes the agent state directories                    |
| `ssh.nix`      | launchd `ssh-agent` with key loading at shell start, SSH host configuration      |
| `gpg.nix`      | `pinentry-mac` for `gpg-agent`                                                   |
| `git.nix`      | SSH commit signing and an allowed signers file for local verification            |

## Coding agents

`ai.nix` installs Claude Code, Codex, opencode, pi, GitHub Copilot CLI, and related tools.

The files in `common/context/` are the shared instructions for all agents:

- Claude Code: the files go to `~/.claude/` as one store directory, so that the `@file` imports in `CLAUDE.md` work.
- opencode: the files are joined into `~/.config/opencode/AGENTS.md`, because opencode has no import syntax.

Each agent runs in a [nono](https://nono.sh) sandbox. The profiles in `common/nono/profiles/` extend `agent-base.json`. The zsh aliases start each agent in its sandbox:

| Alias | Agent       | Without sandbox     |
| ----- | ----------- | ------------------- |
| `cc`  | Claude Code | `cc-unsandboxed`    |
| `cx`  | Codex       | `cx-unsandboxed`    |
| `oc`  | opencode    | `oc-unsandboxed`    |
| `pi`  | pi          | `pi-unsandboxed`    |

## Usage

```shell
just update        # Update the flake lock file (Neovim configuration, etc.)
just darwin        # Apply the configuration to the work laptop
just linux         # Apply the configuration to the personal system
just gc            # Remove generations older than 7 days and collect garbage
just gc 14 true    # Same, with 14 days, and optimise the store
just fmt           # Format the Nix files with alejandra
just nono-pull     # Install the nono registry packs that the profiles extend
just nono-validate # Validate the nono profiles
```

[pdeconfig]: https://github.com/VinceDeslo/pdeconfig.nvim
