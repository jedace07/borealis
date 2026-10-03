#!/usr/bin/env bash

set -euo pipefail

mimeapps=/usr/share/applications/mimeapps.list

if ! grep -q 'org\.mozilla\.firefox\.desktop' "$mimeapps"; then
  echo "Firefox default application entry not found in $mimeapps" >&2
  exit 1
fi

sed -i \
  -e 's/org\.mozilla\.firefox\.desktop/brave-browser.desktop/g' \
  -e 's/org\.gnome\.Evolution\.desktop/eu.betterbird.Betterbird.desktop/g' \
  -e 's/org\.gnome\.Calendar\.desktop/eu.betterbird.Betterbird.desktop/g' \
  -e 's/com\.system76\.CosmicPlayer\.desktop/io.github.diegopvlk.Cine.desktop/g' \
  -e 's/org\.gnome\.Totem\.desktop/io.github.diegopvlk.Cine.desktop/g' \
  -e 's/org\.gnome\.Rhythmbox3\.desktop/io.github.diegopvlk.Cine.desktop/g' \
  -e 's/org\.gnome\.Decibels\.desktop/io.github.diegopvlk.Cine.desktop/g' \
  -e 's/org\.gnome\.eog\.desktop/org.gnome.Loupe.desktop/g' \
  -e 's/com\.system76\.CosmicEdit\.desktop/org.gnome.TextEditor.desktop/g' \
  -e 's/org\.gnome\.gedit\.desktop/org.gnome.TextEditor.desktop/g' \
  "$mimeapps"
