# herdr (Linux fork)

Personal Linux-focused fork of [herdrdev/herdr](https://github.com/herdrdev/herdr), stripped of non-Linux packaging, website docs, and upstream CI boilerplate.

## Custom additions
- `[ui.sidebar.agents].group_gap`: unhighlighted blank line count between different workspaces while keeping sibling agents in the same workspace flush (`row_gap = 0`).
- `[ui.sidebar.agents].highlight_workspace`: highlights all agents in the active workspace together when any agent in that workspace is focused.
- `[ui.sidebar.spaces].show_footer_buttons`: toggles the `new` and `menu` footer labels independently of `mouse_capture`.
- Built-in `darcula` theme (JetBrains Darcula palette).
- Dynamic host terminal palette sync (`OSC 10/11/12/4`): automatically adapts Kitty / host terminal background, foreground, cursor, and 16 ANSI colors live whenever the Herdr theme changes (including live preview and SSH), and resets cleanly (`OSC 110/111/112/104`) on detach.

## Build & install (Linux)
Requires Rust (see `rust-toolchain.toml`) and Zig `0.16.0` (for vendored `libghostty-vt`).

```bash
./scripts/build-install.sh
```

The build script places Cargo/Zig caches in `/tmp` (avoiding `renameat2(RENAME_NOREPLACE)` failures on NFS home mounts) and atomically installs `~/.local/bin/herdr`. Detach (`Ctrl+Shift+Q`) and re-run `herdr` to attach with the newly built client.
