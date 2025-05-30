#!/usr/bin/env bash

# External Functions/Files
ROOT_PATH=$(pwd)
TMP_PATH="${ROOT_PATH}/tmp"
UTILS="${ROOT_PATH}/src/utils.sh"
source "$UTILS"
LOG_FILE="${ROOT_PATH}/src/logfile.log"

trap 'handle_error "An unexpected error occurred."' ERR
clear


# Begin Ventura Theme Installation
echo "Continue script execution in Ventura Theme Installation at $(date)" >> "$LOG_FILE"

log_message "INFO" "Changing to the script directory"
printc "YELLOW" "-> Changing to the script directory..."
cd "$(dirname "${BASH_SOURCE[0]}")" && pwd || handle_error "Failed to change to the script directory"

printc "YELLOW" "-> Checking For Internet Connection..."

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"
    printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Installation..."

    log_message "INFO" "Updating System Database"
    printc "YELLOW" "-> Updating System Database..."
    sudo apt update || handle_error "Failed to update system database"

    log_message "INFO" "Installing Required Packages"
    printc "YELLOW" "-> Installing Required Packages..."
    sudo apt install dconf-editor nautilus git plank -y || handle_error "Failed to install Required Packages"

    log_message "INFO" "Installing WhiteSur Theme Pack : Dark"
    printc "YELLOW" "-> Installing WhiteSur Theme Pack : Dark..."
    if [[ -d ${TMP_PATH}/WhiteSur-gtk-theme ]]; then
        rm -rf ${TMP_PATH}/WhiteSur-gtk-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git ${TMP_PATH}/WhiteSur-gtk-theme || handle_error "Failed to Download WhiteSur Theme Pack"
    bash ${TMP_PATH}/WhiteSur-gtk-theme/install.sh -c Dark -t blue || handle_error "Failed to install WhiteSur Theme Pack"

    log_message "INFO" "Installing WhiteSur Icons Pack"
    printc "YELLOW" "-> Installing WhiteSur Icons Pack..."
    if [[ -d ${TMP_PATH}/WhiteSur-icon-theme ]]; then
        rm -rf ${TMP_PATH}/WhiteSur-icon-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git ${TMP_PATH}/WhiteSur-icon-theme || handle_error "Failed to Download WhiteSur Icon Pack"
    bash ${TMP_PATH}/WhiteSur-icon-theme/install.sh || handle_error "Failed to Install WhiteSur Icon Pack"

    log_message "INFO" "Installing WhiteSur Cursors Pack" 
    printc "YELLOW" "-> Installing WhiteSur Cursors Pack..."
    if [[ -d ${TMP_PATH}/WhiteSur-cursors ]]; then
        rm -rf ${TMP_PATH}/WhiteSur-cursors
    fi
    git clone https://github.com/vinceliuice/WhiteSur-cursors.git ${TMP_PATH}/WhiteSur-cursors || handle_error "Failed to Download WhiteSur Cursors Pack"
    bash ${TMP_PATH}/WhiteSur-cursors/install.sh || handle_error "Failed to install WhiteSur Cursors Pack"

    log_message "INFO" "Installing Fonts to ${HOME}/.local/share"
    printc "YELLOW" "-> Installing Fonts to ${HOME}/.local/share..."
    downloadFile "1IssdCvsCdwAD8RufWMAYwP2TN0T06qaZ" "${TMP_PATH}/fonts.zip" || handle_error "Failed to Download Ventura Fonts"
    unzip -o ${TMP_PATH}/fonts.zip -d ${HOME}/.local/share || handle_error "Failed to install Fonts"

    log_message "INFO" "Extracting Wallpapers to ${HOME}/Pictures/Wallpapers"
    printc "YELLOW" "-> Extracting Wallpapers to ${HOME}/Pictures/Wallpapers..."
    downloadFile "1SdLGCEsqkP8BPllR7RPb8_2G70e4BXJu" "${TMP_PATH}/wallpapers.zip" || handle_error "Failed to Download Ventura Wallpapers"
    mkdir -p ${HOME}/Pictures/Wallpapers/ || handle_error "Failed to create ${HOME}/Pictures/Wallpapers/ directory"
    unzip -o ${TMP_PATH}/wallpapers.zip -d ${HOME}/Pictures/Wallpapers/ || handle_error "Failed to extract Wallpapers"

    log_message "INFO" "Installing Extensions and Applets"
    printc "YELLOW" "-> Installing Extensions and Applets..."
    downloadFile "19olUi-NhlmRtHcPTY4j_WjdVLfYbSC9m" "${TMP_PATH}/cinnamon.zip" || handle_error "Failed to Download Extensions and Applets"
    unzip -o ${TMP_PATH}/cinnamon.zip -d ${HOME}/.local/share || handle_error "Failed to install Extensions and Applets"

    log_message "INFO" "Applying Applets Configurations"
    printc "YELLOW" "-> Applying Applets Configurations..."
    downloadFile "1w1oSdkZ1ddia0T_Zr9CeT-NUtVADETeC" "${TMP_PATH}/spices.zip" || handle_error "Failed to Download Spices"
    unzip -o ${TMP_PATH}/spices.zip -d ${HOME}/.config/cinnamon/ || handle_error "Failed to Apply Applets Configurations"

    log_message "INFO" "Applying Ventura Cinnamon Configuration"
    printc "YELLOW" "-> Applying Ventura Cinnamon Configuration"
    cp /usr/share/applications/plank.desktop ${HOME}/.config/autostart/ || handle_error "Failed to Setup Plank as an autostart Application"
    dconf load / < ventura-configs || handle_error "Failed to Apply Ventura Configuration"
    gsettings set org.cinnamon.desktop.background picture-uri file://${HOME}/Pictures/Wallpapers/macosw/MacVentura-Dark.jpg || handle_error "Failed to Apply Wallpaper"

    echo "MacOS V1 Theme Installation Completed Successfully at $(date)" >> "$LOG_FILE"

    log_message "INFO" "Cleaning up temporary files"
    printc "YELLOW" "-> Cleaning up temporary files..."
    rm -rf ${TMP_PATH}/*

    if whiptail --title "Ventura Theme Installation" --yesno "Ventura Theme has been installed successfully.\nDo you want to sign out to fully apply the theme ?" 10 60; then
        log_message "INFO" "User chose to sign out after installation"
        cinnamon-session-quit --logout --force || handle_error "Failed to sign out"
    fi

else

    handle_error "No internet Connection Available. Exiting..."

fi
# End Ventura Theme Installation