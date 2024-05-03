#!/bin/bash

# Define a configuration file for storing the chosen directory path
config_file="$HOME/.vpn_config"

# Check if the configuration file exists and read from it
if [ -f "$config_file" ]; then
   base_dir=$(cat "$config_file")
   echo "Base directory is $base_dir."
else
   # Prompt the user to choose a base directory
   echo "No base directory set. Please choose a directory to store VPN files:"
   read -r base_dir

   # Create the base directory and HTB_VPN directory
   mkdir -p "$base_dir/HTB_VPN"

   # Save the base directory for future use
   echo "$base_dir" > "$config_file"
   echo "VPN files will be stored in $base_dir/HTB_VPN."
fi

# Check if the HTB_VPN directory exists and is writable
vpn_dir="$base_dir/HTB_VPN"
if [ ! -d "$vpn_dir" ]; then
   mkdir -p "$vpn_dir"
fi
if [ ! -w "$vpn_dir" ]; then
   echo "Error: VPN directory $vpn_dir is not writable. Check permissions or choose a different directory."
   exit 1
fi

# Directory setup
downloads_dir="$HOME/Downloads"

# Ensure the Downloads directory exists
if [ ! -d "$downloads_dir" ]; then
   echo "Error: Downloads directory $downloads_dir not found."
   exit 1
fi

# Find the most recently modified `.ovpn` file in Downloads
latest_vpn_file=$(ls -t "$downloads_dir"/*.ovpn 2>/dev/null | head -n 1)

# If there's a file in Downloads
if [ -n "$latest_vpn_file" ]; then
   # Remove existing files in the VPN directory
   rm "$vpn_dir"/*.ovpn 2>/dev/null

   # Move the latest file to the VPN directory
   mv "$latest_vpn_file" "$vpn_dir"
   echo "Moved $latest_vpn_file to $vpn_dir."

   # Remove remaining `.ovpn` files from Downloads
   rm "$downloads_dir"/*.ovpn 2>/dev/null
   echo "Old OpenVPN files removed from $downloads_dir."
fi

# Find the latest file in the VPN directory
vpn_file=$(ls -t "$vpn_dir"/*.ovpn 2>/dev/null | head -n 1)

# Check if a VPN file is available
if [ -z "$vpn_file" ]; then
   echo "No OpenVPN files available."
   exit 1
fi

# Connect to the VPN using the file
sudo openvpn "$vpn_file"
