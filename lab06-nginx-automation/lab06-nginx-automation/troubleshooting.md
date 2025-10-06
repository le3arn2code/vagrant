# Troubleshooting

## APT lock / software mismatch
**Symptom:** `E: Could not get lock /var/lib/dpkg/lock-frontend` or packages stuck / mismatched versions of Nginx.  
**Fix:**
```bash
ps aux | grep -E 'apt|unattended'   # inspect
sudo kill -9 <PID>                  # only if truly stuck
sudo rm -f /var/lib/dpkg/lock-frontend /var/lib/dpkg/lock
sudo dpkg --configure -a
sudo apt update
# If a different Nginx build/custom repo existed, remove/disable it first, then install from Ubuntu repos.
```

## Port 80 already in use
```bash
sudo lsof -i :80
sudo systemctl stop apache2 || true
sudo systemctl disable apache2 || true
sudo systemctl restart nginx
```

## Firewall blocking HTTP
```bash
sudo ufw allow 80/tcp
sudo ufw reload
```

## `systemctl status` pager
Use non-interactive checks:
```bash
systemctl is-active nginx
journalctl -u nginx --no-pager | tail -n 50
```

## Final working sequence
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
