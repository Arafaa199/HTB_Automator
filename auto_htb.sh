#!/bin/bash

# Check if two arguments are passed
if [ "$#" -ne 2 ]; then
   echo "Usage: $0 <box_name> <box_ip>"
   exit 1
fi

# Assign arguments to variables
box_name="$1"
box_ip="$2"

# Define the base directory for storing boxes
base_dir="$HOME/HTB"

# Ensure the base directory exists
mkdir -p "$base_dir"

# Create a directory named after the box within the base directory
box_dir="$base_dir/$box_name"
mkdir -p "$box_dir"

# Create a text file named after the box in the directory for notes
box_file="$box_dir/$box_name.txt"
touch "$box_file"

# Run a full port scan to find open ports
ports=$(nmap -Pn -p- --min-rate=1000 -T4 "$box_ip" | grep '^[0-9]' | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')

# Check if any ports are open
if [ -z "$ports" ]; then
   echo "No open ports found."
   exit 1
fi

# Perform a detailed scan on open ports with scripts and version detection
nmap -p"$ports" -sC -sV "$box_ip" -oN "$box_dir/nmap_scan.txt"

echo "Detailed scan saved to $box_file"

# Open the text file in a preferred editor for notes
nano "$box_file"
