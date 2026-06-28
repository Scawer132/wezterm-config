# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A WezTerm terminal emulator configuration built around a **ConfigBuilder** pattern — config options are composed by appending module results in `wezterm.lua`, with a duplicate-key warning guard.

## Commands

- **Format**: `stylua .` (uses StyLua with Lua 5.4 syntax, 3-space indent, single quotes)
- **Check formatting**: `stylua -g '!/config/init.lua' --check wezterm.lua colors/ config/ events/ utils/`
- **Lint**: `luacheck wezterm.lua colors/* config/* events/* utils/*`
- **CI**: GitHub Actions runs format check + lint on push/PR to master

## Architecture

### Entry Point
`wezterm.lua` — orchestrates setup: requires event modules (tab-title, left-status, right-status, new-tab-button, gui-startup), and returns composed config via `Config:init():append(...)`.

### Config Modules (`config/`)
Each returns a `Config`-compatible options table. Loaded in `wezterm.lua`:
- `init.lua` — ConfigBuilder class with `:init()` and `:append(new_options)` (warns on duplicate keys)
- `appearance.lua` — GPU adapter, background, colors, cursor, tab bar, window padding/behavior
- `bindings.lua` — Key mappings with platform-aware `SUPER`/`SUPER_REV` mods, key tables (resize_font, resize_pane), mouse bindings
- `fonts.lua` — Font family + size (platform-dependent default), FreeType render settings
- `general.lua` — Scrollback, bell, auto-reload, hyperlink rules
- `launch.lua` — `default_prog` + `launch_menu` per platform (pwsh on Windows, fish on macOS/Linux)
- `domains.lua` — SSH, WSL, Unix domain configs per platform

### Event Handlers (`events/`)
Registered via `wezterm.on()`, each exports a `setup(opts?)` function with validated options:
- `tab-title.lua` — Custom tab titles with prefix icons (admin/WSL/debug/launcher), progress indicators, unseen output badge, tab locking/renaming
- `left-status.lua` — Shows active key table or leader key indicator
- `right-status.lua` — Date/time + battery info with Nerd Font icons
- `new-tab-button.lua` — Right-click launches InputSelector with launch menu + all domains
- `gui-startup.lua` — Spawns and maximizes the initial window

### Utilities (`utils/`)
- `cells.lua` — FormatItem builder for `wezterm.format`. Core abstraction: segments with text/colors/attributes + nested segments for composite items. Used by all status/event modules.
- `gpu-adapter.lua` — Enumerates GPUs, scores by device type (Discrete > Integrated > Other > CPU) and backend (Dx12 > Vulkan > GL on Windows), picks best
- `opts-validator.lua` — Schema-based options validator with type checking, enums, required fields
- `platform.lua` — Detects `is_win`/`is_linux`/`is_mac` from `wezterm.target_triple`
- `str.lua` — `starts_with` / `ends_with` string helpers
- `math.lua` — `clamp` / `round` number helpers

### Colors (`colors/`)
- `custom.lua` — Modified Catppuccin Mocha with custom ANSI/bright colors and tab bar colors

### Key Patterns
- **Platform branching**: `if platform.is_win then ... elseif platform.is_mac then ...`
- **Modifier abstraction**: `SUPER` (Alt on Win/Linux, Super on Mac) and `SUPER_REV` (Alt+Ctrl on Win/Linux, Super+Ctrl on Mac)
- **Cells segment system**: Shared `Cells` instance per event module, segments identified by integer IDs, rendered in defined order via `render({1, 2, 3})`
- **Options validation**: Event setup options validated via `OptsValidator` with defaults applied on invalid input

### Backdrop Images
Place images in `backdrops/` (jpg/jpeg/png/gif/bmp/ico/tiff/pnm/dds/tga). Background is statically set in `appearance.lua` — change the filename there to use a different image.
