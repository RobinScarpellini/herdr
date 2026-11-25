#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.cargo/bin:$PATH"
export ZIG="${ZIG:-$HOME/.local/share/zig/zig-x86_64-linux-0.16.0/zig}"
export CARGO_TARGET_DIR="${CARGO_TARGET_DIR:-/tmp/herdr-build-target}"
export ZIG_LOCAL_CACHE_DIR="${ZIG_LOCAL_CACHE_DIR:-/tmp/herdr-zig-local}"
export ZIG_GLOBAL_CACHE_DIR="${ZIG_GLOBAL_CACHE_DIR:-/tmp/herdr-zig-global}"

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN="${HERDR_INSTALL_BIN:-$HOME/.local/bin/herdr}"

mkdir -p "$CARGO_TARGET_DIR" "$ZIG_LOCAL_CACHE_DIR" "$ZIG_GLOBAL_CACHE_DIR" "$(dirname "$BIN")"
rm -rf "$SRC/vendor/libghostty-vt/.zig-cache"

cd "$SRC"
cargo build --release

# Atomic replace so a running herdr binary is never overwritten in place (ETXTBSY).
install -m 700 "$CARGO_TARGET_DIR/release/herdr" "$BIN.new"
mv -f "$BIN.new" "$BIN"

"$BIN" --version
"$BIN" config check
echo "Installed patched herdr -> $BIN"
