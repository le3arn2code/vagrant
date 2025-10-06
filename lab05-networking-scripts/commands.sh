#!/bin/bash
# Commands for Lab 05 - Networking Scripts
mkdir -p ~/lab05-networking-scripts
cd ~/lab05-networking-scripts
nano configure_static_ip.sh
nano restart_networking.sh
chmod +x configure_static_ip.sh restart_networking.sh
sudo ./configure_static_ip.sh
sudo ./restart_networking.sh
