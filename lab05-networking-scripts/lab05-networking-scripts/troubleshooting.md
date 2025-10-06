# Troubleshooting – Lab 05

## Issue: `Unit networking.service not found`
✅ Use `NetworkManager` or `systemd-networkd` instead of legacy `/etc/network/interfaces`.

## Fix:
Added service detection logic in both scripts:
```bash
if systemctl list-units --type=service | grep -q "NetworkManager.service"
```
and fallback to:
```bash
sudo ifdown --exclude-lo -a && sudo ifup --exclude-lo -a
```
