#!/usr/bin/env bash
set -euo pipefail

line() {
  printf '%*s\n' "${COLUMNS:-80}" '' | tr ' ' '='
}

section() {
  line
  printf "== %s\n" "$1"
  line
}

info() { printf "[INFO] %s\n" "$1"; }
warn() { printf "[WARN] %s\n" "$1"; }

die() {
  printf "[ERROR] %s\n" "$1" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

is_macos() {
  [[ "$(uname -s)" == "Darwin" ]]
}

brew_prefix() {
  if command -v brew >/dev/null 2>&1; then
    brew --prefix
  else
    if [[ -x /opt/homebrew/bin/brew ]]; then
      /opt/homebrew/bin/brew --prefix
    elif [[ -x /usr/local/bin/brew ]]; then
      /usr/local/bin/brew --prefix
    else
      return 1
    fi
  fi
}
