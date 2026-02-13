#!/bin/bash
if [ ! -f /etc/machine-id ]; then
    dbus-uuidgen > /etc/machine-id
fi
if [ ! -f /etc/xrdp/rsakeys.ini ]; then
    xrdp-keygen xrdp auto
fi
service xrdp start
service xrdp-sesman start
echo "RDP Server Started. Connect on port 3389."
tail -f /var/log/xrdp.log
