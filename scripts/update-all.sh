#!/usr/bin/env bash
PRIMARY_BASH="\e[38;2;23;147;209m"
ACCENT_BASH="\e[38;2;102;217;255m"

RESET_BASH="\e[0m"

BG_BASH="\e[48;2;30;30;30m"
FG_BASH="\e[38;2;138;138;141m"

GIT_CLEAN_BASH="\e[38;2;245;176;65m"
GIT_DIRTY_BASH="\e[38;2;217;102;102m"

echo -e "${PRIMARY_BASH}---  INSTALLATION LIST  ---${RESET_BASH}"
echo -e "\n-- ${ACCENT_BASH}PACMAN UPDATES${RESET_BASH} --"

sleep 1
updates_pacman=$(checkupdates)

if [[ -n "$updates_pacman" ]]; then
    echo "$updates_pacman" | nl -s ". " -w 2
else
    echo "There is nothing to do"
fi

echo -e "\n-- ${ACCENT_BASH}AUR UPDATES${RESET_BASH} --"

updates_aur=$(yay -qua 2>/dev/null | grep '\-\>' | grep -v "Flagged Out Of Date")

if [[ -n "$updates_aur" ]]; then
    echo "$updates_aur" | nl -s ". " -w 2
else
    echo "There is nothing to do"
fi

echo -e "\n${PRIMARY_BASH}--------------------------------${RESET_BASH}\n"

if [[ -z "$updates_pacman" && -z "$updates_aur" ]]; then
    echo -e "No updates found."
    echo -e "${PRIMARY_BASH}Press enter to close...${RESET_BASH}"
    read -r
    exit 0
fi

echo -n -e "Proceed with the installation? (${PRIMARY_BASH}Y${RESET_BASH}/${GIT_DIRTY_BASH}n${RESET_BASH}): "
read -r choice
choice=${choice,,}

if [[ "$choice" == "y" ]]; then
    echo -e "${PRIMARY_BASH}Initializing full installation...${RESET_BASH}"
    yay -Syu --noconfirm
    echo -e "\n${PRIMARY_BASH}Installation finished, press enter to close...${RESET_BASH}"
    read -r
else
    echo "Update cancelled by user, closing..."
    sleep 1
fi
