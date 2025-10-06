#!/usr/bin/env bash
# Lab 06 - Commands Script (step-by-step automation)
set -e

echo "== Prerequisites check (optional) =="
lsb_release -a || cat /etc/os-release || true
sudo ufw status || true

echo "== Step 1: Installer script =="
cat > install_nginx.sh <<'EOS'
#!/bin/bash
echo "Updating package lists..."
sudo apt update
echo "Installing Nginx..."
sudo apt install -y nginx
echo "Enabling Nginx to start at boot..."
sudo systemctl enable nginx
echo "Starting Nginx service..."
sudo systemctl start nginx
echo "Checking Nginx status..."
sudo systemctl is-active nginx && echo "nginx is active"
EOS
chmod +x install_nginx.sh
sudo ./install_nginx.sh

echo "== Step 2: Static page =="
sudo bash -c 'cat > /var/www/html/index.html' <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to My Web Server</title>
</head>
<body>
    <h1>Hello, welcome to my web server powered by Nginx!</h1>
    <p>This page was created using Nginx and a bash script.</p>
</body>
</html>
EOF
sudo systemctl restart nginx
curl -I http://127.0.0.1 || true
curl -s http://127.0.0.1 | head -n 5 || true

echo "== Step 3: One-shot automation =="
cat > automate_nginx.sh <<'EOS2'
#!/bin/bash
echo "Installing Nginx..."
sudo apt update
sudo apt install -y nginx
echo "Enabling Nginx to start at boot..."
sudo systemctl enable nginx
echo "Starting Nginx..."
sudo systemctl start nginx
echo "Creating a static web page..."
sudo bash -c 'cat > /var/www/html/index.html' << "EOF"
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to My Web Server</title>
</head>
<body>
    <h1>Hello, welcome to my web server powered by Nginx!</h1>
    <p>This page was created using Nginx and a bash script.</p>
</body>
</html>
EOF
echo "Restarting Nginx..."
sudo systemctl restart nginx
echo "Checking Nginx status..."
if systemctl is-active --quiet nginx; then
  echo "Web server setup complete and nginx is running!"
else
  echo "nginx is not running"; exit 1
fi
EOS2
chmod +x automate_nginx.sh
sudo ./automate_nginx.sh

echo "== Verification =="
systemctl is-active nginx && curl -I http://127.0.0.1
