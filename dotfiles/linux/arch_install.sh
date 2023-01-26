#!/usr/bin/env bash

# Installation script for Arch Linux
# Loosely follows the https://wiki.archlinux.org/title/Installation_guide

packages=(
  base
  linux
  linux-firmware
  vim
  pipewire
  pipewire-audio
  pipewire-pulse
  alacritty
  base-devel
  git
  openssh
  python
  awesome
  sddm
)

fdisk /dev/nvme0n1
# TODO: create partitions
mkfs.btrfs /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2
mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
# TODO: extract strapped packages to commented array
pacstrap -K /mnt "${packages[@]}"
genfstab -U /mnt >>/mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' >>/etc/locale.conf
echo 'maximus' >>/etc/hostname
# TODO: set root password -- disable root login?
pacman -S grub os-prober efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
useradd -m -G additional_groups -s login_shell username
echo "root:your_desired_root_password" | chpasswd
# TODO: write network config
systemctl enable --now systemd-networkd systemd-resolved
systemctl enable sddm
