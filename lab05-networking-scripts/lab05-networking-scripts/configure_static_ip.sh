#!/bin/bash
# Script: configure_static_ip.sh
# Purpose: Configure a static IP on Ubuntu

interface="eth0"
ip_address="192.168.1.100"
netmask="255.255.255.0"
gateway="192.168.1.1"
dns="8.8.8.8"

# Backup config
sudo cp /etc/network/interfaces /etc/network/interfaces.bak 2>/dev/null || true

# Write config
echo "Configuring static IP address..."
sudo bash -c "cat > /etc/network/interfaces" <<EOF
auto $interface
iface $interface inet static
  address $ip_address
  netmask $netmask
  gateway $gateway
  dns-nameservers $dns
EOF

# Restart networking
if systemctl list-units --type=service | grep -q "NetworkManager.service"; then
    sudo systemctl restart NetworkManager
elif systemctl list-units --type=service | grep -q "systemd-networkd.service"; then
    sudo systemctl restart systemd-networkd
else
    echo "⚠️ No modern network service found. Trying legacy restart..."
    sudo ifdown --exclude-lo -a && sudo ifup --exclude-lo -a
fi

echo "✅ Static IP configuration completed!"
