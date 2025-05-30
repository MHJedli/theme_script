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
    sudo apt install plank dconf-editor gnome-tweaks gnome-shell-extensions -y || handle_error "Failed to Install Required Packages"

    log_message "INFO" "Installing ulauncher"
    printc "YELLOW" "-> Installing ulauncher..."
    sleep 1
    sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update && sudo apt install ulauncher -y || handle_error "Failed to Install ulauncher"

    log_message "INFO" "Installing Mac Theme Pack : Dark"
    printc "YELLOW" "-> Installing Mac Theme Pack : Dark..."
    sleep 1
    if [[ -d ${TMP_PATH}/WhiteSur-gtk-theme ]]; then
        rm -rf ${TMP_PATH}/WhiteSur-gtk-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git ${TMP_PATH}/WhiteSur-gtk-theme || handle_error "Failed to Download Mac Theme"
    bash ${TMP_PATH}/WhiteSur-gtk-theme/install.sh -c Dark -t blue || handle_error "Failed to Install Mac Theme"

    log_message "INFO" "Installing Mac Icons Pack"
    printc "YELLOW" "-> Installing WhiteSur Icons Pack..."
    sleep 1
    if [[ -d ${TMP_PATH}/WhiteSur-icon-theme ]]; then
        rm -rf ${TMP_PATH}/WhiteSur-icon-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git ${TMP_PATH}/WhiteSur-icon-theme || handle_error "Failed to Download Mac Icons"
    bash ${TMP_PATH}/WhiteSur-icon-theme/install.sh || handle_error "Failed to Install Mac Icons"

    log_message "INFO" "Installing Mac Cursors Pack"
    printc "YELLOW" "-> Installing Mac Cursors Pack..."
    if [[ -d ${TMP_PATH}/McMojave-cursors ]]; then
        rm -rf ${TMP_PATH}/McMojave-cursors
    fi
    git clone https://github.com/vinceliuice/McMojave-cursors.git ${TMP_PATH}/McMojave-cursors || handle_error "Failed to Download Mac Cursors"
    bash ${TMP_PATH}/McMojave-cursors/install.sh || handle_error "Failed to Install Mac Cursors"

    log_message "INFO" "Installing Fonts"
    printc "YELLOW" "-> Installing Fonts ${HOME}/.local/share"
    downloadFile "1lviuvDhrVpXutpp_bduXrMIvBN_RWvOS" "${TMP_PATH}/MacV1-fonts.zip" || handle_error "Failed to Download Fonts"
    unzip -o ${TMP_PATH}/MacV1-fonts.zip -d ${HOME}/.local/share || handle_error "Failed to Install Fonts"

    log_message "INFO" "Installing Wallpapers"
    printc "YELLOW" "-> Installing Wallpapers to ${HOME}/Pictures/Wallpapers/"
    downloadFile "1SdLGCEsqkP8BPllR7RPb8_2G70e4BXJu" "${TMP_PATH}/MacV1-wallpapers.zip" || handle_error "Failed to Download Mac Wallpapers"
    mkdir -p ${HOME}/Pictures/Wallpapers/ || handle_error "Failed to create ${HOME}/Pictures/Wallpapers/ Directory"
    unzip -o ${TMP_PATH}/MacV1-wallpapers.zip -d ${HOME}/Pictures/Wallpapers/ || handle_error "Failed to Install Wallpapers to ${HOME}/Pictures/Wallpapers/"

    log_message "INFO" "Installing Extensions"
    printc "YELLOW" "-> Extracting Extensions..."
    downloadFile "19t-OkOyy2skgCLPRcVk4KoXGGqcEzPCK" "${TMP_PATH}/MacV1-extensions.zip" || handle_error "Failed to Download Mac Extensions"
    unzip -o ${TMP_PATH}/MacV1-extensions.zip -d ${HOME}/.local/share/gnome-shell/ || handle_error "Failed to Install Mac Extensions"

    log_message "INFO" "Applying ulauncher Configs"
    printc "YELLOW" "-> Applying ulauncher configs..."
    downloadFile "1kBC3Pqoru1ex1wHoJOmohsyjPyKKPHYY" "${TMP_PATH}/MacV1-ulauncher.zip" || handle_error "Failed to Download ulauncher Configs"
    unzip -o ${TMP_PATH}/MacV1-ulauncher.zip -d ${HOME}/.config/ || handle_error "Failed to Apply ulauncher Configs"

    log_message "INFO" "Setting Plank and ulauncher as autostart apps"
    printc "YELLOW" "-> Setting Plank and ulauncher as autostart apps..."
    mkdir -p ${HOME}/.config/autostart/ || handle_error "Failed to Create the autostart directory"
    cp /usr/share/applications/plank.desktop ${HOME}/.config/autostart/ || handle_error "Failed to setup plank as autostart app"
    cp /usr/share/applications/ulauncher.desktop ${HOME}/.config/autostart/ || handle_error "Failed to setup ulauncher as autostart app"

    log_message "INFO" "Applying Mac V1 Configurations"
    printc "YELLOW" "-> Applying Mac V1 Configurations..." 
    dconf load / < MacV1 || handle_error "Failed to Apply Mac V1 Configurations"

    log_message "INFO" "Setting Wallpaper"
    printc "YELLOW" "-> Setting Wallpaper..."
    gsettings set org.gnome.desktop.background picture-uri-dark file://${HOME}/Pictures/Wallpapers/macosw/SequoiaDark.png || handle_error "Failed to Apply Wallpaper"

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