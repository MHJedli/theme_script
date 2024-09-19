#!/bin/bash

path=$(pwd)/src/Mint/21.3/Cinnamon-BigSur
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in BigSur Theme Removal at $(date)" >> "$LOG_FILE"

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

log_message "INFO" "Removing Plank Dock and Nautilus File Manager"
echo "Removing Plank Dock and Nautilus File Manager..."
sleep 1
sudo apt remove plank nautilus -y || handle_error "Failed to Remove Plank Dock and Nautilus File Manager"

log_message "INFO" "Removing Themes , Icons and Cursors Pack"
echo "Removing Themes , Icons and Cursors Pack"
sleep 1
rm -rf $HOME/.themes $HOME/.local/share/icons || handle_error "Failed to Remove Themes , Icons and Cursors Pack"

log_message "INFO" "Applying Factory Defaults"
echo "Reverting to Factory Defaults..."
sleep 1
dconf reset -f /org/cinnamon/ || handle_error "Failed to Apply Factory Defaults"

signOut "cinnamon-session-quit --logout --force"