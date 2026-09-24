# Maliit Dark Keyboard

A black theme, a settings window and tablet-mode fixes for the **Maliit on-screen keyboard** on
**KDE Plasma 5.27 (Wayland)**, made for 2-in-1 / convertible touchscreen laptops.

Tested on a Lenovo Yoga 6 13ALC7 with Zorin OS 18.

[Türkçe açıklama aşağıda](#türkçe)

## Features

- **Black keyboard** with softly rounded, bordered keys, so every key is easy to see.
- **Settings window** ("Keyboard Appearance"). Open it from the keyboard's language menu (**Settings…**) or from the app menu:
  - colors, border width, corner radius
  - row spacing, key spacing, keyboard height
  - number row on/off (works for every layout)
  - typing languages and default typing language
  - window language (English / Türkçe)
- **Tablet mode:** the keyboard appears when you fold the screen, and it hides by itself when you go back to laptop mode.
- **Dock fix:** on a touchscreen the pointer stays where you last tapped. That is usually the Enter key, right above the dock,
  so a dock such as Latte Dock stayed visible over the window. When the keyboard closes in tablet mode, the pointer is now
  moved to the middle of the screen.
- **Latte Dock zoom off in tablet mode:** a finger tap left the tapped icon zoomed (touch never sends a "pointer left"), and
  the oversized icon could get cut off and look like it vanished. The parabolic zoom is now switched off in tablet mode and
  restored in laptop mode (Latte restarts for a couple of seconds on each switch).
- **Working "Settings…" button:** Maliit's own Settings menu entry did nothing on the desktop. It now opens the settings window.
- The screen-rotation animation is turned off, so rotation happens instantly.

## Install

Open a terminal (for example Konsole) and run:

```sh
sudo apt install git
git clone https://github.com/onurhanerk/maliit-dark-keyboard.git
cd maliit-dark-keyboard
./install.sh
```

The installer asks for your password to install the required packages. When it finishes, **log out and log back in**.

To update, run this in the same folder:

```sh
git pull
./install.sh
```

Your color settings are kept.

## Uninstall

```sh
./uninstall.sh
```

## Requirements

- KDE Plasma 5.27, Wayland session
- A Debian / Ubuntu based distribution (Zorin OS, Kubuntu, KDE neon, …), 64-bit x86
- Maliit keyboard 2.3 (the installer installs it)

## Installed files

| File | Purpose |
|---|---|
| `~/.local/bin/maliit-keyboard-dark` | Starts Maliit with the dark style and your settings |
| `~/.local/bin/maliit-siyah-ayarlar` | Settings window |
| `~/.local/bin/maliit-rakam-satiri` | Adds the number row to the keyboard layouts |
| `~/.local/bin/maliit-settings-url` | Sends Maliit's "Settings…" entry to the settings window |
| `~/.local/bin/maliit-tablet-izle` | Watches tablet mode and the keyboard (starts at login) |
| `~/.local/bin/imlec-tasi` | Moves the pointer to a screen position (KWin fake input) |
| `~/.local/share/maliit-siyah/style/` | Key look (QML style) |
| `~/.config/maliit-siyah/stil.conf` | Your settings |

## Notes

- Touch scrolling in Konsole and other Qt apps works with **one finger**. Two-finger scrolling on the touchscreen is not supported.
- Settings take effect when you press **Apply**, which restarts the keyboard through KWin. Do not restart Maliit with
  `pkill`: KWin counts that as a crash, and after 5 crashes it stops starting the keyboard until you log in again.

## License

MIT

---

## Türkçe

KDE Plasma 5.27 (Wayland) için, dokunmatik ekranlı 2'si 1 arada dizüstü bilgisayarlarda Maliit sanal klavyesine siyah tema,
ayar penceresi ve tablet modu düzeltmeleri.

**Özellikler:** yuvarlak köşeli, çerçeveli siyah tuşlar; renk, satır/tuş aralığı, klavye yüksekliği, rakam satırı ve yazma
dilleri için ayar penceresi (Türkçe / English); ekran katlanınca açılan, dizüstü moduna dönünce kapanan klavye; klavye
kapandığında dock'un pencerenin üstünde açık kalması sorununa düzeltme; tablet modunda Latte Dock'un büyütme efektini kapatma (dokununca simge büyük kalıyordu); çalışan "Ayarlar…" menüsü; animasyonsuz ekran döndürme.

**Kurulum:** bir terminal aç ve şunları yaz:

```sh
sudo apt install git
git clone https://github.com/onurhanerk/maliit-dark-keyboard.git
cd maliit-dark-keyboard
./install.sh
```

Kurulum bitince oturumu kapatıp yeniden aç. Güncellemek için aynı klasörde `git pull` ve `./install.sh`, kaldırmak için
`./uninstall.sh` yeterli. Ayarlar, klavyenin dil menüsündeki **Ayarlar…** ya da uygulama menüsündeki **Klavye Görünümü** ile açılır.
