#!/bin/bash

# This script will generate a Debian image to be put on the Kindle
echo "Debian Image Maker 0.0.1 by jex"
echo "REDDIT EDITION - I have modified the" 
echo "script to be a bit more self contained."
echo 
echo "[*] Making Debian image for Kindle..."
echo "[*] Creating Image File (THIS WILL TAKE A WHILE)..."
dd if=/dev/zero of=debian.ext3 bs=1M count=1024
echo "[*] Making ext3 Filesystem..."
mkfs.ext3 debian.ext3
tune2fs -i 0 -c 0 debian.ext3
echo "[*] Mounting Filesystem..."
sudo mkdir /mnt/debian
sudo mount -o loop -t ext3 debian.ext3 /mnt/debian
echo "[*] Installing Debian using debootstrap (THIS WILL TAKE A WHILE)..."
sudo debootstrap --arch=armel --foreign testing /mnt/debian http://ftp.us.debian.org/debian/
echo "[*] Unmounting image and removing mountpoint..."
sudo umount /mnt/debian
sudo rmdir /mnt/debian
echo "[*] Image generation complete, you can now copy debian.ext3 to the Kindle..."
