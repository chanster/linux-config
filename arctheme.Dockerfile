FROM ubuntu:22.04

RUN apt update && apt upgrade -y
RUN apt install --no-install-recommends gnome-shell cinnamon -y
RUN apt install meson sassc libglib2.0-dev-bin inkscape -y

RUN git clone https://github.com/jnsh/arc-theme --depth 1
RUN meson setup --prefix=$HOME/.local -Dvariants=light,darker,dark,lighter -Dthemes=gnome-shell,gtk3,gtk4 build/
RUN meson install -C build/
