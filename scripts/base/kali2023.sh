#!/bin/bash
set -e

#### BASIC IMAGE
yum install -y wget qemu-img libgcrypt
cd /tmp
wget -q https://kali.download/cloud-images/kali-2023.4/kali-linux-2023.4-cloud-genericcloud-amd64.tar.xz -O temp.tar.xz
tar -xf temp.tar.xz
qemu-img convert ./*.raw -O raw /dev/sda
