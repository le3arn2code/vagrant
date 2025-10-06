# Lab 06: Setting Up and Automating a Web Server with Nginx

## Objective
Install **Nginx** on Ubuntu, serve a simple static page, and automate the full setup with a single Bash script.

## Prerequisites
- Ubuntu VM (Al Nafi-provided), powered on
- `sudo` privileges
- Internet access for `apt`
- Port **80** free (no Apache/old Nginx bound to it)
- If firewall is enabled (UFW): `sudo ufw allow 80/tcp`

## Step-by-Step (nano-friendly)

### 1) Install Nginx using a script
Create the installer:
```bash
nano install_nginx.sh
```
Paste:
```bash
#!/bin/bash

# Update package lists
echo "Updating package lists..."
sudo apt update

# Install Nginx
echo "Installing Nginx..."
sudo apt install -y nginx

# Enable Nginx to start at boot
echo "Enabling Nginx to start at boot..."
sudo systemctl enable nginx

# Start Nginx
echo "Starting Nginx service..."
sudo systemctl start nginx

# Check Nginx status (non-interactive)
echo "Checking Nginx status..."
sudo systemctl is-active nginx && echo "nginx is active"
```
Save/exit (CTRL+O, ENTER, CTRL+X), then run:
```bash
chmod +x install_nginx.sh
sudo ./install_nginx.sh
```

### 2) Configure a simple static web page
```bash
sudo nano /var/www/html/index.html
```
Paste:
```html
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
```
Restart & check:
```bash
sudo systemctl restart nginx
curl -I http://127.0.0.1
curl -s http://127.0.0.1 | head -n 5
```

### 3) Automate the entire process
```bash
nano automate_nginx.sh
```
Paste:
```bash
#!/bin/bash

# Step 1: Install Nginx
echo "Installing Nginx..."
sudo apt update
sudo apt install -y nginx

# Step 2: Enable Nginx to start at boot
echo "Enabling Nginx to start at boot..."
sudo systemctl enable nginx

# Step 3: Start Nginx
echo "Starting Nginx..."
sudo systemctl start nginx

# Step 4: Configure the static web page
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

# Step 5: Restart Nginx to apply changes
echo "Restarting Nginx..."
sudo systemctl restart nginx

# Step 6: Check Nginx status (non-interactive)
echo "Checking Nginx status..."
if systemctl is-active --quiet nginx; then
  echo "Web server setup complete and nginx is running!"
else
  echo "nginx is not running"; exit 1
fi
```
Save/exit, then run:
```bash
chmod +x automate_nginx.sh
sudo ./automate_nginx.sh
```

### Verification
- Browser: `http://<server-ip>` should show your page
- CLI: `curl -I http://127.0.0.1`

### Screenshot (Proof)
`./screenshots/lab06_nginx_result.png`

---

## Layman's Summary (simple & concise)
We installed a web program called **Nginx** that listens on your computer’s port 80. We put a small HTML page in its folder so it has something to show. Then we wrote a **script** to do all of this automatically, so next time it takes seconds instead of minutes. If the firewall blocks it or another program already uses port 80, we fix that and restart Nginx. Finally, we checked the page with a browser and with `curl`.

---

## Errors & Mismatches We Encountered and How We Fixed Them
- **Interactive status output**: `systemctl status nginx` opens a pager.  
  **Fix**: Use `systemctl is-active nginx` in scripts so it exits cleanly.
- **Port 80 in use (potential)**: another service (e.g., Apache) holding the port.  
  **Fix**: `sudo lsof -i :80`, stop/disable the service, then `sudo systemctl restart nginx`.
- **Firewall blocking HTTP (potential)**: UFW not allowing 80.  
  **Fix**: `sudo ufw allow 80/tcp && sudo ufw reload`.
- **APT lock / software mismatch (potential)**: unattended upgrades or conflicting package states (e.g., different Nginx build vs. expected).  
  **Fix**: ensure apt is free, run `sudo dpkg --configure -a`, then `sudo apt update` and install. If a prior Nginx/custom build existed, remove/disable it before installing from Ubuntu repos to avoid version conflicts.

All final commands used are captured below and in `commands.sh`.

---

## Final Commands (working clean path)
```bash
sudo apt update && sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo bash -c 'cat > /var/www/html/index.html' <<EOF
<!DOCTYPE html>
<html><head><title>Welcome to My Web Server</title></head>
<body><h1>Hello, welcome to my web server powered by Nginx!</h1>
<p>This page was created using Nginx and a bash script.</p></body></html>
EOF
sudo systemctl restart nginx
systemctl is-active nginx && curl -I http://127.0.0.1
```
