#!/bin/bash

#### BASIC IMAGE
yum install -y wget qemu-img
cd /tmp
wget http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img
mv *.img xenial.img
qemu-img convert ./xenial.img -O raw /dev/sda
partprobe /dev/sda
mount /dev/sda1 /mnt

#### CHROOT FIXES
mount -o bind /dev /mnt/dev
mount -o bind /proc /mnt/proc
mount -o bind /sys /mnt/sys
mv /mnt/etc/resolv.conf{,.bak}
cp /etc/resolv.conf /mnt/etc/resolv.conf

#### UPDATES
chroot /mnt/ apt update -y
chroot /mnt/ apt upgrade -y
chroot /mnt/ apt clean

#### OUTSCALE PACKAGES
wget https://osu.eu-west-2.outscale.com/outscale-official-packages/udev/osc-udev-rules_20160516_amd64.deb -P /mnt/tmp
chroot /mnt/ dpkg -i /tmp/osc-udev-rules_20160516_amd64.deb
wget https://osu.eu-west-2.outscale.com/outscale-official-packages/fni/osc-fni-1.0.0-x86_64.deb -P /mnt/tmp
chroot /mnt/ dpkg -i /tmp/osc-fni-1.0.0-x86_64.deb

#### CLEANUP
rm -f /mnt/etc/resolv.conf
mv /mnt/etc/resolv.conf.bak /mnt/etc/resolv.conf
umount /mnt/dev
umount /mnt/proc
umount /mnt/sys
umount /mnt
rm -rf /mnt/var/cache/apt
rm -rf /mnt/root/.ssh
rm -rf /mnt/root/.bash_history
rm -rf /mnt/home/ubuntu/.ssh
rm -rf /mnt/home/ubuntu/.bash_history
rm -rf /mnt/tmp/*
rm -rf /mnt/var/lib/dhcp/
rm -rf /mnt/var/tmp/*
rm -rf /mnt/var/log/*
rm -rf /mnt/var/lib/cloud/*
