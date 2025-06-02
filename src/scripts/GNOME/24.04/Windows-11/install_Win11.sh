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
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions unzip -y || handle_error "Failed to install packages"

    log_message "INFO" "Creating temporary directory for downloads"
    printc "YELLOW" "-> Creating temporary directory for downloads..."
    mkdir -p "${TMP_PATH}" || handle_error "Failed to create temporary directory"

    log_message "INFO" "Downloading Windows 11 Theme"
    printc "YELLOW" "-> Downloading Windows 11 Theme..."
    git clone https://github.com/yeyushengfan258/Win11-gtk-theme.git "${TMP_PATH}/Win11-gtk-theme" || handle_error "Failed to clone Windows 11 GTK Theme repository"
    bash ${TMP_PATH}/Win11-gtk-theme/install.sh -l -c dark || handle_error "Failed to install Windows 11 GTK Theme"

    log_message "INFO" "Downloading Windows 11 Icons"
    printc "YELLOW" "-> Downloading Windows 11 Icons..."
    git clone https://github.com/yeyushengfan258/Win11-icon-theme.git "${TMP_PATH}/Win11-icon-theme" || handle_error "Failed to clone Windows 11 Icon Theme repository"
    bash ${TMP_PATH}/Win11-icon-theme/install.sh || handle_error "Failed to install Windows 11 Icon Theme"

    log_message "INFO" "Downloading Windows 11 Cursors"
    printc "YELLOW" "-> Downloading Windows 11 Cursors..."
    git clone https://github.com/yeyushengfan258/Win7OS-cursors.git "${TMP_PATH}/Win7OS-cursors" || handle_error "Failed to clone Windows 11 Cursors repository"
    bash ${TMP_PATH}/Win7OS-cursors/install.sh || handle_error "Failed to install Windows 11 Cursors"

    log_message "INFO" "Downloading Windows 11 Fonts"
    printc "YELLOW" "-> Downloading Windows 11 Fonts..."
    git clone https://github.com/mrbvrz/segoe-ui-linux.git "${TMP_PATH}/segoe-ui-linux" || handle_error "Failed to clone Segoe UI Fonts repository"
    chmod +x "${TMP_PATH}/segoe-ui-linux/install.sh" || handle_error "Failed to make Segoe UI Fonts install script executable"
    bash ${TMP_PATH}/segoe-ui-linux/install.sh || handle_error "Failed to install Segoe UI Fonts"

    log_message "INFO" "Downloading and Extracting Windows 11 Extensions"
    printc "YELLOW" "-> Downloading and Extracting Windows 11 Extensions..."
    downloadFile "1U5yJAnEfAP5zbAlRhMK1fSdwIKirRquZ" "${TMP_PATH}/win11-g46-extensions.tar.gz" || handle_error "Failed to Download Windows 11 Extensions" 
    tar --extract --file "${TMP_PATH}/win11-g46-extensions.tar.gz" -C ~/ --strip-components=2 || handle_error "Failed to extract Windows 11 Extensions"

    log_message "INFO" "Downloading and Installing Windows 11 Wallpapers"
    printc "YELLOW" "-> Downloading and Installing Windows 11 Wallpapers..."
    downloadFile "1N1f-7qhPIZdAvoOuXVz3cfXMb13IiWLk" "${TMP_PATH}/win11-wallpapers.tar.gz" || handle_error "Failed to Download Windows 11 Wallpapers"
    unzip -d ~/.local/share/backgrounds "${TMP_PATH}/win11-wallpapers.tar.gz" || handle_error "Failed to extract Windows 11 Wallpapers"

    log_message "INFO" "Applying Windows 11 Configurations"
    printc "CYAN" "-> Applying Windows 11 Configurations..."
    dconf load / < win11-g46-config || handle_error "Failed to apply Windows 11 configurations"

    log_message "INFO" "Setting Windows 11 Background"
    printc "YELLOW" "-> Setting Windows 11 Background..."
    gsettings set org.gnome.desktop.background picture-uri file://${HOME}/.local/share/backgrounds/Fluent-building-night.png || handle_error "Failed to Apply Background Theme"

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
# End Windows 11 Theme Installation