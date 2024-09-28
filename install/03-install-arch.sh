#!/usr/bin/env bash

DISK="$1"

pacstrap /mnt \
  base \
  base-devel \
  git \
  intel-ucode \
  linux \
  linux-firmware \
  networkmanager \
  network-manager-applet \
  openssh \
  kitty \
  dunst \
  hyprland \
  rofi-wayland \
  waybar \
  zsh \
  thunar \
  xdg-desktop-portal-hyprland \
  qt5-wayland \
  qt6-wayland \
  hyprpaper \
  hyprlock \
  ttf-font-awesom \
  vim \
  fastfetch \
  ttf-fira-sans \
  ttf-fira-code \
  ttf-firacode-nerd \
  fuse2 \
  gtk4 \
  libadwaita \
  jq \
  gum

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

arch-chroot /mnt $SCRIPT_DIR/04-chroot-arch.sh "$DISK"
