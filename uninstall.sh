#!/bin/sh
# Removes Maliit Dark Keyboard and switches back to the stock Maliit keyboard.
# Your settings (~/.config/maliit-siyah) and the maliit-keyboard package are kept.
set -e

BIN="$HOME/.local/bin"
APPS="$HOME/.local/share/applications"

rm -f "$BIN/maliit-keyboard-dark" "$BIN/maliit-rakam-satiri" "$BIN/maliit-settings-url" \
      "$BIN/maliit-siyah-ayarlar" "$BIN/maliit-tablet-izle" "$BIN/imlec-tasi"
rm -f "$APPS/maliit-dark.desktop" "$APPS/maliit-settings-url.desktop" "$APPS/imlec-tasi.desktop" \
      "$APPS/maliit-siyah-ayarlar.desktop" "$HOME/.config/autostart/maliit-tablet-izle.desktop"
rm -rf "$HOME/.local/share/maliit-siyah" "$HOME/.local/share/maliit/keyboard2/devices/tablet.json"

kwriteconfig5 --file kwinrc --group Wayland --key InputMethod /usr/share/applications/com.github.maliit.keyboard.desktop
sed -i '/=maliit-settings-url.desktop$/d' "$HOME/.config/mimeapps.list" 2>/dev/null || true
update-desktop-database "$APPS" 2>/dev/null || true
kbuildsycoca5 >/dev/null 2>&1 || true

echo "Removed. Log out and back in. / Kaldırıldı. Oturumu kapatıp yeniden aç."
