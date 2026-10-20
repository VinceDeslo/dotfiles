{pkgs}:
with pkgs; [
  protobuf
  protoc-gen-go
  protoc-gen-es
  buf
  pgformatter
  duckdb
  sqlite
  nats-server
  natscli
]
