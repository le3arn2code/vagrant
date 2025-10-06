# Interview Q&A (10 real-life)

1. **Why script the Nginx setup?**  
   To make deployments repeatable, faster, and consistent. Scripts reduce human error and are a step toward Infrastructure-as-Code.

2. **Difference between `enable` and `start` for systemd services?**  
   `enable` makes the service start on boot; `start` launches it now. You typically do both for persistent services.

3. **How do you verify Nginx is serving content?**  
   Check `systemctl is-active nginx` and `curl -I http://127.0.0.1` for HTTP 200, or open `http://<server-ip>` in a browser.

4. **Where is the default web root on Ubuntu?**  
   `/var/www/html`. The default server block serves `index.html` from there.

5. **How do you avoid apt prompts in automation?**  
   Use `-y` and optionally `DEBIAN_FRONTEND=noninteractive` for fully non-interactive installs.

6. **What do you do when port 80 is already occupied?**  
   Identify the process with `sudo lsof -i :80`, stop/disable it (e.g., Apache), then restart Nginx.

7. **How do you handle firewall restrictions for HTTP?**  
   `sudo ufw allow 80/tcp` and `sudo ufw reload` (or the equivalent for your firewall).

8. **How to detect/fix Nginx configuration errors?**  
   `sudo nginx -t` to validate syntax, then fix the reported line and `sudo systemctl restart nginx`.

9. **What’s a “software mismatch” and how do you manage it?**  
   Different package sources or versions (custom repo vs. Ubuntu repo) cause conflicts. Standardize the source, remove conflicting packages, `dpkg --configure -a`, `apt update`, then install cleanly.

10. **What would you add for production readiness?**  
    TLS/HTTPS (e.g., Let’s Encrypt), hardened configs, log rotation, health checks, idempotent scripts, and integration with config management (Ansible) or CI/CD.
