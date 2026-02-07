#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ROOT_DIR

# shellcheck source=utils/utils.sh
source "$ROOT_DIR/utils/utils.sh"

show_usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [MODULE]

Run a dotfiles module independently.

Arguments:
  MODULE          Name of the module to run (e.g., brew, git, zshrc)

Options:
  -l, --list      List all available modules
  -h, --help      Show this help message

Examples:
  $(basename "$0") brew          # Run the brew module
  $(basename "$0") --list        # List all modules

Available modules:
  prereq    - Prerequisites (macOS check, Xcode, Homebrew)
  brew      - Homebrew packages
  omz       - Oh My Zsh
  zshrc     - Zsh configuration
  git       - Git configuration
  rime      - Rime input method

EOF
}

list_modules() {
  section "Available Modules"
  for module_dir in "$ROOT_DIR/modules"/*; do
    if [[ -d "$module_dir" ]]; then
      module_name="$(basename "$module_dir")"
      run_script="$module_dir/run.sh"

      if [[ -f "$run_script" ]]; then
        status="[OK]"
      else
        status="[MISSING run.sh]"
      fi

      printf "  %-12s %s\n" "$module_name" "$status"
    fi
  done
}

run_module() {
  local module_name="$1"
  local module_path="$ROOT_DIR/modules/$module_name/run.sh"

  if [[ ! -f "$module_path" ]]; then
    die "Module not found: $module_name"
  fi

  section "Module: $module_name"
  bash "$module_path"
}

# Parse arguments
if [[ $# -eq 0 ]]; then
  show_usage
  exit 0
fi

case "${1:-}" in
  -l|--list)
    list_modules
    exit 0
    ;;
  -h|--help)
    show_usage
    exit 0
    ;;
  *)
    run_module "$1"
    ;;
esac
