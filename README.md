# HTB_Automator
Scripts to help with the housekeeping needed when doing Hack The Box activities


HTB_Auto is a suite of scrypts to automate some HTB tasks to focus on the learning and subdue the tidying and monotonous parts (I do recommend to understand the nmap scan fully and modify it as you see fit). 


**HVPN - OpenVPN Connection & Housecleaning  Script**

This script automates the process of organizing OpenVPN files and connecting to a VPN. It finds the latest `.ovpn` file in the Downloads directory, moves it to a specified VPN directory, and connects to the VPN using that file.

Features

Custom VPN Directory: Prompts the user to set a directory for storing VPN files and remembers the choice for future runs.
Automated Organization: Moves the latest `.ovpn` file from the Downloads directory to the VPN directory and removes any remaining `.ovpn` files from 



**HMAP - Scanner & Organizer**

it works as so:

This script is designed to help with managing HTB box managament, specifically by organizing and scanning boxes from Hack The Box or other similar platforms.

Basically it creates a directory for your HTB boxes with the relevent name, additionally creating a .txt file for your notes; and most importantly automates typing the nmap script and saves it to a file.

**Features**
Custom Directory Structure: Automatically creates a directory for each box based on its name, storing all related files in an organized manner.

Port Scanning: Performs a full scan of all ports, then conducts a detailed scan on open ports, including script and version detection.

Notes and Results: Saves scan results to a text file and opens it in a text editor for immediate note-taking.


**Add Alias**
I also suggest adding the .sh files as an alias in your .bashrc or .zshrc (or whatever shell you use). This can be done in the following way:

    sudo nano ~/.bashrc      #again, or .zshrc (type ‘echo $SHELL’ to know your shell)

Find the alias section at the bottom and add the following:

    alias hvpn=‘path/to/htb_vpn.sh’
    alias hmap='path/to/htb_scan.sh'

now you can just type 'hvpn' or 'hmap <box_name> <box_ip>' and it would do its magic.


**Installation**

Clone the repository

    git clone https://github.com/Arafaa199/HTB_Automator.git
    cd HTB_Automator
    chmod +x htb_vpn.sh htb_scan.sh


**How To Use**

For the VPN:
1. Download the .ovpn file from HTB.
2. Run the .sh file
3. Set the dir which the VPN file will be stores
4. That's it really

For the Organizer/Scanner:
1. Run the scrypt with two args, the box_name and box_ip(if you followed the alias section, it would be as follows: htb Mist 10.11.12.19)

Feel free to report any issues, do pull requests, fork and contribute
