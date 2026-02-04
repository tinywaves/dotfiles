#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/lib.sh
source "$ROOT_DIR/utils/lib.sh"

if ! command -v gpg >/dev/null 2>&1; then
  warn "gpg not found. Install via Homebrew (gnupg) then re-run this module."
  exit 0
fi

info "Checking for existing GPG keys..."
if gpg --list-secret-keys --keyid-format=long | grep -q "sec"; then
  info "GPG keys found."
else
  read -r -p "No GPG keys found. Generate one now? [y/N] " resp
  if [[ "$resp" =~ ^[Yy]$ ]]; then
    gpg --full-generate-key
  else
    warn "Skipped GPG key generation."
  fi
fi

info "Available secret keys:"
gpg --list-secret-keys --keyid-format=long

read -r -p "Enter GPG key ID to use for git signing (or press Enter to skip): " key_id
if [[ -n "$key_id" ]]; then
  git config --global user.signingkey "$key_id"
  git config --global commit.gpgsign true
  info "Configured git to sign commits with $key_id"
else
  warn "Skipped git GPG configuration."
fi
