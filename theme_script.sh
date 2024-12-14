#!/usr/bin/env bash

# External Functions/Files
source src/utils.sh
source src/Mint/mint.sh
source src/Ubuntu/ubuntu.sh

# System Release
system_release=$(cat /etc/issue)

# LOG File
LOG_FILE=src/logfile.log

# Initialize log file
echo "Starting script execution at $(date)" > "$LOG_FILE"

# Main Menu
showMainMenu(){
    clear
    log_message "INFO" "Displaying Main Menu"
    echo "--------------------------------------"
    echo "|   Welcome to the Theme Installer   |"
    echo "--------------------------------------"
    echo "Distribution In Use -> '${system_release:0:-6}'"
    echo "Desktop Environment In Use -> ${DESKTOP_SESSION}"
    echo "------------------------------------------------------"
    echo "Choose Your Linux Distribution :"
    echo '1. Ubuntu'
    echo '2. Linux Mint'
    echo "q. Quit"
    echo -n "Enter Option : "
    read option
    log_message "INFO" "User selected option ${option} in Main Menu"

    case $option in
        1)
            showUbuntuMenu
            log_message "INFO" "User chose Ubuntu"
            ;;
        2)
            showMintMenu
            log_message "INFO" "User chose Linux Mint"
            ;;
        q)
            log_message "INFO" "User chose to quit"
            exit 1
            ;;
        *)
            log_message "WARN" "User chose an invalid option : ${option}"
            invalidOption showMainMenu
            ;;
    esac
}

# Main Script
showMainMenu