# Linux Personal Setup

## Introduction

This document provides the items installed on a new linux configuration. I use a minimal Ubuntu server as a starting point. We install applications and tools under the user where we can and when most convenient.

We use container technology to keep the underlying system free from pacakge bloat.

### Assumptions
- Starting with a Ubuntu minimal server install
- Internet access
- Home partition allows execution bit on filesystem
- Have `root`/`sudo` access
- Knowledge of environment variables, permissions and file structure

### User Locations 101

| Item | Location | Notes |
|---:|:---:|:---|
| Fonts | `~/.local/shared/fonts` | Use `fc-cache -f -v` to refresh font cache after you install new fonts |
| Desktop Themes | `~/.local/shared/themes` |  |
| User Binaries | `~/.local/opt` and `~/.local/bin` | Single binaries go into `bin` while others should go into `opt/${pacakge}` and package binaries symlinked to `bin`. Have your `PATH` pointed to `bin` only. |
| Flatpak | `~/.var/app/${package}` | Flatpak installed application with the `--user` option. Use `Flatseal` if you need to expose real paths to Flatpak apps if required. |
| Profile Settings | `~/.profile` | This is read on **login** by both `bash` and `zsh` |
| Loutout Settings | `~/.logout` | This is read on **logout** by both `bash` and `zsh` |
| Bash Profile Settings | `~/.bash_profile` and `~/.bash_login` | This is read on **login** by `bash`. Use `~/.profile` to simplify login process. |
| Bash Run Commands | `~/.bashrc` | read on new terminal session by `bash` |
| Zsh Run Commands | `~/.zshrc` | read on new terminal session by `zsh` |

### Overview

- Install Desktop
- Install Flatpak and GUI applications
- Install CLI tools
- Remove pre-installed packages

## Desktop Manager

```
sudo apt install -y gdm3
```

Because we will install **Gnome Shell**, **GDM** is required to get a lock screen.

## Desktop Environment

```
sudo apt install -y \
    --no-install-recommends \
    xorg gnome-session gnome-shell gnome-tweak-tool \
    nautilus \
    seahorse seahorse-natalius
```

### Gnome Shell 

#### Extensions

I do not recommend using the apt packages for gnome extensions, they are almost all broken and the useful ones are not even in the apt repositories.

Install Extensions to `~/.local/share/gnome-shell/externsions/${UUID}`. The `${UUID}` can be found in the extension's `metadata.yml` file.

| Extension | Notes |
|---:|:---|
| User themes | Allows user themes in in `~/.local/share/themes` |
| Top indicator app | App notifications in top bar |
| Dash to Dock | OSX like application dock |
| Hide top bar | Allow top bar to hide |
| Openweather | Weather in the top bar |
| Screenshot tool | Screenshot via a top bar dropdown |
| Sound Input & output device chooser | Switch audio devices right from top bar |
| Bluetooth quick connect | Connect to bluetooth devices right from top bar |
| Cast to tv | Allow Cast protocol. This requires `node`, See `nvm` install below to use user installed node |
| Cast to tv - desktop stream add-on | Add-on to allow you yo cast your desktop |

## Application Management

We will use flakpak to install GUI applications without root.

```bash
sudo apt install -y flatpak
```

### Flatpak Repositories

We add both the stable and beta repositories

```bash
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
```

#### Flatpak Applications

Install all applications with the `--user` option.

```
flatpak --user install ${REPO} ${APP_ID}
```

| App | Repo | ID | Notes |
|:---:|:---:|:---|:---|
| `Flatseal` | `flathub` | `com.github.tchx84.Flatseal` | Permission control of flatkpak installed applications |
| `LibreOffice` | `flathub` | `org.libreoffice.LibreOffice` | Office suite |
| `VLC` | `flathub` | `org.videolan.VLC` | Video Player |

### CLI Tools

All CLI tools is to be installed in `~/.loca/opt` or `~/.local/bin`. Add `bin` to your `PATH` in `~/.profiles`.

```
if [ -d ${HOME}/.local/bin ]; do
    PATH="${HOME}/.local/bin;${PATH}"
fi
```

### ZSH

```
apt install -y zsh
```

Use Oh-my-zsh for collaborative configuration.

### Misc

```
apt install -y \
    unzip tmux jq
```

## Remove Unneeded Packages

### Snap

Personally, I believe Flatpak is a better applciation management tool. Since we don't want to use both Flatpak and Snap, we'll remove Snap.

First we need to locate all the install packages installed with snap
```
snap list
```

Remove installed packages, noting that some packages are required by others, so a for loop wouldn't necessary work.
```
sudo snap remove ${PACKAGE_NAME}
```

Finally we remove

```
sudo apt --purge -y snapd
```

### Server tools typically not used on Desktops

```
sudoa apt remove --purge -y \
    mdadm byobu screen
