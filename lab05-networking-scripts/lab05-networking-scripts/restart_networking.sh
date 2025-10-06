#!/bin/bash
# Script: restart_networking.sh
# Purpose: Safely reapply network configuration on Ubuntu

echo "🔁 Reapplying network configuration using Netplan..."

if command -v netplan >/dev/null 2>&1; then
    if sudo netplan apply; then
        echo "✅ Networking configuration successfully reapplied!"
    else
        echo "❌ Failed to apply network configuration via Netplan."
    fi
else
    echo "⚠️ Netplan not found. Attempting legacy restart..."
    if sudo systemctl restart systemd-networkd 2>/dev/null || sudo systemctl restart networking 2>/dev/null; then
        echo "✅ Legacy networking service restarted successfully!"
    else
        echo "❌ Failed to restart networking. Please check logs."
    fi
fi
