#!/usr/bin/env bash

source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in GTK Graphite Theme Removal at $(date)" >> "$LOG_FILE"

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
    rm -rf ${HOME}/.themes ${HOME}/.icons || handle_error "Failed to Remove Themes and Icons Pack"
    clear

    log_message "INFO" "Applying Factory Defaults"
    printc "YELLOW" "-> Reverting to Factory Defaults..."
    sleep 1
    dconf reset -f /org/gnome/ || handle_error "Failed to Apply Factory Defaults"

    signOut "gnome-session-quit --no-prompt"

else

    handle_error "No internet Connection Available. Exiting..."

fi

