# tinted-tuicr

[Tinted Theming](https://github.com/tinted-theming/home) integration for
[tuicr](https://github.com/agavra/tuicr) — a code review TUI.

Generates a tuicr local theme (UI colours + syntax highlighting) from the
active Tinty base16 scheme so that tuicr always matches your terminal
theme.

## How it works

`tinted-tuicr` reads the current scheme's palette from Tinty environment
variables (`TINTY_SCHEME_PALETTE_BASE*_HEX_*`, Tinty ≥ 0.29 required) and
writes two files:

| File | Purpose |
|------|---------|
| `~/.config/tuicr/themes/tinted.toml` | UI chrome — panel bg, borders, diff colours, status bar, badges, etc. |
| `~/.config/tuicr/themes/tinted.tmTheme` | Syntax highlighting for code inside diffs (TextMate format) |

These are regenerated every time you run `tinty apply <scheme>`.

## Setup

### 1. Install Tinty

```sh
# macOS
brew install tinted-theming/tap/tinty
```

### 2. Add tinted-tuicr to your Tinty config

In `~/.config/tinted-theming/tinty/config.toml`:

```toml
[[items]]
path = "https://github.com/body-clock/tinted-tuicr"
name = "tinted-tuicr"
hook = "bash ~/.local/share/tinted-theming/tinty/repos/tinted-tuicr/scripts/generate.sh"
themes-dir = "themes"
supported-systems = ["base16"]
```

### 3. Install and generate placeholders

```sh
tinty install
bash ~/.local/share/tinted-theming/tinty/repos/tinted-tuicr/scripts/generate-placeholders.sh
```

### 4. Configure tuicr

In `~/.config/tuicr/config.toml`:

```toml
theme = "tinted"
```

### 5. Apply a scheme

```sh
tinty apply base16-tokyo-night-dark
```

tuicr will now use `tinted` as its theme, which is regenerated on every
`tinty apply`.

## Colour mapping

Base16 colours are mapped to tuicr's ~42 UI keys following the standard
base16 semantic conventions:

| Base16 | Role | tuicr keys |
|--------|------|------------|
| base00 | Background | `panel_bg`, message/mode `_fg` (dark themes) |
| base01 | Lighter bg | `bg_highlight`, `status_bar_bg`, `cursor_line_bg` |
| base02 | Selection | `border_unfocused` |
| base03 | Comments | `fg_dim`, `expanded_context_fg`, `help_indicator` |
| base04 | Dark fg | `fg_secondary` |
| base05 | Foreground | `fg_primary`, `diff_context` |
| base08 | Red | `diff_del`, `file_deleted`, `comment_issue`, `message_error_bg` |
| base09 | Orange | `cursor_color`, `update_badge_bg` |
| base0A | Yellow | `file_modified`, `pending`, `message_warning_bg` |
| base0B | Green | `diff_add`, `file_added`, `reviewed`, `comment_praise` |
| base0C | Cyan | `border_focused`, `branch_name`, `comment_suggestion` |
| base0D | Blue | `diff_hunk_header`, `comment_note`, `message_info_bg`, `mode_bg` |
| base0E | Purple | `file_renamed` |
| base0F | Brown | (syntax deprecated scope) |

Diff and syntax backgrounds are blended: 20% colour on panel_bg for diff
add/del backgrounds, 16% for inline syntax highlight backgrounds (matching
tuicr's internal built-in theme derivation).

## License

MIT
