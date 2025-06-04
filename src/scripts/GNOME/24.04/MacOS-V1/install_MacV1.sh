#!/usr/bin/env bash

# External Functions/Files
ROOT_PATH=$(pwd)
TMP_PATH="${ROOT_PATH}/tmp"
UTILS="${ROOT_PATH}/src/utils.sh"
source "$UTILS"
LOG_FILE="${ROOT_PATH}/src/logfile.log"

trap 'handle_error "An unexpected error occurred."' ERR
clear

# Begin MacOS V1 Theme Installation
echo "Continue script execution in MacOS V1 Theme Installation at $(date)" >> "$LOG_FILE"

log_message "INFO" "Changing to the script directory"
printc "YELLOW" "-> Changing to the script directory..."
cd "$(dirname "${BASH_SOURCE[0]}")" && pwd || handle_error "Failed to change to the script directory"

printc "YELLOW" "-> Checking for Internet Connection..."

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"
    printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Installation..."

    log_message "INFO" "Updating System Database"
    printc "YELLOW" "-> Updating System Database..."
    sudo apt update || handle_error "Failed to Update System Database"

    log_message "INFO" "Installing Required Packages"
    printc "YELLOW" "-> Installing Required Packages..."
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions unzip -y || handle_error "Failed to Install Required Packages"

    log_message "INFO" "Creating Temporary Directory"
    printc "YELLOW" "-> Creating Temporary Directory..."
    mkdir -p ${TMP_PATH} || handle_error "Failed to Create Temporary Directory"

    log_message "INFO" "Installing MacOS theme: Dark"
    printc "YELLOW" "-> Installing MacOS theme: Dark..."
    if [[ -d ${TMP_PATH}/WhiteSur-gtk-theme ]]; then
        rm -rf ${TMP_PATH}/WhiteSur-gtk-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1 "${TMP_PATH}/WhiteSur-gtk-theme" || handle_error "Failed to Download Mac Theme"
    bash ${TMP_PATH}/WhiteSur-gtk-theme/install.sh -l -c Dark || handle_error "Failed to Install Mac Theme"

    log_message "INFO" "Installing MacOS Icons Pack"
    printc "YELLOW" "-> Installing MacOS Icons Pack..."
    if [[ -d ${TMP_PATH}/WhiteSur-icon-theme ]]; then
        rm -rf ${TMP_PATH}/WhiteSur-icon-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git "${TMP_PATH}/WhiteSur-icon-theme" || handle_error "Failed to Download Mac Icons"
    bash ${TMP_PATH}/WhiteSur-icon-theme/install.sh || handle_error "Failed to Install Mac Icons"

    log_message "INFO" "Installing MacOS Cursors Pack"
    printc "YELLOW" "-> Installing MacOS Cursors Pack..."
    if [[ -d ${TMP_PATH}/McMojave-cursors ]]; then
        rm -rf ${TMP_PATH}/McMojave-cursors
    fi
    git clone https://github.com/vinceliuice/McMojave-cursors.git "${TMP_PATH}/McMojave-cursors" || handle_error "Failed to Download Mac Cursors"
    bash ${TMP_PATH}/McMojave-cursors/install.sh || handle_error "Failed to Install Mac Cursors"

    log_message "INFO" "Installing Fonts to ${HOME}/.local/share"
    printc "YELLOW" "-> Installing Fonts to ${HOME}/.local/share"
    downloadFile "1lviuvDhrVpXutpp_bduXrMIvBN_RWvOS" "${TMP_PATH}/MacV1-fonts.zip" || handle_error "Failed to Download Fonts"
    unzip -o ${TMP_PATH}/MacV1-fonts.zip -d ${HOME}/.local/share || handle_error "Failed to Install Fonts"


    log_message "INFO" "Installing Wallpapers"
    printc "YELLOW" "-> Installing Wallpapers"
    downloadFile "1Goexa7EkR6jY4wXAjmNvSuKMfdXF8R4G" "${TMP_PATH}/MacV1-wallpapers.zip" || handle_error "Failed to Download Wallpapers"
    unzip -o ${TMP_PATH}/MacV1-wallpapers.zip -d ${HOME}/.local/share/backgrounds || handle_error "Failed to Install Wallpapers"

    log_message "INFO" "Installing Extensions"
    printc "YELLOW" "-> Installing Extensions"
    downloadFile "1_yNNAr18ym-GPujH77NLxS47bV1hYjof" "${TMP_PATH}/MacOSV1-g46-extensions.tar.gz" || handle_error "Failed to Download Extensions"
    tar --extract --file ${TMP_PATH}/MacOSV1-g46-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to Extract the Extensions"

    log_message "INFO" "Applying MacOS V1 Theme Configurations"
    printc "YELLOW" "-> Applying MacOS V1 Theme Configurations"
    dconf load / < MacOSV1-g46-config || handle_error "Failed to Apply MacOS V1 Theme Configurations"

    log_message "INFO" "Setting MacOS V1 Wallpaper"
    printc "YELLOW" "-> Setting MacOS V1 Wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark file://${HOME}/.local/share/backgrounds/SequoiaDark.png || handle_error "Failed to Set MacOS V1 Wallpaper"

    echo "MacOS V1 Theme Installation Completed Successfully at $(date)" >> "$LOG_FILE"

    log_message "INFO" "Cleaning up temporary files"
    printc "YELLOW" "-> Cleaning up temporary files..."
    rm -rf ${TMP_PATH}/*

    if whiptail --title "MacOS V1 Theme Installation" --yesno "MacOS V1 Theme has been installed successfully.\nDo you want to sign out to fully apply the theme ?" 10 60; then
        log_message "INFO" "User chose to sign out after installation"
        gnome-session-quit --no-prompt || handle_error "Failed to sign out"
    fi

else

    handle_error "No internet Connection Available. Exiting..."

fi
# End MacOS V1 Theme Installation