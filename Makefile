PROTO_SRC=proto
OUT_DIR=generated

proto-gen:
	buf generate

proto-lint:
	buf lint

proto-breaking:
	buf breaking --against '.git#branch=main'
