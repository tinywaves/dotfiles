#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/utils.sh
source "$ROOT_DIR/utils/utils.sh"

if ! command -v brew >/dev/null 2>&1; then
  die "Homebrew not found. Run the prereq module first."
fi

info "Updating Homebrew..."
brew update

info "Installing packages from brewfile..."
brew bundle --file "$ROOT_DIR/modules/brew/brewfile"

info "Homebrew packages installed."
