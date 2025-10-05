# Commands for Lab 3

mkdir ~/lab03-automating-system-updates
cd ~/lab03-automating-system-updates
nano update_system.sh
chmod +x update_system.sh
./update_system.sh
crontab -e
crontab -l
cat ~/lab03-automating-system-updates/update_log.txt
cat /var/log/apt/history.log
