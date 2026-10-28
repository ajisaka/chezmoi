
SRCS := $(wildcard $(src/*.rs)) Cargo.lock Cargo.toml


watch:
	axe $(SRCS) README.md -- cargo test
