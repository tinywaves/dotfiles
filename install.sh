#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ROOT_DIR

# shellcheck source=utils/utils.sh
source "$ROOT_DIR/utils/utils.sh"

sync_submodules() {
  if [[ -f "$ROOT_DIR/.gitmodules" ]]; then
    section "Submodules"
    if command -v make >/dev/null 2>&1; then
      info "Syncing submodules via make"
      make -C "$ROOT_DIR" submodule-sync
    else
      require_command git
      info "Syncing submodules to recorded commits"
      git -C "$ROOT_DIR" submodule update --init --recursive
    fi
  fi
}

run_module() {
  local module_path="$1"
  section "Module: $(basename "$module_path")"
  bash "$module_path"
}

run_module "$ROOT_DIR/modules/prereq/run.sh"
sync_submodules
# Ensure Homebrew is on PATH for subsequent modules, even when prereq ran in a subshell.
if brew_prefix="$(brew_prefix 2>/dev/null)"; then
  eval "$("$brew_prefix/bin/brew" shellenv)"
fi
run_module "$ROOT_DIR/modules/brew/run.sh"
run_module "$ROOT_DIR/modules/omz/run.sh"
run_module "$ROOT_DIR/modules/zshrc/run.sh"
run_module "$ROOT_DIR/modules/git/run.sh"

section "All Done"
info "Installation finished. Restart your terminal or run: exec zsh"
