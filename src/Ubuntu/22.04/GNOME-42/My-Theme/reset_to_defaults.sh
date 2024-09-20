#!/bin/bash

source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in My Personal Theme Removal at $(date)" >> "$LOG_FILE"

if check_internet; then
    log_message "INFO" "Updating the Database"
    echo 'Updating the Database...'
    sleep 1
    sudo apt update || handle_error "Failed to update the Database"
    clear

    log_message "INFO" "Installing Dconf Editor"
    echo "Installing Dconf Editor..."
    sleep 1
    sudo apt install dconf-editor -y || handle_error "Failed to install Dconf Editor"
    
else
    handle_error "No internet Connection Available. Exiting..."
fi

log_message "INFO" "Removing Themes and Icons Pack"
echo "Removing Themes and Icons Pack..."
sleep 1
rm -rf $HOME/.themes $HOME/.icons || handle_error "Failed to Remove Themes and Icons Pack"
clear

log_message "INFO" "Applying Factory Defaults"
echo "Reverting to Factory Defaults..."
sleep 1
dconf reset -f /org/gnome/ || handle_error "Failed to Apply Factory Defaults"

signOut "gnome-session-quit --no-prompt"