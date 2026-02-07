#!/usr/bin/env bash
set -euo pipefail

# Auto-detect ROOT_DIR if not already set
# This allows modules to run independently without relying on install.sh
if [[ -z "${ROOT_DIR:-}" ]]; then
  # Try to find project root by looking for .gitmodules directory
  _current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  while [[ "$_current_dir" != "/" ]]; do
    if [[ -f "$_current_dir/.gitmodules" ]]; then
      ROOT_DIR="$_current_dir"
      break
    fi
    _current_dir="$(dirname "$_current_dir")"
  done

  # Fallback: assume utils.sh parent is the root
  if [[ -z "${ROOT_DIR:-}" ]]; then
    ROOT_DIR="$(dirname "$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")")"
  fi

  export ROOT_DIR
fi

line() {
  printf '%*s\n' "${COLUMNS:-80}" '' | tr ' ' '='
}

section() {
  line

  local total_cols=${COLUMNS:-80}
  local title=" $1 "
  local title_len=${#title}
  local eq_count=$((total_cols - title_len))
  local left_eq=$((eq_count / 2))
  local right_eq=$((eq_count - left_eq))

  printf '%*s' "$left_eq" '' | tr ' ' ' '
  printf '%s' "$title"
  printf '%*s\n' "$right_eq" '' | tr ' ' ' '

  line
}

info() { printf "[INFO] %s\n" "$1"; }
warn() { printf "[WARN] %s\n" "$1"; }

die() {
  printf "[ERROR] %s\n" "$1" >&2
  exit 1
}

prompt_value() {
  local prompt="$1"
  local default_value="${2:-}"
  local value=""

  while [[ -z "$value" ]]; do
    if [[ -n "$default_value" ]]; then
      read -r -p "$prompt" value
      if [[ -z "$value" ]]; then
        value="$default_value"
      fi
    else
      read -r -p "$prompt" value
      if [[ -z "$value" ]]; then
        warn "Value is required."
      fi
    fi
  done
  printf '%s' "$value"
}

escape_sed_replacement() {
  printf '%s' "$1" | sed -e 's/[\\&|]/\\&/g'
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
