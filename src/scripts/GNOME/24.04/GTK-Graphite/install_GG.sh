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
    sudo apt install dconf-editor \
                     gnome-tweaks \
                     gnome-shell-extensions \
                     jq curl sassc \
                     gtk2-engines-murrine -y || handle_error "Failed to install Packages"

    log_message "INFO" "Creating temporary directory"
    printc "YELLOW" "-> Creating temporary directory..."
    mkdir -p ${TMP_PATH} || handle_error "Failed to create temporary directory"

    log_message "INFO" "Installing GTK Graphite Theme"
    printc "YELLOW" "-> Installing GTK Graphite Theme..."
    if [[ -d ${TMP_PATH}/Graphite-gtk-theme ]]; then
        rm -rf ${TMP_PATH}/Graphite-gtk-theme
    fi
    git clone https://github.com/vinceliuice/Graphite-gtk-theme.git ${TMP_PATH}/Graphite-gtk-theme || handle_error "Failed to clone GTK Graphite Theme repository"
    bash ${TMP_PATH}/Graphite-gtk-theme/install.sh || handle_error "Failed to install GTK Graphite Theme"
    bash ${TMP_PATH}/Graphite-gtk-theme/install.sh -l -c dark || handle_error "Failed to install GTK Graphite Theme with options"

    log_message "INFO" "Installing GTK Graphite Icons"
    printc "YELLOW" "-> Installing GTK Graphite Icons..."
    git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git ${TMP_PATH}/Tela-circle-icon-theme || handle_error "Failed to clone GTK Graphite Icons repository"
    bash ${TMP_PATH}/Tela-circle-icon-theme/install.sh -c grey || handle_error "Failed to install GTK Graphite Icons"

    log_message "INFO" "Installing GTK Graphite Extensions"
    printc "YELLOW" "-> Installing GTK Graphite Extensions..."
    downloadFile "10kGyUF0ZHIawzqjsJt2prP_2ZJDEpoP2" "${TMP_PATH}/GTK-Graphite-g46-extensions.tar.gz" || handle_error "Failed to Download GTK Graphite Extensions"
    tar --extract --file ${TMP_PATH}/GTK-Graphite-g46-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract GTK Graphite Extensions"

    log_message "INFO" "Installing GTK Graphite Wallpapers"
    printc "YELLOW" "-> Installing GTK Graphite Wallpapers..."
    bash ${TMP_PATH}/Graphite-gtk-theme/wallpaper/install-wallpapers.sh -t nord || handle_error "Failed to install GTK Graphite Wallpapers"    

    log_message "INFO" "Applying GTK Graphite Configurations"
    printc "YELLOW" "-> Applying GTK Graphite Configurations..."
    dconf load / < GTK-Graphite-g46-config || handle_error "Failed to Apply GTK Graphite configurations"

    # log_message "INFO" "Applying Background Wallpaper"
    # printc "YELLOW" "-> Applying Background Wallpaper..."
    # gsettings set org.gnome.desktop.background picture-uri file://${HOME}/.local/share/backgrounds/wave-Dark-nord.jpg || handle_error "Failed to Apply Background Wallpaper"

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