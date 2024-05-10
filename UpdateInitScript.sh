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
# This script turns the debian script on your Kindle into a command.
# After running this, just type 'debian' to run Debian
echo "Debian Init Script Installer 0.0.3 by jex"
echo "REDDIT EDITION - I have modified the" 
echo "script to be a bit more self contained."
echo 
echo "[*] Installing Debian init script..."
echo "[*] Getting root permissions..."
su
echo "[*] Making rootfs writeable..."
mntroot rw
if [ -f 'RunDebian.sh' ]; then
    mv RunDebian.sh /bin/debian
    if [ $? -eq 0 ]; then
        echo "[*] Installation succcessful..."
    else
        echo "[!] Debian init script installation failed!"
        echo "Are you root?"
        exit 5
    fi
else
    echo "[!] Debian init script does not exist!"
    echo "Please put RunDebian.sh in the root directory of the Kindle."
fi
