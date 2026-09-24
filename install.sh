#!/bin/sh
# Installs Maliit Dark Keyboard. Usage: ./install.sh  (Maliit siyah klavye kurulumu)
# For KDE Plasma 5.27 (Wayland) on Debian/Ubuntu based systems.
set -e
cd "$(dirname "$0")"

BIN="$HOME/.local/bin"
APPS="$HOME/.local/share/applications"
SHARE="$HOME/.local/share/maliit-siyah"
CONF="$HOME/.config/maliit-siyah"
AUTOSTART="$HOME/.config/autostart"

echo "==> Installing required packages (your password may be asked) / Gerekli paketler kuruluyor"
sudo apt-get install -y maliit-keyboard python3-pyqt5 qml-module-qt-labs-settings \
    qml-module-qtquick-controls2 qml-module-qtquick-templates2 libkf5config-bin \
    libglib2.0-bin qtchooser libwayland-client0 gcc

echo "==> Copying files / Dosyalar kopyalanıyor"
mkdir -p "$BIN" "$APPS" "$SHARE/style/MaliitSiyah" "$CONF" "$AUTOSTART"
for f in bin/*; do
    install -m 755 "$f" "$BIN/"
done
sed "s|@HOME@|$HOME|g" style/MaliitSiyah/ToolButton.qml > "$SHARE/style/MaliitSiyah/ToolButton.qml"
for f in applications/*.desktop; do
    sed "s|@HOME@|$HOME|g" "$f" > "$APPS/$(basename "$f")"
done
sed "s|@HOME@|$HOME|g" autostart/maliit-tablet-izle.desktop > "$AUTOSTART/maliit-tablet-izle.desktop"
# Var olan ayarları ezme
[ -f "$CONF/stil.conf" ] || cp config/stil.conf "$CONF/stil.conf"

echo "==> Building pointer mover / İmleç taşıyıcı derleniyor"
gcc -O2 -o "$BIN/imlec-tasi" src/imlec-tasi.c /usr/lib/x86_64-linux-gnu/libwayland-client.so.0

echo "==> Configuring KDE / KDE ayarları yapılıyor"
# Sanal klavye olarak siyah Maliit, tablet modu otomatik
kwriteconfig5 --file kwinrc --group Wayland --key InputMethod "$APPS/maliit-dark.desktop"
kwriteconfig5 --file kwinrc --group Wayland --key VirtualKeyboardEnabled true
kwriteconfig5 --file kwinrc --group Input --key TabletMode auto
# Ekran dönerken animasyon olmasın
kwriteconfig5 --file kwinrc --group Plugins --key screentransformEnabled false
# Maliit'in "Ayarlar…" menüsü klavye ayar penceresini açsın
xdg-mime default maliit-settings-url.desktop x-scheme-handler/settings
xdg-mime default maliit-settings-url.desktop x-scheme-handler/systemsettings
gsettings set org.maliit.keyboard.maliit device tablet 2>/dev/null || true
update-desktop-database "$APPS" 2>/dev/null || true
kbuildsycoca5 >/dev/null 2>&1 || true

echo
echo "Done. Log out and back in (or reboot). / Kurulum bitti. Oturumu kapatıp yeniden aç."
echo "Settings: 'Keyboard Appearance' in the app menu, or keyboard language menu > Settings…"
