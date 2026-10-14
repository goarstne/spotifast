#!/bin/bash
# Installs Spotifast Omarchy theme integration (template and hook)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMED_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/omarchy/themed"
HOOKS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/omarchy/hooks/theme-set.d"
LOCAL_SHARE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/spotifast/omarchy"

echo "Installing Spotifast Omarchy template and hook..."
mkdir -p "$THEMED_DIR" "$HOOKS_DIR" "$LOCAL_SHARE_DIR"

install -m 644 "$SCRIPT_DIR/spotifast.json.tpl" "$THEMED_DIR/spotifast.json.tpl"
install -m 755 "$SCRIPT_DIR/spotifast-theme" "$HOOKS_DIR/spotifast-theme"
install -m 644 "$SCRIPT_DIR/spotifast.json.tpl" "$LOCAL_SHARE_DIR/spotifast.json.tpl"
install -m 755 "$SCRIPT_DIR/spotifast-theme" "$LOCAL_SHARE_DIR/spotifast-theme"

# Render current theme if omarchy theme is active
if [[ -f "$HOME/.local/state/omarchy/current/theme/colors.toml" ]]; then
  echo "Generating initial palette for current theme..."
  themes_dir="${XDG_CONFIG_HOME:-$HOME/.config}/spotifast/themes"
  mkdir -p "$themes_dir"
  if command -v omarchy >/dev/null 2>&1; then
    omarchy theme set "$(omarchy theme current)" >/dev/null 2>&1 || true
  fi
fi

echo "Spotifast Omarchy theme integration installed successfully."
