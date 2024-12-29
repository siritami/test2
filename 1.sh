#!/bin/bash

# Check if running with sudo
if [ "$(id -u)" != "0" ]; then
    echo "Please run this script with sudo."
    exit 1
fi

# Install necessary packages
apt-get update
apt-get install -y wget socat iproute2

# Download IPv4 and IPv6 ranges from Cloudflare
wget -qO cf_ipv4.txt https://www.cloudflare.com/ips-v4/
wget -qO cf_ipv6.txt https://www.cloudflare.com/ips-v6/

# Find the correct network interface
network_interface="rmnet_ipa0"  # Replace with the correct interface if needed

# Read IPv4 addresses and add routing rules
while IFS= read -r ip; do
    ip route add "$ip" dev "$network_interface"
done < cf_ipv4.txt

# Read IPv6 addresses and add routing rules
while IFS= read -r ip; do
    ip -6 route add "$ip" dev "$network_interface"
done < cf_ipv6.txt

# Start a SOCKS5 proxy on port 9090 using socat
socat TCP-LISTEN:9090,fork SOCKS4A:localhost:127.0.0.1:%host%:80,socksport=9050 &

# Pause script after completing setup
read -rp "Press Enter to stop proxy and clean up routing rules..."

# Clean up routing rules
while IFS= read -r ip; do
    ip route del "$ip" dev "$network_interface"
done < cf_ipv4.txt

while IFS= read -r ip; do
    ip -6 route del "$ip" dev "$network_interface"
done < cf_ipv6.txt

# Kill the socat process
pkill socat
