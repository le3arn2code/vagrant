#!/bin/bash
# Lab 01 – Introduction to Vagrant and Shell Scripting

# 🧰 Pre-Lab Setup
sudo systemctl stop unattended-upgrades.service 2>/dev/null
sudo killall unattended-upgrade 2>/dev/null || true
sudo apt update -y
sudo apt install -y wget gnupg software-properties-common docker.io vagrant
sudo systemctl enable --now docker
./prelab-check.sh

# 🧱 Create Vagrant Environment
mkdir lab01-vagrant-intro
cd lab01-vagrant-intro
vagrant init

# 📝 Edit Vagrantfile to use Docker Provider (see README.md)

# 🚀 Start the Environment
vagrant up --provider=docker
docker ps

# 🔗 Access Container
docker exec -it lab01-vagrant-intro_default_1759687158 bash

# 🧰 Inside Container
apt update -y
apt install -y nano vim procps

# 🐚 Create and Run Script
nano system_info.sh
chmod +x system_info.sh
./system_info.sh

# 🧹 Exit and Cleanup
exit
vagrant destroy -f
