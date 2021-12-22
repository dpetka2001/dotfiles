#!/bin/bash

mkdir -p $HOME/.mozilla/native-messaging-hosts/
(cat <<EOF
{
  "name": "rofi_interface",
  "description": "Native backend for rofi tab switcher.",
  "path": "`pwd`/rofiface.py",
  "type": "stdio",
  "allowed_extensions": [ "@rofi.tab.switcher" ]
}
EOF
) > $HOME/.mozilla/native-messaging-hosts/rofi_interface.json

