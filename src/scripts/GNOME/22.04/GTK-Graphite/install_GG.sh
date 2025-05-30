#!/usr/bin/env bash

# External Functions/Files
ROOT_PATH=$(pwd)
TMP_PATH="${ROOT_PATH}/tmp"
UTILS="${ROOT_PATH}/src/utils.sh"
source "$UTILS"
LOG_FILE="${ROOT_PATH}/src/logfile.log"

trap 'handle_error "An unexpected error occurred."' ERR
clear

# Begin GTK Graphite Theme Installation
echo "Continue script execution in GTK Graphite Theme Installation at $(date)" >> "$LOG_FILE"

log_message "INFO" "Changing to the script directory"
printc "YELLOW" "-> Changing to the script directory..."
cd "$(dirname "${BASH_SOURCE[0]}")" && pwd || handle_error "Failed to change to the script directory"

printc "YELLOW" "-> Checking for Internet Connection..."

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"
    printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Installation"

    log_message "INFO" "Updating the System Database"
    printc "YELLOW" "-> Updating the System Database..."
    sudo apt update || handle_error "Failed to update System Database"

    log_message "INFO" "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions"
    printc "YELLOW" "-> Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions jq curl -y || handle_error "Failed to install Packages"

    log_message "INFO" "Installing Themes and Icons"
    printc "YELLOW" "-> Installing Themes and Icons..."
    downloadFile "1u0y0jHAf3-y553lB-U7kYsbjjMl5nmnc" "${TMP_PATH}/my-icons.tar.gz" || handle_error "Failed to Download GTK Graphite Icons"
    tar --extract --file ${TMP_PATH}/my-icons.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Icons"

    downloadFile "11IJHFRXmZF_qWRd0tkbmelZX2OBMLVWn" "${TMP_PATH}/my-themes.tar.gz" || handle_error "Failed to Download GTK Graphite Theme"
    tar --extract --file ${TMP_PATH}/my-themes.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Themes"

    log_message "INFO" "Installing The Extensions"
    printc "YELLOW" "-> Installing The Extensions..."
    downloadFile "1DUIah7NfCBdIshA1737ToQmdB2cwJd5H" "${TMP_PATH}/my-extensions.tar.gz" || handle_error "Failed to Download GTK Graphite Extensions"
    tar --extract --file ${TMP_PATH}/my-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Extensions"

    log_message "INFO" "Applying GTK Graphite Configurations"
    printc "YELLOW" "-> Applying GTK Graphite Configurations..."
    dconf load / < full-gnome-settings || handle_error "Failed to Apply GTK Graphite configurations"

    log_message "INFO" "Extracting Wallpapers in ~/Pictures and Applying Background"
    printc "YELLOW" "-> Extracting Wallpapers in ~/Pictures and Applying Background..."
    cp -r Wallpapers ~/Pictures || handle_error "Failed to Copy Wallpapers in ~/Pictures"
    gsettings set org.gnome.desktop.background picture-uri file://${HOME}/Pictures/Wallpapers/wave-Dark-nord-ubuntu.png || handle_error "Failed to Apply Background Wallpaper"

    echo "GTK Graphite Theme Installation Completed Successfully at $(date)" >> "$LOG_FILE"

    log_message "INFO" "Cleaning up temporary files"
    printc "YELLOW" "-> Cleaning up temporary files..."
    rm -rf ${TMP_PATH}/*

    if whiptail --title "GTK Graphite Theme Installation" --yesno "GTK Graphite Theme has been installed successfully.\nDo you want to sign out to fully apply the theme ?" 10 60; then
        log_message "INFO" "User chose to sign out after installation"
        gnome-session-quit --no-prompt || handle_error "Failed to sign out"
    fi

else

    handle_error "No internet Connection Available. Exiting..."

fi
# End GTK Graphite Theme Installation