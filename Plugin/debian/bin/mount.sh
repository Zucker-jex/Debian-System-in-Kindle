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

#!/bin/bash
mount -o rw,remount /dev/root
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
mount -o loop -t ext3 /mnt/us/extensions/debian/sys/debian.ext3 /mnt/debian
mount -o bind /dev /mnt/debian/dev
mount -o bind /proc /mnt/debian/proc
mount -o bind /proc /mnt/debian/sys
echo "[OK]Mount Debian"
