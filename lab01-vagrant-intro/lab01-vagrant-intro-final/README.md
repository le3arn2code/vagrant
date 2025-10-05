# 🧱 Lab 01 — Introduction to Vagrant and Shell Scripting (Docker Provider)

### 🎯 Objective
This lab introduces **Vagrant** using **Docker** as its provider.  
You’ll learn how to configure Vagrant inside a cloud VM (e.g., AWS EC2), start a lightweight Ubuntu container, and write a shell script to display system information.

---

## 🧩 How Vagrant Works on a Cloud VM

Traditional Vagrant setups use **VirtualBox** to create virtual machines.  
But a cloud VM (like an EC2 instance) is already virtualized and **cannot run another hypervisor**—nested virtualization is disabled.  

The workaround: **use Docker instead of VirtualBox.**

Vagrant can talk directly to Docker and treat containers as lightweight virtual machines.  
This means:
```
AWS EC2 → Docker Engine → Vagrant-managed Ubuntu container
```

- Docker does not require hardware virtualization  
- Vagrant fully supports Docker as a provider  
- You can still use all Vagrant commands (`up`, `halt`, `destroy`)  

Result: full Vagrant functionality on a cloud VM, **no VirtualBox needed.**

---

## 🧰 Prerequisites
- Ubuntu 24.04 LTS cloud VM  
- `sudo` privileges  
- Docker + Vagrant installed  
- `prelab-check.sh` script available

Run this block before every lab:
```bash
sudo systemctl stop unattended-upgrades.service 2>/dev/null
sudo killall unattended-upgrade 2>/dev/null || true
sudo apt update -y
sudo apt install -y wget gnupg software-properties-common docker.io vagrant
sudo systemctl enable --now docker
./prelab-check.sh
```

---

## 🧱 Lab Steps

### Step 1 – Create Project Folder
```bash
mkdir lab01-vagrant-intro
cd lab01-vagrant-intro
vagrant init
```

### Step 2 – Edit the Vagrantfile
```bash
nano Vagrantfile
```
Replace everything with:
```ruby
Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
    d.image = "ubuntu:20.04"
    d.cmd = ["tail", "-f", "/dev/null"]
    d.remains_running = true
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt update -y
    apt install -y bash
  SHELL
end
```

Save + exit.

---

### Step 3 – Start the Environment
```bash
vagrant up --provider=docker
```
Confirm it’s running:
```bash
docker ps
```

---

### Step 4 – Access Container and Install Tools
```bash
docker exec -it <container_name> bash
apt update -y
apt install -y nano vim procps
```

---

### Step 5 – Create and Run Shell Script
```bash
nano system_info.sh
```
Paste:
```bash
#!/bin/bash
echo "System Information:"
echo "-------------------"
uname -a
echo ""
echo "Disk Usage:"
df -h
echo ""
echo "Memory Usage:"
free -h
```
Save → exit → make executable:
```bash
chmod +x system_info.sh
./system_info.sh
```

---

### Step 6 – Exit and Cleanup
```bash
exit
vagrant destroy -f
```

---

## 🧠 Key Takeaways
- Vagrant can run on cloud VMs using Docker instead of VirtualBox  
- Docker containers act as lightweight virtual machines  
- You practiced writing and executing a Bash script safely in isolation  

---

## 🧾 Conclusion
You successfully configured Vagrant inside a cloud VM, deployed an Ubuntu container, and ran an automation script.  
This setup forms the foundation for all future DevOps and Vagrant labs.
