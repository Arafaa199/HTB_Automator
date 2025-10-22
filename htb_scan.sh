#!/bin/bash

if [ "$#" -ne 2 ]; then
   echo "Usage: $0 <box_name> <box_ip>"
   exit 1
fi

box_name="$1"
box_ip="$2"

# base dir for storing boxes
base_dir="$HOME/HTB"
mkdir -p "$base_dir"

box_dir="$base_dir/$box_name"
mkdir -p "$box_dir"

box_file="$box_dir/$box_name.txt"
touch "$box_file"

# a proper nmap scan and some slicing to get the ports for another round of nmap
ports=$(nmap -Pn -p- --min-rate=1000 -T4 "$box_ip" | grep '^[0-9]' | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')

if [ -z "$ports" ]; then
   echo "No open ports found."
   exit 1
fi

nmap -p"$ports" -sC -sV "$box_ip" -oN "$box_dir/nmap_scan.txt"

echo "Detailed scan saved to $box_file"

nano "$box_file"
