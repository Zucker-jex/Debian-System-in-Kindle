: 'Copyright (c) 2024 Jex Zucker
[Software Name] is licensed under Mulan PubL v2.
You can use this software according to the terms and conditions of the Mulan PubL v2.
You may obtain a copy of Mulan PubL v2 at:
         http://license.coscl.org.cn/MulanPubL-2.0
THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
See the Mulan PubL v2 for more details.
'

#!/bin/sh
mount -o rw,remount /dev/root
clear
echo "Debian Launcher 0.1.3 by Zucker-jex"
echo 
echo "[*] Looking for Debian..."
if [ -f /mnt/us/extensions/debian/sys/debian.ext3 ]; then  # Check if image file exists
    echo "[*] Found Debian image!"
else
    echo "[!] Could not find Debian image!"
    exit 3
fi
if [ -d /mnt/debian ]; then  # Check if debian directory exists                                                                                                                                                                               
    echo "[*] Found Debian directory!"                                                                                                                                                                                                        
else                                                                                                                                                                                                                                          
    echo "[!] Could not find Debian directory!"                                                                                                                                                                                               
    echo "[*] Mack directory..."                                                                                                                                                                                                              
    mkdir /mnt/debian                                                                                                                                                                                                                         
fi
echo "[*] Mounting rootfs..."
mount -o loop -t ext3 /mnt/us/extensions/debian/sys/debian.ext3 /mnt/debian  # Mount the Debian image
echo "[*] Preparing Filesystem..."
mount -o bind /dev /mnt/debian/dev  # Mount /dev
mount -o bind /proc /mnt/debian/proc  # Mount /proc
mount -o bind /sys /mnt/debian/sys  # Mount /sys
echo "[*] Preparing Network..."
cp /etc/hosts /mnt/debian/etc/hosts # Copy host systems host file
cp /etc/resolv.conf /mnt/debian/etc/resolv.conf  # Copy systems DNS config
echo "[*] Starting Shell..."
echo
if [ "$1" != "-root" ]; then
    chroot /mnt/debian /bin/login  # Start a login shell with the ability to login as root
else
    chroot /mnt/debian /bin/bash  # Start bash on the device
fi
echo "[*] Unmounting rootfs..."
umount /mnt/debian/dev
umount /mnt/debian/proc
umount /mnt/debian/sys
umount /mnt/debian
