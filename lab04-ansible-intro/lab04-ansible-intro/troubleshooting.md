# Troubleshooting Steps for Lab 04: Ansible Introduction

## Issue 1: Locked `apt` processes blocking package installation
**Cause:** Multiple Vagrant/Docker setup attempts left dangling apt locks.  
**Fix:**
```bash
ps aux | grep apt
kill -9 <PID>
rm -f /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend /var/cache/apt/archives/lock
dpkg --configure -a
apt update -y
```

## Issue 2: SSH not starting
**Fix:**
```bash
mkdir -p /var/run/sshd
service ssh start
service ssh status
```

## Issue 3: Ansible password-based SSH failed
**Fix:**
```bash
apt install -y sshpass
ansible all -m ping
```
Result: `pong` confirms successful connection.

## Issue 4: Vagrant stuck with Ruby processes
**Fix:**
```bash
sudo pkill -f vagrant
sudo pkill -f ruby
sudo rm -rf /tmp/vagrant* ~/.vagrant.d/data/machine-index/index.lock .vagrant
sudo systemctl restart docker
```

✅ After cleanup, both controller and target were successfully launched and connected.
# 🧰 Lab 04 - Ansible Introduction: Full Troubleshooting Log

## 1️⃣ Initial Setup Issues
**Problem:** `vagrant up --provider=docker` was failing with “connection reset” and “another process already executing an action.”  
**Fix:**
```bash
ps aux | grep -E "vagrant|ruby"
sudo pkill -f vagrant
sudo pkill -f ruby
sudo rm -rf /tmp/vagrant*
sudo rm -rf ~/.vagrant.d/data/machine-index/index.lock
sudo rm -rf .vagrant
sudo systemctl restart docker
```
➡ This killed all stuck processes and cleared Vagrant locks.

---

## 2️⃣ Docker Compose Not Found
**Problem:** `docker-compose` not installed.  
**Fix:**
```bash
sudo apt install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-compose-plugin -y
docker compose version
```
✅ Result: `Docker Compose version v2.40.0`

---

## 3️⃣ `/usr/sbin/sshd: no such file or directory`
**Problem:** The Ubuntu base image didn’t have SSH installed.  
**Fix:**
```bash
bash -c "apt update && apt install -y openssh-server && service ssh start && tail -f /dev/null"
```

---

## 4️⃣ Persistent Vagrant Lock
**Problem:** Another vagrant/ruby process still locking the machine.  
**Fix:**
```bash
ps aux | grep -E "vagrant|ruby"
sudo kill -9 <pid1> <pid2> ...
sudo rm -rf /tmp/vagrant*
sudo rm -rf ~/.vagrant.d/data/machine-index/index.lock
sudo rm -rf .vagrant
sudo systemctl restart docker
```

---

## 5️⃣ Missing SSHD Service
**Problem:** SSH not active inside Ubuntu container.  
**Fix:**
```bash
docker exec -it lab04-ansible-intro bash
apt update -y
apt install -y openssh-server
service ssh start
```

---

## 6️⃣ APT Lock Errors
**Problem:** APT was locked by another process.  
**Fix:**
```bash
ps aux | grep apt
kill -9 <pid>
rm -f /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend /var/cache/apt/archives/lock
dpkg --configure -a
apt update -y
apt install -y openssh-server sudo python3 python3-pip ansible
```

---

## 7️⃣ Rebuilding Controller Container
**Problem:** SSH service missing even after installation.  
**Fix:**
```bash
docker rm -f ansible-controller
docker run -d --name ansible-controller   --hostname ansible-controller   -v ~/lab04-ansible-intro:/vagrant   ubuntu:20.04   bash -c "apt update -y && apt install -y openssh-server sudo python3 python3-pip ansible &&   mkdir -p /var/run/sshd && echo 'root:root' | chpasswd &&   sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config &&   sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config &&   service ssh start && tail -f /dev/null"
```

---

## 8️⃣ SSH Connection Refused
**Problem:** Controller could not SSH to target.  
**Fix:**
```bash
docker exec -it ansible-target bash
service ssh start
hostname -I
```

---

## 9️⃣ DNS Resolution Failure
**Problem:** `ping target` failed.  
**Fix:** Added host entry manually.  
```bash
docker run -d --name ansible-controller   --hostname ansible-controller   --add-host ansible-target:172.17.0.3   -v ~/lab04-ansible-intro:/vagrant   ubuntu:20.04   bash -c "apt update -y && apt install -y openssh-server sudo python3 python3-pip ansible &&   mkdir -p /var/run/sshd && echo 'root:root' | chpasswd &&   sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config &&   sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config &&   service ssh start && tail -f /dev/null"
```

---

## 🔟 Missing sshpass Package
**Problem:** Ansible ping failed with:  
> “to use the 'ssh' connection type with passwords, you must install the sshpass program”  
**Fix:**
```bash
apt install -y sshpass
```
✅ Output:
```
ansible-target | SUCCESS => {
    "ping": "pong"
}
```

---

## ✅ Final Verification
| Component | Check | Result |
|------------|--------|--------|
| Docker Containers | `docker ps` shows controller + target | ✅ |
| SSH Service | Running on both | ✅ |
| Ansible Version | `ansible 2.9.6` | ✅ |
| Connectivity | `ansible all -m ping` → pong | ✅ |
