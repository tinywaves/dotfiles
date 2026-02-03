#!/bin/bash

set -e
print_section_header "Homebrew"

if ! command -v brew &> /dev/null; then
  echo "📦 No Homebrew detected, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "✅ Homebrew installed"
else
  echo "✅ Homebrew already installed"
fi

print_divider_line

echo "📦 Installing packages from brewfile..."
brew bundle --file="brewfile"
echo "✅ Packages installed from brewfile"

print_divider_line

echo "✅ Homebrew setup complete"
