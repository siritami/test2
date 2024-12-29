#!/bin/bash

# Variables
IPV4_URL="https://www.cloudflare.com/ips-v4/"
IPV6_URL="https://www.cloudflare.com/ips-v6/"
SOCKS5_PORT=9090
SOCKS5_INTERFACE="wlan0"  # Interface for routing via proxy
INTERNET_INTERFACE="wlan1"  # Default internet-facing interface

# Temporary files for IP lists
IPV4_LIST="/tmp/cloudflare_ipv4.txt"
IPV6_LIST="/tmp/cloudflare_ipv6.txt"

# Functions
function download_ip_lists {
    echo "Downloading Cloudflare IP lists..."
    curl -s "$IPV4_URL" -o "$IPV4_LIST"
    curl -s "$IPV6_URL" -o "$IPV6_LIST"
    echo "Downloaded IP lists."
}

function setup_routes {
    echo "Setting up routes for Cloudflare IP ranges..."

    # Add routes for IPv4 ranges
    while read -r ip_range; do
        [[ -z "$ip_range" ]] && continue
        ip route add "$ip_range" dev "$SOCKS5_INTERFACE" || echo "Failed to add IPv4 route: $ip_range"
    done < "$IPV4_LIST"

    # Add routes for IPv6 ranges
    while read -r ip_range; do
        [[ -z "$ip_range" ]] && continue
        ip -6 route add "$ip_range" dev "$SOCKS5_INTERFACE" || echo "Failed to add IPv6 route: $ip_range"
    done < "$IPV6_LIST"

    echo "Routes setup completed."
}

function start_socks5_proxy {
    echo "Starting SOCKS5 proxy on port $SOCKS5_PORT..."

    # Use `ssh` to set up a SOCKS5 proxy (ensure SSH server is installed and configured)
    ssh -N -D "$SOCKS5_PORT" "localhost" &

    SOCKS5_PID=$!
    echo "SOCKS5 proxy started with PID $SOCKS5_PID."

    # Save PID for cleanup
    echo "$SOCKS5_PID" > /tmp/socks5_proxy.pid
}

function cleanup {
    echo "Cleaning up routes and proxy..."

    # Remove routes for IPv4
    while read -r ip_range; do
        [[ -z "$ip_range" ]] && continue
        ip route del "$ip_range" dev "$SOCKS5_INTERFACE" 2>/dev/null
    done < "$IPV4_LIST"

    # Remove routes for IPv6
    while read -r ip_range; do
        [[ -z "$ip_range" ]] && continue
        ip -6 route del "$ip_range" dev "$SOCKS5_INTERFACE" 2>/dev/null
    done < "$IPV6_LIST"

    # Stop SOCKS5 proxy
    if [[ -f /tmp/socks5_proxy.pid ]]; then
        kill $(cat /tmp/socks5_proxy.pid) 2>/dev/null
        rm -f /tmp/socks5_proxy.pid
    fi

    echo "Cleanup completed."
}

# Main script
trap cleanup EXIT

download_ip_lists
setup_routes
start_socks5_proxy

# Pause script
read -p "Script completed. Press Enter to exit..."
