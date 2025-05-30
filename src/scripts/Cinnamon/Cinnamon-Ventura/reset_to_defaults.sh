#!/usr/bin/env bash

# External Functions/Files
ROOT_PATH=$(pwd)
UTILS="${ROOT_PATH}/src/utils.sh"
source "$UTILS"
LOG_FILE="${ROOT_PATH}/src/logfile.log"

trap 'handle_error "An unexpected error occurred."' ERR
clear

# Begin Ventura Theme Removal
echo "Continue script execution in Ventura Theme Removal at $(date)" >> "$LOG_FILE"

printc "YELLOW" "-> Checking for Internet Connection..."

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Removal"
    printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Removal..."

    log_message "INFO" "Updating the Database"
    printc "YELLOW" "-> Updating the Database..."
    sudo apt update || handle_error "Failed to update the Database"

    log_message "INFO" "Installing Dconf Editor"
    printc "YELLOW" "-> Installing Dconf Editor..."
    sudo apt install dconf-editor -y || handle_error "Failed to install Dconf Editor"ELLOW

    log_message "INFO" "Removing Plank Dock and Nautilus File Manager"
    echo "Removing Plank Dock and Nautilus File Manager..."
    printc "YELLOW" "-> Removing Plank Dock and Nautilus File Manager..."
    sudo apt remove plank nautilus -y || handle_error "Failed to Remove Plank Dock and Nautilus File Manager"
    
    log_message "INFO" "Removing Ventura Themes , Icons and Cursors Pack"
    printc "YELLOW" "-> Removing Themes , Icons and Cursors Pack..."
    rm -rf ${HOME}/.themes/WhiteSur* ${HOME}/.local/share/icons/WhiteSur* || handle_error "Failed to Remove Themes , Icons and Cursors Pack"
    
    log_message "INFO" "Applying Factory Defaults"
    printc "YELLOW" "-> Reverting to Factory Defaults..."
    dconf reset -f /org/cinnamon/ || handle_error "Failed to Apply Factory Defaults"
    
    if whiptail --title "Ventura Theme Removal" --yesno "Ventura Theme has been removed successfully.\nDo you want to sign out to fully reset ?" 10 60; then
        log_message "INFO" "User chose to sign out after removal"
        cinnamon-session-quit --logout --force || handle_error "Failed to sign out"
    fi

    
else
    handle_error "No internet Connection Available. Exiting..."
fi
# End Ventura Theme Removal