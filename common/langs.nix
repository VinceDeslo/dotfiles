{pkgs}:
with pkgs; [
  # Rust
  cargo
  clippy
  rustc
  rust-analyzer
  rustfmt

  # Golang
  go
  golangci-lint
  delve

  # Nix
  alejandra

  # TS/JS
  fnm
  bun

  # Python
  uv
  (python3.withPackages (pythonPackages:
    with pythonPackages; [
      pip
      mlx
    ]))
]
