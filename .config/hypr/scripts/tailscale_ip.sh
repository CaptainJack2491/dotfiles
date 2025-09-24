#!/bin/bash

# Grab Tailscale device info (you need tailscale CLI installed and logged in)
devices=$(tailscale status --json | jq -r '.Peer[] | "\(.HostName) \(.TailscaleIPs[0])"')

# Show in wofi menu
choice=$(echo "$devices" | wofi --dmenu --prompt "Tailscale Devices:")

# Extract the IP (it's the second field)
ip=$(echo "$choice" | awk '{print $2}')

# Copy to clipboard (wl-copy for Wayland)
[ -n "$ip" ] && echo -n "$ip" | wl-copy

