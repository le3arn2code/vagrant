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
