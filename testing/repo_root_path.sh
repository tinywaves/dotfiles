#!/bin/bash

set -e

source "fn.sh"

REPO_ROOT_PATH="$(cd "$(dirname "$0")" && pwd)"
# echo "$REPO_ROOT_PATH"
source "$REPO_ROOT_PATH/sub_script.sh"
