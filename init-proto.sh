#!/bin/bash
set -e

# Project root
ROOT_DIR=$(pwd)

echo "📦 Initializing proto project at $ROOT_DIR"

# Create folder structure
mkdir -p proto/service proto/common proto/google
mkdir -p generated/go generated/js generated/python generated/java

# Create stub .proto files
cat >proto/service/user.proto <<EOL
syntax = "proto3";

package service;

message User {
  string id = 1;
  string name = 2;
  string email = 3;
}
EOL

cat >proto/service/auth.proto <<EOL
syntax = "proto3";

package service;

message LoginRequest {
  string email = 1;
  string password = 2;
}

message LoginResponse {
  string token = 1;
}
EOL

cat >proto/service/booking.proto <<EOL
syntax = "proto3";

package service;

message Booking {
  string id = 1;
  string user_id = 2;
  string date = 3;
}
EOL

cat >proto/common/types.proto <<EOL
syntax = "proto3";

package common;

message Pagination {
  int32 page = 1;
  int32 size = 2;
}
EOL

cat >proto/common/errors.proto <<EOL
syntax = "proto3";

package common;

message Error {
  int32 code = 1;
  string message = 2;
}
EOL

# Buf configs
cat >buf.yaml <<EOL
version: v1
name: "example.com/proto"
deps:
  - buf.build/googleapis/googleapis
breaking:
  use:
    - FILE
lint:
  use:
    - DEFAULT
EOL

cat >buf.gen.yaml <<EOL
version: v1
plugins:
  - name: go
    out: generated/go
  - name: go-grpc
    out: generated/go
  - name: js
    out: generated/js
  - name: grpc-web
    out: generated/js
    opt:
      - import_style=typescript
      - mode=grpcwebtext
EOL

# Makefile
cat >Makefile <<'EOL'
PROTO_SRC=proto
OUT_DIR=generated

proto-gen:
	buf generate

proto-lint:
	buf lint

proto-breaking:
	buf breaking --against '.git#branch=main'
EOL

echo "✅ Proto project structure created successfully!"
