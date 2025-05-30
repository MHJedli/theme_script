#!/usr/bin/env bash

# External Functions/Files
ROOT_PATH=$(pwd)
TMP_PATH="${ROOT_PATH}/tmp"
UTILS="${ROOT_PATH}/src/utils.sh"
source "$UTILS"
LOG_FILE="${ROOT_PATH}/src/logfile.log"

trap 'handle_error "An unexpected error occurred."' ERR
clear

# Begin Windows 11 Theme Installation
echo "Continue script execution in Windows 11 Theme Installation at $(date)" >> "$LOG_FILE"

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

    log_message "INFO" "Installing Themes, Icons and Fonts"
    printc "YELLOW" "-> Installing Themes, Icons and Fonts..."
    downloadFile "1hKFyFPCQDNGqzGNHO3m-LL4jqQGMsZcj" "${TMP_PATH}/my-icons.tar.gz" || handle_error "Failed to Download Windows 11 Icons"
    tar --extract --file ${TMP_PATH}/my-icons.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Icons"

    downloadFile "1NqndXv4fI31SnD5zWGBpDjOt-5b-xVvW" "${TMP_PATH}/my-themes.tar.gz" || handle_error "Failed to Download Windows 11 Theme"
    tar --extract --file ${TMP_PATH}/my-themes.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Themes"

    downloadFile "13gsKnp_MqFR0LtLgzp1OZwlrYAC1swgA" "${TMP_PATH}/my-fonts.tar.gz" || handle_error "Failed to Download Windows 11 Fonts"
    tar --extract --file ${TMP_PATH}/my-fonts.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Fonts"
    
    log_message "INFO" "Installing The Extensions"
    printc "YELLOW" "-> Installing The Extensions..."
    downloadFile "13ufXpDEN-YQfNQVLRj6mflFOHMRJXgVj" "${TMP_PATH}/my-extensions.tar.gz" || handle_error "Failed to Download Windows 11 Extensions"
    tar --extract --file ${TMP_PATH}/my-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract the Extensions"
    
    log_message "INFO" "Applying Windows 11 Configurations"
    printc "CYAN" "-> Applying Windows 11 Configurations..."
    dconf load / < full-gnome-settings || handle_error "Failed to apply Windows 11 configurations"
    
    
    log_message "INFO" "Extracting Wallpapers in ~/Pictures and Applying Background"
    printc "YELLOW" "-> Extracting Wallpapers in ~/Pictures and Applying Background..."
    mkdir -p ~/Pictures/Wallpapers || handle_error "Failed to create ~/Pictures/Wallpapers Directory"
    cp -r Background/* ~/Pictures/Wallpapers || handle_error "Failed to copy Wallpapers"
    gsettings set org.gnome.desktop.background picture-uri file://${HOME}/Pictures/Wallpapers/windows-11-blue-stock-white-background-light-official-3840x2400-5616.jpg || handle_error "Failed to Apply Background Theme"
    
    echo "Windows 11 Theme Installation Completed Successfully at $(date)" >> "$LOG_FILE"

    log_message "INFO" "Cleaning up temporary files"
    printc "YELLOW" "-> Cleaning up temporary files..."
    rm -rf ${TMP_PATH}/*

    if whiptail --title "Windows 11 Theme Installation" --yesno "Windows 11 Theme has been installed successfully.\nDo you want to sign out to fully apply the theme ?" 10 60; then
        log_message "INFO" "User chose to sign out after installation"
        gnome-session-quit --no-prompt || handle_error "Failed to sign out"
    fi
    
else

    handle_error "No internet Connection Available. Exiting..."

fi
# End of Windows 11 Theme Installation