: 'Copyright (c) 2024 Jex Zucker
Debian-System-in-Kindle is licensed under Mulan PubL v2.
You can use this software according to the terms and conditions of the Mulan PubL v2.
You may obtain a copy of Mulan PubL v2 at:
         http://license.coscl.org.cn/MulanPubL-2.0
THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
See the Mulan PubL v2 for more details.
'

/bin/sh
echo "Debian Setup 0.0.1 by jex"
echo
echo "[*] Installing Init Script..."
./UpdateInitScript.sh
echo "[*] Creating Mountpoints..."
echo "[*] Getting Root Access..."
su
echo "[*] Creating: /mnt/debian"
mkdir /mnt/debian
echo "[*] Creating: /mnt/debian/dev"
mkdir /mnt/debian/dev
echo "[*] Creating: /mnt/debian/proc"
mkdir /mnt/debian/proc
echo "[*] Creating: /mnt/debian/sys"
mkdir /mnt/debian/sys
echo "[*] Done - you can now type `debian` to run Debian!"
exit 0
