
# Troubleshooting

- **Host key verification failed**: add GitHub to known_hosts for both user and root.
- **Permission denied (publickey)**: verify deploy key is added to repo; set perms `chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_ed25519*`.
- **Deploy key read-only (push fails)**: push once via HTTPS + PAT, or re-add key with write access.
- **apt lock / key warnings**: stop unattended upgrades, clear locks, `dpkg --configure -a`, then `apt-get update`.
- **nginx not running**: `sudo apt install -y nginx`, then `systemctl status nginx`.
