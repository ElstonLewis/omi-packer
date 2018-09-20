#!/bin/bash

#### BASIC IMAGE
yum install -y wget qemu-img
cd /tmp
wget http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img
mv *.img xenial.img
qemu-img convert ./xenial.img -O raw /dev/sda
mount /dev/sda1 /mnt

#### CHROOT FIXES
cp --remove-destination /etc/resolv.conf /mnt/etc/resolv.conf
mount -o bind /dev /mnt/dev
mount -o bind /proc /mnt/proc
mount -o bind /sys /mnt/sys

#### UPDATES
chroot /mnt/ apt update -y
chroot /mnt/ apt upgrade -y
chroot /mnt/ apt clean

#### OUTSCALE PACKAGES
wget https://osu.eu-west-2.outscale.com/outscale-official-packages/udev/osc-udev-rules_20160516_amd64.deb -P /mnt/tmp
chroot /mnt/ dpkg -i /tmp/osc-udev-rules_20160516_amd64.deb

#### CLEANUP
umount /mnt/dev
umount /mnt/proc
umount /mnt/sys
umount /mnt
rm -rf /mnt/var/cache/yum
rm -rf /mnt/root/.ssh
rm -rf /mnt/root/.bash_history
rm -rf /mnt/home/centos/.ssh
rm -rf /mnt/home/centos/.bash_history
rm -rf /mnt/tmp/*
rm -rf /mnt/var/lib/dhcp/
rm -rf /mnt/var/tmp/*
rm -rf /mnt/var/log/*
rm -rf /mnt/var/lib/cloud/*
