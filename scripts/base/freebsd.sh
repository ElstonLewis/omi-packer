#!/bin/bash
set -e

#### BASIC IMAGE
yum install -y wget qemu-img sg3_utils libgcrypt xz
cd /tmp
wget -O - https://download.freebsd.org/releases/VM-IMAGES/13.1-RELEASE/amd64/Latest/FreeBSD-13.1-RELEASE-amd64.qcow2.xz | unxz --decompress > FreeBSD-13.1-RELEASE-amd64.qcow2
qemu-img convert ./*.qcow2 -O raw /dev/sda
