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

#!/bin/bash
echo Stopping useless tasks... 
stop tmd
stop webreader
stop cmd
stop demd
stop dpmd
stop appmgrd
stop perfd
stop stackdumpd
stop kb
stop contentpackd
stop pillow
stop todo
stop rcm
stop otav3
stop otaupd
stop udevd
stop dynconfig
stop lipcd
stop archive
