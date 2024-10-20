#!/bin/bash

path=$(pwd)/src/Mint/21.3/Cinnamon-Ventura
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in Ventura Theme Installation at $(date)" >> "$LOG_FILE"

if check_internet; then
    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"

    log_message "INFO" "Updating System Database"
    echo '-> Updating System Database...'
    sleep 1
    sudo apt update || handle_error "Failed to update system database"
    clear

    log_message "INFO" "Installing Required Packages"
    echo '-> Installing Required Packages...'
    sleep 1
    sudo apt install dconf-editor nautilus git plank -y || handle_error "Failed to install Required Packages"
    clear

    log_message "INFO" "Installing WhiteSur Theme Pack : Dark"
    echo '-> Installing WhiteSur Theme Pack : Dark...'
    sleep 1
    if [[ -d $(pwd)/WhiteSur-gtk-theme ]]; then
        rm -rf $(pwd)/WhiteSur-gtk-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git || handle_error "Failed to Download WhiteSur Theme Pack"
    bash WhiteSur-gtk-theme/install.sh -c Dark -t blue || handle_error "Failed to install WhiteSur Theme Pack"
    clear

    log_message "INFO" "Installing WhiteSur Icons Pack"
    echo '-> Installing WhiteSur Icons Pack...'
    sleep 1
    if [[ -d $(pwd)/WhiteSur-icon-theme ]]; then
        rm -rf $(pwd)/WhiteSur-icon-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git || handle_error "Failed to Download WhiteSur Icon Pack"
    bash WhiteSur-icon-theme/install.sh || handle_error "Failed to Install WhiteSur Icon Pack"
    clear

    log_message "INFO" "Installing WhiteSur Cursors Pack" 
    echo '-> Installing WhiteSur Cursors Pack...'
    sleep 1
    if [[ -d $(pwd)/WhiteSur-cursors ]]; then
        rm -rf $(pwd)/WhiteSur-cursors
    fi
    git clone https://github.com/vinceliuice/WhiteSur-cursors.git || handle_error "Failed to Download WhiteSur Cursors Pack"
    bash WhiteSur-cursors/install.sh || handle_error "Failed to install WhiteSur Cursors Pack"
    clear

    log_message "INFO" "Installing Fonts to $HOME/.local/share"
    echo "-> Installing Fonts to $HOME/.local/share..."
    sleep 1
    downloadFile "1IssdCvsCdwAD8RufWMAYwP2TN0T06qaZ" "${themePaths["Ventura"]}/fonts.zip" || handle_error "Failed to Download Ventura Fonts"
    unzip -o $path/fonts.zip -d $HOME/.local/share || handle_error "Failed to install Fonts"
    clear

    log_message "INFO" "Extracting Wallpapers to $HOME/Pictures/Wallpapers"
    echo "-> Extracting Wallpapers to $HOME/Pictures/Wallpapers..."
    sleep 1
    downloadFile "1SdLGCEsqkP8BPllR7RPb8_2G70e4BXJu" "${themePaths["Ventura"]}/wallpapers.zip" || handle_error "Failed to Download Ventura Wallpapers"
    mkdir -p $HOME/Pictures/Wallpapers/ || handle_error "Failed to create $HOME/Pictures/Wallpapers/ directory"
    unzip -o $path/wallpapers.zip -d $HOME/Pictures/Wallpapers/ || handle_error "Failed to extract Wallpapers"
    clear

    log_message "INFO" "Installing Extensions and Applets"
    echo "-> Installing Extensions and Applets..."
    sleep 1
    downloadFile "19olUi-NhlmRtHcPTY4j_WjdVLfYbSC9m" "${themePaths["Ventura"]}/cinnamon.zip" || handle_error "Failed to Download Extensions and Applets"
    unzip -o $path/cinnamon.zip -d $HOME/.local/share || handle_error "Failed to install Extensions and Applets"
    clear

    log_message "INFO" "Applying Applets Configurations"
    echo "-> Applying Applets Configurations..."
    downloadFile "1w1oSdkZ1ddia0T_Zr9CeT-NUtVADETeC" "${themePaths["Ventura"]}/spices.zip" || handle_error "Failed to Download Spices"
    unzip -o $path/spices.zip -d $HOME/.config/cinnamon/ || handle_error "Failed to Apply Applets Configurations"
    sleep 1

    log_message "INFO" "Applying Ventura Configuration"
    echo "-> Applying Ventura Configuration"
    sleep 1
    cp /usr/share/applications/plank.desktop $HOME/.config/autostart/ || handle_error "Failed to Setup Plank as an autostart Application"
    dconf load / < $path/ventura-configs || handle_error "Failed to Apply Ventura Configuration"
    gsettings set org.cinnamon.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/macosw/MacVentura-Dark.jpg || handle_error "Failed to Apply Wallpaper"
    clear

    log_message "INFO" "Cleaning Up Cloned Repositories"
    echo 'Cleaning Up Cloned Repositories...'
    rm -rf WhiteSur-gtk-theme WhiteSur-icon-theme WhiteSur-cursors || handle_error "Failed to clean cloned repositories"
    clear

    signOut "cinnamon-session-quit --logout --force"

else

    handle_error "No internet Connection Available. Exiting..."

fi


