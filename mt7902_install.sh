#!/bin/bash

set -e

echo "=== MT7902 WiFi + Bluetooth Driver Installer ==="
echo ""

# Install dependencies
echo "[1/7] Installing build dependencies..."
sudo apt install -y git make gcc dkms linux-headers-$(uname -r)

# WiFi driver
echo "[2/7] Cloning WiFi driver..."
git clone https://github.com/hmtheboy154/mt7902 ~/mt7902

echo "[3/7] Building and installing WiFi driver..."
cd ~/mt7902 && sudo make install -j$(nproc)

echo "[4/7] Installing WiFi firmware..."
sudo make install_fw

# Bluetooth driver
echo "[5/7] Cloning Bluetooth driver..."
git clone -b bluetooth_backport https://github.com/hmtheboy154/mt7902 ~/mt7902-bt

echo "[6/7] Building and installing Bluetooth driver..."
cd ~/mt7902-bt && sudo make install -j$(nproc)

echo "[7/7] Installing Bluetooth firmware..."
sudo make install_fw

echo ""
echo "=== Done! Rebooting in 5 seconds... ==="
sleep 5
sudo reboot
