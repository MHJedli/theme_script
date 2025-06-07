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
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions gtk2-engines-murrine -y || handle_error "Failed to install packages"

    log_message "INFO" "Creating temporary directory"
    printc "YELLOW" "-> Creating temporary directory..."
    mkdir -p ${TMP_PATH} || handle_error "Failed to create temporary directory"

    log_message "INFO" "Installing Windows Everforest Dark Theme"
    printc "YELLOW" "-> Installing Windows Everforest Dark Theme..."
    git clone https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git ${TMP_PATH}/Everforest-GTK-Theme \
    || handle_error "Failed to clone Windows Everforest Dark Theme repository"
    bash ${TMP_PATH}/Everforest-GTK-Theme/themes/install.sh -l -c dark || handle_error "Failed to install Windows Everforest Dark Theme"

    log_message "INFO" "Installing Windows Everforest Dark Icons"
    printc "YELLOW" "-> Installing Windows Everforest Dark Icons..."
    git clone https://github.com/vinceliuice/Tela-icon-theme.git ${TMP_PATH}/Tela-icon-theme \
    || handle_error "Failed to clone Windows Everforest Dark Icons repository"
    bash ${TMP_PATH}/Tela-icon-theme/install.sh -c grey || handle_error "Failed to install Windows Everforest Dark Icons"

    log_message "INFO" "Downloading and Installing Windows Everforest Dark Extensions"
    printc "YELLOW" "-> Downloading and Installing Windows Everforest Dark Extensions..."
    downloadFile "19EK__A60NFN6I8SXwQBU_aDcMkFRm8ES" "${TMP_PATH}/Win_Forest_Dark-g46-extensions.tar.gz" || handle_error "Failed to Download Windows EFD Extensions"
    tar --extract --file ${TMP_PATH}/Win_Forest_Dark-g46-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract the Extensions"

    log_message "INFO" "Copying Wallpaper"
    printc "YELLOW" "-> Copying Wallpaper..."
    cp wallpapers/wallpaper.jpg ~/.local/share/backgrounds/ || handle_error "Failed to copy Wallpaper"

    log_message "INFO" "Applying Windows Everforest Dark Theme Configurations"
    printc "YELLOW" "-> Applying Windows Everforest Dark Theme Configurations..."
    dconf load / < Win_Forest_Dark-g46-config || handle_error "Failed to apply Windows Everforest Dark Theme Configurations"

    log_message "INFO" "Setting the default background"
    printc "YELLOW" "-> Setting the default background..."
    gsettings set org.gnome.desktop.background picture-uri-dark file://${HOME}/.local/share/backgrounds/wallpaper.jpg || handle_error "Failed to set the default background"


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