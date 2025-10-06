
#!/usr/bin/env bash
set -euo pipefail

echo "== Install prerequisites =="
sudo apt update
sudo apt install -y git ansible nginx

echo "== Known hosts for github.com (user and root) =="
mkdir -p ~/.ssh && chmod 700 ~/.ssh || true
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts 2>/dev/null || true
chmod 600 ~/.ssh/known_hosts
sudo mkdir -p /root/.ssh && sudo chmod 700 /root/.ssh
sudo ssh-keyscan -t ed25519 github.com | sudo tee -a /root/.ssh/known_hosts >/dev/null || true
sudo chmod 600 /root/.ssh/known_hosts

echo "== Create deployment folder and clone repo =="
mkdir -p ~/deployment_pipeline
cd ~/deployment_pipeline
if [ ! -d .git ]; then
  git clone git@github.com:le3arn2code/lab10-cicd-pipeline.git .
fi

echo "== Create pull script =="
cat > pull_changes.sh <<'EOF'
#!/bin/bash
set -e
cd /home/toor/deployment_pipeline
echo "Pulling the latest changes from GitHub..."
git pull origin main
echo "Changes pulled successfully!"
EOF
chmod +x pull_changes.sh

echo "== Inventory and Ansible config =="
cat > inventory.ini <<'EOF'
[all]
127.0.0.1 ansible_connection=local
EOF

cat > ansible.cfg <<'EOF'
[defaults]
inventory = ./inventory.ini
host_key_checking = False
EOF

echo "== Playbook =="
cat > deploy.yml <<'EOF'
---
- name: Deploy changes to the server
  hosts: all
  tasks:
    - name: Pull the latest changes from GitHub (as toor)
      become: false
      git:
        repo: 'git@github.com:le3arn2code/lab10-cicd-pipeline.git'
        dest: /home/toor/deployment_pipeline
        version: main
        key_file: /home/toor/.ssh/id_ed25519
        accept_hostkey: yes

    - name: Restart web server (nginx)
      become: yes
      service:
        name: nginx
        state: restarted
EOF

echo "== First run =="
./pull_changes.sh
ansible-playbook ./deploy.yml

echo "== Add this cron entry to automate hourly =="
echo "0 * * * * cd /home/toor/deployment_pipeline && /home/toor/deployment_pipeline/pull_changes.sh && /usr/bin/ansible-playbook /home/toor/deployment_pipeline/deploy.yml"
