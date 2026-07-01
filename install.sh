#!/usr/bin/env bash
set -euo pipefail

DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/fonts"

# Configs
mv "$DOTS_DIR/foot" "$HOME/.config/"
mv "$DOTS_DIR/mpd" "$HOME/.config/"
mv "$DOTS_DIR/ncmpcpp" "$HOME/.config/"
mv "$DOTS_DIR/nvim" "$HOME/.config/"
mv "$DOTS_DIR/rofi" "$HOME/.config/"
mv "$DOTS_DIR/sway" "$HOME/.config/"
mv "$DOTS_DIR/wal" "$HOME/.config/"
mv "$DOTS_DIR/waybar" "$HOME/.config/"
mv "$DOTS_DIR/yazi" "$HOME/.config/"

# Bash
mv "$DOTS_DIR/.bashrc" "$HOME/.bashrc"

# Local files
cp -rf "$DOTS_DIR/.local/bin/." "$HOME/.local/bin/"
cp -rf "$DOTS_DIR/.local/share/applications/." "$HOME/.local/share/applications/"
cp -rf "$DOTS_DIR/.local/fonts/." "$HOME/.local/share/fonts/"

fc-cache -fv

echo "Dotfiles installed."
