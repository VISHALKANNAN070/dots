#!/bin/bash
DEV=$(nmcli -t -f DEVICE,STATE device | grep ':connected$' | head -n1 | cut -d: -f1)
if [ -n "$DEV" ]; then
    echo "$DEV"
else
    echo "OFFLINE"
fi
