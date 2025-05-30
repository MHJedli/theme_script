#!/usr/bin/env bash

# External Functions/Files
ROOT_PATH=$(pwd)
TMP_PATH="${ROOT_PATH}/tmp"
UTILS="${ROOT_PATH}/src/utils.sh"
source "$UTILS"
LOG_FILE="${ROOT_PATH}/src/logfile.log"

trap 'handle_error "An unexpected error occurred."' ERR
clear

# Begin Windows Everforest Dark Theme Installation
echo "Continue script execution in Windows Everforest Dark Theme Installation at $(date)" >> "$LOG_FILE"

log_message "INFO" "Changing to the script directory"
printc "YELLOW" "-> Changing to the script directory..."
cd "$(dirname "${BASH_SOURCE[0]}")" && pwd || handle_error "Failed to change to the script directory"

printc "YELLOW" "-> Checking for Internet Connection..."

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"
    printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Installation"

    log_message "INFO" "Updating the database"
    printc "YELLOW" "-> Updating the database..."
    sudo apt update || handle_error "Failed to update the database"

    log_message "INFO" "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions"
    printc "YELLOW" "-> Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions -y || handle_error "Failed to install packages"

    log_message "INFO" "Installing Themes and Icons"
    printc "YELLOW" "-> Installing Themes, Icons and Fonts..."
    downloadFile "1KD9U60x1HBIz0TDW_Ls9vuzly2JaevNb" "${TMP_PATH}/my-icons.tar.gz" || handle_error "Failed to Download Windows EFD Icons"
    tar --extract --file ${TMP_PATH}/my-icons.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Icons"

    downloadFile "1WlirjnbDuj1CQ_M6poFcSngTFcRjQwnY" "${TMP_PATH}/my-themes.tar.gz" || handle_error "Failed to Download Windows EFD Theme" 
    tar --extract --file ${TMP_PATH}/my-themes.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Themes"

    log_message "INFO" "Installing The Extensions"
    printc "YELLOW" "-> Installing The Extensions..."
    downloadFile "1d53yTX9O3_wv5M31pg3AT_DHs6U6W5Lb" "${TMP_PATH}/my-extensions.tar.gz" || handle_error "Failed to Download Windows EFD Extensions"
    tar --extract --file ${TMP_PATH}/my-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract the Extensions"

    log_message "INFO" "Applying Windows Everforest Dark Theme Configurations"
    printc "YELLOW" "-> Applying Windows Everforest Dark Theme Configurations..."
    dconf load / < full-gnome-settings || handle_error "Failed to apply Windows Everforest Dark Theme Configurations"

    log_message "INFO" "Extracting Wallpapers in ~/Pictures and Applying Background"
    printc "YELLOW" "-> Extracting Wallpapers in ~/Pictures and Applying Background..."
    cp Background/wallpaper.jpg ~/Pictures || handle_error "Failed to copy Wallpapers to ~/Pictures"
    gsettings set org.gnome.desktop.background picture-uri-dark file://${HOME}/Pictures/wallpaper.jpg || handle_error "Failed to Apply Background Wallpaper"
    clear

    log_message "INFO" "Cleaning up temporary files"
    printc "YELLOW" "-> Cleaning up temporary files..."
    rm -rf ${TMP_PATH}/*

    if whiptail --title "Windows Everforest Dark Theme Installation" --yesno "Windows Everforest Dark Theme has been installed successfully.\nDo you want to sign out to fully apply the theme ?" 10 60; then
        log_message "INFO" "User chose to sign out after installation"
        gnome-session-quit --no-prompt || handle_error "Failed to sign out"
    fi

else

    handle_error "No internet Connection Available. Exiting..."

fi
# End Windows Everforest Dark Theme Installation