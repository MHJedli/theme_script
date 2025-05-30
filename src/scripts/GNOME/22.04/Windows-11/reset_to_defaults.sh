#!/usr/bin/env bash

# External Functions/Files
ROOT_PATH=$(pwd)
UTILS="${ROOT_PATH}/src/utils.sh"
source "$UTILS"
LOG_FILE=$(pwd)/src/logfile.log

trap 'handle_error "An unexpected error occurred."' ERR
clear

# Begin Windows 11 Theme Removal
echo "Continue script execution in GTK Graphite Theme Removal at $(date)" >> "$LOG_FILE"

printc "YELLOW" "-> Checking for Internet Connection..."

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Removal"
    printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Removal..."

    log_message "INFO" "Updating the Database"
    printc "YELLOW" "-> Updating the Database..."
    sudo apt update || handle_error "Failed to update the Database"

    log_message "INFO" "Installing Dconf Editor"
    printc "YELLOW" "-> Installing Dconf Editor..."
    sudo apt install dconf-editor -y || handle_error "Failed to install Dconf Editor"

    log_message "INFO" "Removing Themes and Icons Pack"
    printc "YELLOW" "-> Removing Themes and Icons Pack..."
    rm -rf ${HOME}/.themes ${HOME}/.local/share/icons || handle_error "Failed to Remove Themes and Icons Pack"
    clear

    log_message "INFO" "Applying Factory Defaults"
    printc "YELLOW" "-> Reverting to Factory Defaults..."
    dconf reset -f /org/gnome/ || handle_error "Failed to Apply Factory Defaults"

    if whiptail --title "Windows 11 Theme Removal" --yesno "Windows 11 Theme has been removed successfully.\nDo you want to sign out to fully reset ?" 10 60; then
        log_message "INFO" "User chose to sign out after removal"
        gnome-session-quit --no-prompt || handle_error "Failed to sign out"
    fi

else

    handle_error "No internet Connection Available. Exiting..."
    
fi
# End Windows 11 Theme Removal