#!/usr/bin/env bash

# Configure base system

# Setup time
rm /etc/localtime || true
ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
hwclock --systohc

# Setup required locales

# Uncomment needed locales, f.e. en_DK.UTF-8.
sed -i 's/^#en_DK.UTF-8/en_DK.UTF-8/' /etc/locale.gen
# Generate locales.
locale-gen
# Create needed files.
echo "LANG=en_DK.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de-latin1" >> /etc/vconsole.conf

# Set hostname

hostname==$(gum input --placeholder "hostanme")
# Create the content
hosts_content="127.0.0.1   localhost
::1         localhost
127.0.1.1   $hostname.localdomain $hostname"
# Write the content to /etc/hosts
echo "$hosts_content" | sudo tee /etc/hosts > /dev/null

# Setup user

# Set root password first.
passwd
# Add your non-root user.
username=$(gum input --placeholder "username")
useradd -m -g users -G wheel -s /bin/bash $username
# Set your user password.
passwd $username
# Grant sudo permissions to your user.
echo "$username ALL=(ALL) ALL" > /etc/sudoers.d/$username

# Configure mkinitcpio

# Edit MODULES line
sed -i 's/^MODULES=.*/MODULES=(i915)/' /etc/mkinitcpio.conf
# Edit HOOKS line
sed -i 's/^HOOKS=.*/HOOKS=(base systemd autodetect modconf block keyboard sd-vconsole sd-encrypt filesystems fsck)/' /etc/mkinitcpio.conf
# Regenerate image.
mkinitcpio -p linux

# Setup bootloader

# Setup systemd boot.
bootctl --path=/boot install

disk_uuid=$(cryptsetup luksUUID "/dev/${DISK}p2")
# set arch.conf
arch_conf_content="title       Arch Linux
linux       /vmlinuz-linux
initrd      /intel-ucode.img
initrd      /initramfs-linux.img
options     rw luks.uuid=${disk_uuid} luks.name=${disk_uuid}=luks root=/dev/mapper/luks rootflags=subvol=root quiet mem_sleep_default=deep
"
# Write the content to /boot/loader/entries/arch.conf
echo "$arch_conf_content" | sudo tee /boot/loader/entries/arch.conf > /dev/null
# Set emergency.conf
emergency_conf_content="title         Emergency Mode
options       rw luks.uuid=${disk_uuid} luks.name=${disk_uuid}=luks root=/dev/mapper/luks rootflags=subvol=root quiet mem_sleep_default=deep systemd.unit=rescue.target
"
# Write the content to /boot/loader/entries/arch.conf
echo "$emergency_conf_content" | sudo tee /boot/loader/entries/emergency.conf > /dev/null
# Set loader.conf
loader_conf_content="default arch.conf
timeout 10
editor  0
"
# Write the content to /boot/loader/loader.conf
echo "$emergency_conf_content" | sudo tee /boot/loader/loader.conf > /dev/null
