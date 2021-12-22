#!/bin/bash

var="$(nmcli r wifi)"

if [[ $var != "enabled" ]]; then
    true
else
    nm-applet&
fi
