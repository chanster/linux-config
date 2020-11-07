# Linux Personal Setup

This document provides the items installed on a new linux configuration. Though I use a base Ubuntu server as a starting point, this should also work for **Arch** and **Fedora**.

## Assumptions
- Starting with a minimal server install
- Internet access

## Desktop Manager

```
sudo apt install -y gdm3
```

Because we will install Gnome Shell, **GDM** is required to get a lock screen.

## Desktop Environment

```
sudo apt install -y \
    --no-install-recommends \
    xorg gnome-session gnome-shell gnome-tweaks
```

### Gnome Shell 

#### Extensions

Install Extensions to `~/.local/share/gnome-shell/externsions/${UUID}`

The `${UUID}` can be found in the extension's `metadata.yml` file.

- User themes
- Top indicator app
- Dash to Dock
- Hide top bar
- Openweather
- Screenshot tool
- Sound Input & output device chooser
- Bluetooth quick connect
- Cast to tv
- Cast to tv - desktop stream add-on

## Application Management

We will use flakpak to install applications without root.

```bash
sudo apt install -y flatpak
```

### Flatpak Repositories

We add both the stable and beta repositories

```bash
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
```

### Applications

Install all applications with the `--user` option.

```
flatpak --user install ${REPO} ${APP_ID}
```

| App | Repo | ID | Notes |
|:---:|:---:|:---|:---|
| `Flatseal` | `flathub` | `com.github.tchx84.Flatseal` | Permission control of flatkpak installed applications |
| `LibreOffice` | `flathub` | `org.libreoffice.LibreOffice` | Office suite |
| `VLC` | `flathub` | `org.videolan.VLC` | Video Player |

