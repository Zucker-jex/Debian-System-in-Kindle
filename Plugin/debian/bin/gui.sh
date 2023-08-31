#!/bin/bash
if [ "$1" != "-k" ]; then
	nohup bash '/mnt/us/extensions/debian/bin/offk.sh' &
else
	bash '/mnt/us/extensions/debian/bin/sysk.sh'
	nohup bash '/mnt/us/extensions/debian/bin/onk.sh' &
fi
