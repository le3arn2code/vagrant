# 🧩 Troubleshooting – Lab 01 Vagrant (Docker Provider)

| Problem | Cause | Solution |
|----------|--------|-----------|
| `VirtualBox not found` | EC2 VM doesn’t support nested virtualization | Use Docker provider instead of VirtualBox |
| `The container is not currently running` | Docker container exited immediately | Add `d.cmd = ["tail", "-f", "/dev/null"]` and `d.remains_running = true` |
| `Timed out while waiting for the machine to boot` | Vagrant expected SSH; Ubuntu base image has no SSH daemon | Use Docker exec to access container instead |
| `nano: command not found` | Minimal Ubuntu image | Run `apt install -y nano vim procps` |
| `Permission denied ./system_info.sh` | Script not executable | Run `chmod +x system_info.sh` |
| `dpkg lock` errors during setup | Background updater running | Stop with `sudo systemctl stop unattended-upgrades.service` |

✅ Once fixed, re-run the lab commands in order.
