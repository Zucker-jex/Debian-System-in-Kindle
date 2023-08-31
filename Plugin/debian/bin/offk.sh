#!/bin/bash
stop lab126_gui
bash "/mnt/us/extensions/kterm/bin/kterm.sh -e /mnt/us/extensions/debia/bin/debian.sh"
start lab126_gui
