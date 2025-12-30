# boot-script

The boot-script is a custom, "hacker-style" cinematic boot animation script for Linux systems. It replaces the default graphical splash screen (Plymouth) or scrolling kernel text with a clean, centered, multi-scene text animation that runs before the login manager starts.

Preview
When the system boots, the screen goes black and plays the following sequence:

    Initialization: [ initializing system... ]   appears in dark gray.

The Title: "WELCOME SAINT MARTIN" renders in large slanted ASCII art (Bright Green).

Access Granted: "ACCESS GRANTED" appears in white with a blinking green cursor block.

Prompt: "please wait to input password" types out with a blinking underscore.

Prerequisites
This script relies on standard Linux terminal utilities and figlet for the ASCII art.

Bash (Standard on almost all Linux distros)

ncurses-bin (Provides tput for cursor control)

figlet (Generates the large text)

Install dependencies (Debian/Kali/Ubuntu):

Bash

    sudo apt update
    sudo apt install figlet

Installation
1. Install the Script
Move the script to a global binary location so it can be accessed by the root user during boot.

Bash
# 1. Create the file (paste the script code here)

    sudo nano /usr/local/bin/welcome.sh

# 2. Make it executable

    sudo chmod +x /usr/local/bin/welcome.sh
    
2. Create the Systemd Service
    To run this animation automatically at boot, create a system service file.

Bash
    
    sudo nano /etc/systemd/system/saint-boot.service
    
Paste the following configuration:

    Ini, TOML
    [Unit]
    Description=Saint Martin Boot Animation
    After=network.target
    Before=display-manager.service getty@tty1.service
    Conflicts=getty@tty1.service

    [Service]
    Type=oneshot
    ExecStart=/usr/local/bin/welcome.sh
    StandardInput=tty
    StandardOutput=tty
    TTYPath=/dev/tty1
    TTYVTDisallocate=yes

    [Install]
    WantedBy=multi-user.target
    
3. Enable the Service

        Bash
        sudo systemctl enable saint-boot.service
   
5. Clean the Boot Process (Recommended)

For the best cinematic effect (a purely black background without scrolling text), you should mute system messages in GRUB.

Edit GRUB config: 
        
      sudo nano /etc/default/grub

  Find the line GRUB_CMDLINE_LINUX_DEFAULT and change it to:

    Bash
    GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=0 systemd.show_status=false rd.systemd.show_status=false plymouth.enable=0 vt.global_cursor_default=0"
Update GRUB: 

    sudo update-grub

Customization
Changing the Name
To change the displayed name from "SAINT MARTIN" to something else, edit the script:

Open the script: 

    sudo nano /usr/local/bin/welcome.sh

Locate Scene 2:

    Bash
    /usr/bin/figlet -c -w $COLS -f slant "WELCOME"
    /usr/bin/figlet -c -w $COLS -f slant "YOUR NAME HERE"
    
Changing Colors
The script uses standard ANSI escape codes for colors. You can modify these variables at the top of the script:

    GREEN="\e[1;32m" (Bright Green)

    WHITE="\e[1;37m" (Bright White)

    GRAY="\e[90m" (Dark Gray)

Troubleshooting
Issue: The large text doesn't appear.

Fix: Ensure figlet is installed. Run "which figlet" in your terminal. If the path is /usr/games/figlet instead of /usr/bin/figlet, update the path inside the script script.

Issue: Weird characters (like ^H or [OK]) appear during the animation.

Fix: Ensure you added TTYVTDisallocate=yes to your saint-boot.service file. This forces a fresh terminal screen, clearing any leftover boot logs.

Issue: The animation overlaps with the login prompt.

Fix: The Before=display-manager.service line in the service file should prevent this. If it persists, increase the sleep timer at the end of the script to ensure the animation finishes cleanly before the Display Manager takes over.
