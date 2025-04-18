#!/bin/bash

# Step 1: Prevent WSL from overwriting resolv.conf
echo "[network]" | sudo tee /etc/wsl.conf
echo "generateResolvConf = false" | sudo tee -a /etc/wsl.conf

# Step 2: Backup and remove the existing resolv.conf
sudo mv /etc/resolv.conf /etc/resolv.conf.backup

# Step 3: Create a new resolv.conf with reliable DNS servers
echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" | sudo tee /etc/resolv.conf

# Step 4: Restart WSL to apply changes
wsl.exe --shutdown

echo "DNS configuration updated. Please restart your WSL session."
