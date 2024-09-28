#!/usr/bin/env bash

DISK="$1"

# set keyboard to german layout
loadkeys de-latin1

# Create partition table and partitions
(
echo g # Create a new empty GPT partition table
echo n # Add a new partition (EFI)
echo 1 # Partition number
echo   # First sector (default)
echo +512M # Last sector (512MB)
echo t # Change partition type
echo 1 # EFI System
echo n # Add a new partition (Linux)
echo 2 # Partition number
echo   # First sector (default)
echo   # Last sector (default - use remaining space)
echo w # Write changes
) | fdisk $DISK

# Format EFI partition
mkfs.fat -F32 ${DISK}p1

# Sync clock
timedatectl set-ntp true

# Format and encrypt btrfs
cryptsetup luksFormat --type=luks2 ${DISK}p2
cryptsetup open /dev/${DISK}p2 luks
mkfs.btrfs -L luks /dev/mapper/luks

# Create btrfs subvolumes
mount -t btrfs /dev/mapper/luks /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/snapshots

# Mount btrfs subvolumes
umount /mnt
mount -o subvol=root /dev/mapper/luks /mnt
mkdir /mnt/{home,.snapshots}
mount -o subvol=home /dev/mapper/luks /mnt/home
mount -o subvol=snapshots /dev/mapper/luks /mnt/.snapshots

# Mount EFI partition
mkdir /mnt/boot
mount /dev/${DISK}p1 /mnt/boot

# Install the base system and a few packages

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$SCRIPT_DIR/03-install-arch.sh "$DISK"

