#!/usr/bin/env bash

# External Functions/Files
ROOT_PATH=$(pwd)
UTILS="${ROOT_PATH}/src/utils.sh"
source "$UTILS"
LOG_FILE="${ROOT_PATH}/src/logfile.log"

trap 'handle_error "An unexpected error occurred."' ERR
clear

# Begin Windows 7 Theme Removal
echo "Continue script execution in Windows 7 Theme Removal at $(date)" >> "$LOG_FILE"

printc "YELLOW" "-> Checking for Internet Connection..."

if check_internet; then
    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Removal"
    printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Removal..."
    sleep 1

    log_message "INFO" "Updating the Database"
    printc "YELLOW" "-> Updating the Database..."
    sleep 1
    sudo apt update || handle_error "Failed to update the Database"
    clear

    log_message "INFO" "Installing Dconf Editor"
    printc "YELLOW" "-> Installing Dconf Editor..."
    sleep 1
    sudo apt install dconf-editor -y || handle_error "Failed to install Dconf Editor"

    log_message "INFO" "Removing Themes and Icons Pack"
    printc "YELLOW" "-> Removing Themes and Icons Pack..."
    sleep 1
    rm -rf ${HOME}/.themes ${HOME}/.icons || handle_error "Failed to remove Themes and Icons Pack"

    log_message "INFO" "Removing Cinnamon Extensions"
    printc "YELLOW" "-> Removing Cinnamon Extensions..."
    sleep 1
    rm -rf ${HOME}/.local/share/* || handle_error "Failed to Remove Extensions"

    log_message "INFO" "Applying Factory Defaults"
    printc "YELLOW" "-> Reverting to Factory Defaults..."
    sleep 1
    dconf reset -f /org/cinnamon/ || handle_error "Failed to Apply Factory Defaults"
    
    if whiptail --title "Ventura Theme Removal" --yesno "Ventura Theme has been removed successfully.\nDo you want to sign out to fully reset ?" 10 60; then
        log_message "INFO" "User chose to sign out after removal"
        cinnamon-session-quit --logout --force || handle_error "Failed to sign out"
    fi

else
    handle_error "No internet Connection Available. Exiting..."
fi
# End Windows 7 Theme Removal