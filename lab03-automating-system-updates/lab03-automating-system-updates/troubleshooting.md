# Troubleshooting

### Cron not running?
sudo systemctl status cron
chmod +x ~/lab03-automating-system-updates/update_system.sh

### Log file missing?
Ensure redirection path exists:
>> ~/lab03-automating-system-updates/update_log.txt 2>&1

### Permission issues?
Prefix commands with sudo or use absolute paths.
