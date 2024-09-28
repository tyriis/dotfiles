#!/usr/bin/env bash

# Install gum
pacman -S gum

# Get disk information
disks=$(lsblk -ndo NAME,SIZE,MODEL)

# Prepare options for gum
options=""
while IFS= read -r line; do
    name=$(echo "$line" | awk '{print $1}')
    size=$(echo "$line" | awk '{print $2}')
    model=$(echo "$line" | awk '{$1=$2=""; print $0}' | sed 's/^ *//')
    options+="/dev/$name ($size) - $model\n"
done <<< "$disks"

# Remove trailing newline
options=$(echo -e "$options" | sed '$d')

# Let user choose disk
selected=$(echo -e "$options" | gum choose --height 20 --limit 1 --header="Select a disk for installation:")

# Extract disk name from selection
disk_name=$(echo "$selected" | awk '{print $1}')

echo "You selected: $disk_name"

# Use $disk_name for further installation steps

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$SCRIPT_DIR/02-echo-install-disk.sh "$disk_name"
