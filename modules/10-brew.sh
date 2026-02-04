#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/lib.sh
source "$ROOT_DIR/utils/lib.sh"

if ! command -v brew >/dev/null 2>&1; then
  die "Homebrew not found. Run the prereq module first."
fi

info "Updating Homebrew..."
brew update

info "Installing packages from Brewfile..."
brew bundle --file "$ROOT_DIR/Brewfile"

info "Homebrew packages installed."
