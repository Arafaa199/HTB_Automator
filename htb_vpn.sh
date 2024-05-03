#!/bin/bash

# Define a config file for storing the chosen directory path
config_file="$HOME/.vpn_config"

if [ -f "$config_file" ]; then
   base_dir=$(cat "$config_file")
   echo "Base directory is $base_dir."
else

   echo "No base directory set. Please choose a directory to store VPN files:"
   read -r base_dir

   # create the base dir and HTB_VPN
   mkdir -p "$base_dir/HTB_VPN"

   echo "$base_dir" > "$config_file"
   echo "VPN files will be stored in $base_dir/HTB_VPN."
fi

vpn_dir="$base_dir/HTB_VPN"
if [ ! -d "$vpn_dir" ]; then
   mkdir -p "$vpn_dir"
fi
if [ ! -w "$vpn_dir" ]; then
   echo "Error: VPN directory $vpn_dir is not writable. Check permissions or choose a different directory."
   exit 1
fi

downloads_dir="$HOME/Downloads"

if [ ! -d "$downloads_dir" ]; then
   echo "Error: Downloads directory $downloads_dir not found."
   exit 1
fi

# find the last `.ovpn` file in Downloads
latest_vpn_file=$(ls -t "$downloads_dir"/*.ovpn 2>/dev/null | head -n 1)

if [ -n "$latest_vpn_file" ]; then
   rm "$vpn_dir"/*.ovpn 2>/dev/null

   mv "$latest_vpn_file" "$vpn_dir"
   echo "Moved $latest_vpn_file to $vpn_dir."

   rm "$downloads_dir"/*.ovpn 2>/dev/null
   echo "Old OpenVPN files removed from $downloads_dir."
fi

vpn_file=$(ls -t "$vpn_dir"/*.ovpn 2>/dev/null | head -n 1)

if [ -z "$vpn_file" ]; then
   echo "No OpenVPN files available."
   exit 1
fi

sudo openvpn "$vpn_file"
