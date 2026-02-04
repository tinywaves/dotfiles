#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ROOT_DIR

# shellcheck source=utils/lib.sh
source "$ROOT_DIR/utils/lib.sh"

run_module() {
  local module_path="$1"
  section "Module: $(basename "$module_path")"
  bash "$module_path"
}

run_module "$ROOT_DIR/modules/00-prereq.sh"
run_module "$ROOT_DIR/modules/10-brew.sh"
run_module "$ROOT_DIR/modules/20-omz.sh"
run_module "$ROOT_DIR/modules/30-zshrc.sh"
run_module "$ROOT_DIR/modules/40-git.sh"
run_module "$ROOT_DIR/modules/50-gpg.sh"
run_module "$ROOT_DIR/modules/60-nvm-node.sh"

section "All Done"
info "Installation finished. Restart your terminal or run: exec zsh"
