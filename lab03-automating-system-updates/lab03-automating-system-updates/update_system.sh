#!/bin/bash
echo "Updating package lists..."
sudo apt update
echo "Upgrading installed packages..."
sudo apt upgrade -y
echo "Removing unnecessary packages..."
sudo apt autoremove -y
echo "Cleaning up package cache..."
sudo apt clean
echo "System updated successfully!"
