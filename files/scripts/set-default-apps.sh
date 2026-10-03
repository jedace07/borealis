#!/usr/bin/env bash

set -euo pipefail

mimeapps=/usr/share/applications/mimeapps.list

if ! grep -q 'org\.mozilla\.firefox\.desktop' "$mimeapps"; then
  echo "Firefox default application entry not found in $mimeapps" >&2
  exit 1
fi

sed -i 's/org\.mozilla\.firefox\.desktop/brave-browser.desktop/g' "$mimeapps"
