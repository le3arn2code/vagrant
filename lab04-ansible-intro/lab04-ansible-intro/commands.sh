#!/bin/bash
# Step 1: Create target container
docker run -d --name ansible-target \
  --hostname ansible-target \
  -v ~/lab04-ansible-intro:/vagrant \
  ubuntu:20.04 \
  bash -c "apt update -y && apt install -y openssh-server sudo python3 && \
  mkdir -p /var/run/sshd && echo 'root:root' | chpasswd && \
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
  service ssh start && tail -f /dev/null"

# Step 2: Create controller container
docker run -d --name ansible-controller \
  --hostname ansible-controller \
  --add-host ansible-target:172.17.0.3 \
  -v ~/lab04-ansible-intro:/vagrant \
  ubuntu:20.04 \
  bash -c "apt update -y && apt install -y openssh-server sudo python3 python3-pip ansible && \
  mkdir -p /var/run/sshd && echo 'root:root' | chpasswd && \
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
  service ssh start && tail -f /dev/null"

# Step 3: Verify containers
docker ps

# Step 4: SSH into controller
docker exec -it ansible-controller bash

# Step 5: Inside controller, create inventory file
echo '[all]\nansible-target ansible_host=172.17.0.3 ansible_user=root ansible_password=root' > /vagrant/inventory.ini

# Step 6: Verify Ansible connectivity
ansible all -m ping

# Step 7: Run sample playbook
ansible-playbook playbook.yml
