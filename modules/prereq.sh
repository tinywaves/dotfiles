#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/utils.sh
source "$ROOT_DIR/utils/utils.sh"

if ! is_macos; then
  die "This setup targets macOS only."
fi

if ! command -v xcode-select >/dev/null 2>&1; then
  warn "xcode-select not found. Please install Xcode Command Line Tools."
else
  if ! xcode-select -p >/dev/null 2>&1; then
    warn "Xcode Command Line Tools not installed. Run: xcode-select --install"
  else
    info "Xcode Command Line Tools detected."
  fi
fi

if command -v brew >/dev/null 2>&1; then
  info "Homebrew already installed."
  exit 0
fi

info "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  die "Homebrew installation did not finish as expected."
fi

info "Homebrew installation complete."
