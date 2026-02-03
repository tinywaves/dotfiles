#!/bin/bash

# Print section header
print_section_header() {
  local title = "$1"
  local width = 60
  local padding = $(((width - ${#title} - 2) / 2))

  echo ""
  printf '%*s' "$width" '' | tr ' ' '═'
  echo ""
  printf "%*s%s%*s\n" $padding '' "$title" $padding ''
  printf '%*s' "$width" '' | tr ' ' '═'
  echo ""
}
