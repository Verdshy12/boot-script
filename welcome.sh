#!/bin/bash

# --- SETUP ---
# Hiding the system cursor so it doesn't interfere
tput civis

# Colors
GREEN="\e[1;32m"
WHITE="\e[1;37m"
GRAY="\e[90m"
RESET="\e[0m"

# Screen Dimensions
COLS=$(tput cols)
ROWS=$(tput lines)

# --- SCENE 1: INITIALIZING ---
tput clear
TXT1="[ initializing system... ]"
ROW1=$((ROWS / 2))
COL1=$(( (COLS - ${#TXT1}) / 2 ))

tput cup $ROW1 $COL1
echo -ne "${GRAY}${TXT1}${RESET}"
sleep 3

# --- SCENE 2: WELCOME (HACKER FONT) ---
tput clear
echo -ne "$GREEN"

# figlet output
tput cup $((ROWS / 2 - 4)) 0

# Rendering Text
# Ensure /usr/bin/figlet is the correct path (check with 'which figlet' on your terminal)
/usr/bin/figlet -c -w $COLS -f slant "WELCOME"
/usr/bin/figlet -c -w $COLS -f slant "SAINT MARTIN"

echo -ne "$RESET"
sleep 4

# --- SCENE 3: ACCESS GRANTED
tput clear

TXT2="ACCESS GRANTED"
ROW2=$((ROWS / 2))
COL2=$(( (COLS - ${#TXT2}) / 2 ))

# Printing the text once
tput cup $ROW2 $COL2
echo -ne "${WHITE}${TXT2}${RESET}"

# The Block Animation
BLOCK_COL=$((COL2 + ${#TXT2} + 1))

echo -ne "$GREEN"
for i in {1..5}; do
    # the block
    tput cup $ROW2 $BLOCK_COL
    echo -n "█"
    sleep 0.3

    # Erase the block
    tput cup $ROW2 $BLOCK_COL
    echo -n " "
    sleep 0.3
done

# Draw block again
tput cup $ROW2 $BLOCK_COL
echo -ne "█${RESET}"
sleep 2

# --- SCENE 4: PASSWORD PROMPT ---
tput clear

TXT3="please wait to input password"
ROW3=$((ROWS / 2))
COL3=$(( (COLS - ${#TXT3}) / 2 ))

tput cup $ROW3 $COL3
echo -ne "${GREEN}${TXT3}"

# Blinking Underscore Animation (Using tput)
UNDERSCORE_COL=$((COL3 + ${#TXT3} + 1))

for i in {1..6}; do
    tput cup $ROW3 $UNDERSCORE_COL
    echo -n "_"
    sleep 0.2

    tput cup $ROW3 $UNDERSCORE_COL
    echo -n " "
    sleep 0.2
done
echo -ne "${RESET}"

# --- EXIT ---
sleep 1
tput cnorm # Restore cursor
tput clear
