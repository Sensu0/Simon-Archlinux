#!/bin/sh

# Wifi, battery icon and wifi-icon
yay -S iwd networkmanager-iwd libnm-iwd iwgtk cbatticon snixembed-git
sudo systemctl enable iwd.service

# Fix to prevent iwd from loading before kernel module
# iwlwifi. Without this, you might not have any visible devices or adapters in iwctl.
sudo echo "[Service]
ExecStartPre=/usr/bin/sleep 2" > \
/etc/systemd/system/iwd.service.d/override.conf

# Reload systemctl and restart iwd service after implementing the override above.
sudo systemctl daemon-reload
sudo systemctl enable iwd.service
sudo systemctl start iwd.service
