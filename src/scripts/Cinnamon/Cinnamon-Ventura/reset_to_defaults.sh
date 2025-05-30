#!/usr/bin/env bash

path=$(pwd)/src/Mint/21.3/Cinnamon-Ventura
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in Ventura Theme Removal at $(date)" >> "$LOG_FILE"

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
    sudo apt install dconf-editor -y || handle_error "Failed to install Dconf Editor"ELLOW

    log_message "INFO" "Removing Plank Dock and Nautilus File Manager"
    echo "Removing Plank Dock and Nautilus File Manager..."
    printc "YELLOW" "-> Removing Plank Dock and Nautilus File Manager..."
    sleep 1
    sudo apt remove plank nautilus -y || handle_error "Failed to Remove Plank Dock and Nautilus File Manager"
    
    log_message "INFO" "Removing Ventura Themes , Icons and Cursors Pack"
    printc "YELLOW" "-> Removing Themes , Icons and Cursors Pack..."
    sleep 1
    rm -rf ${HOME}/.themes/WhiteSur* ${HOME}/.local/share/icons/WhiteSur* || handle_error "Failed to Remove Themes , Icons and Cursors Pack"
    
    log_message "INFO" "Applying Factory Defaults"
    printc "YELLOW" "-> Reverting to Factory Defaults..."
    sleep 1
    dconf reset -f /org/cinnamon/ || handle_error "Failed to Apply Factory Defaults"
    
    signOut "cinnamon-session-quit --logout --force"
    
else
    handle_error "No internet Connection Available. Exiting..."
fi

