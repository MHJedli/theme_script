#!/bin/bash

path=$(pwd)/src/Mint/21.3/Cinnamon-BigSur
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in BigSur Theme Installation at $(date)" >> "$LOG_FILE"

if check_internet; then
    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"

    log_message "INFO" "Updating the Database"
    echo '-> Updating the Database...'
    sleep 1
    sudo apt update || handle_error "Failed to update the Database"
    clear

    log_message "INFO" "Installing Required Packages"
    echo '-> Installing Required Packages...'
    sleep 1
    sudo apt install git sassc optipng inkscape libcanberra-gtk-module libglib2.0-dev libxml2-utils git dconf-editor -y || handle_error "Failed to install the required Packages"
    clear

    log_message "INFO" "Installing Plank Dock and Nautilus File Manager"
    echo '-> Installing Plank Dock and Nautilus File Manager...'
    sleep 1
    sudo apt install plank nautilus -y || handle_error "Failed to install Plank Dock and Nautilus File Manager"
    clear

    log_message "INFO" "Installing BigSur Icons Theme"
    echo '-> Installing Icons Theme...'
    sleep 1
    if [[ -d $(pwd)/McMojave-circle ]]; then
        rm -rf $(pwd)/McMojave-circle
    fi
    git clone https://github.com/vinceliuice/McMojave-circle.git || handle_error "Failed to clone McMojave Icons Pack"
    bash McMojave-circle/install.sh
    clear

    log_message "INFO" "Installing BigSur GTK Theme"
    echo '-> Installing GTK Theme...'
    sleep 1
    if [[ -d $(pwd)/WhiteSur-gtk-theme ]]; then
        rm -rf $(pwd)/WhiteSur-gtk-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1 || handle_error "Failed to clone WhiteSur GTK Theme Pack"
    bash WhiteSur-gtk-theme/install.sh
    clear

    log_message "INFO" "Installing BigSur Cursors Theme"
    echo '-> Installing Cursors Theme...'
    sleep 1
    if [[ -d $(pwd)/McMojave-cursors ]]; then
        rm -rf $(pwd)/McMojave-cursors
    fi
    git clone https://github.com/vinceliuice/McMojave-cursors.git || handle_error "Failed to clone McMojave Cursors Pack"
    bash McMojave-cursors/install.sh
    clear

    log_message "INFO" "Extracting and Installing BigSur Wallpapers"
    echo '-> Extracting and Installing Wallpapers...'
    sleep 1
    downloadFile "1AH54glnE5GvCXhI3dLqq0MSXG5pqwFNg" "${themePaths["BigSur"]}/Wallpapers.zip" || handle_error "Failed to Download BigSur Wallpapers"
    mkdir -p $HOME/Pictures/Wallpapers || handle_error "Failed to Create Wallpaper Directory in $HOME/Pictures/Wallpapers"
    unzip $path/Wallpapers.zip -d $HOME/Pictures/Wallpapers/ || handle_error "Failed to Extract the Wallpapers in $HOME/Pictures/Wallpapers/"
    clear

    log_message "INFO" "Applying Cinnamon DE - Bigsur Edition Theme"
    echo '-> Applying Cinnamon DE - Bigsur Edition Theme...'
    sleep 1
    downloadFile "1YUF-itvuS1uv9GMgXfUs-jWynCv8OvSN" "${themePaths["BigSur"]}/cinnamon.zip" || handle_error "Failed to Download BigSur Extensions"
    unzip $path/cinnamon.zip -d $HOME/.local/share/ || handle_error "Failed to extract Cinnamon extensions"

    downloadFile "1mFePMBCoX9n8qNEZXkjM-IyPzQSzj3m1" "${themePaths["BigSur"]}/plank_theme.zip" || handle_error "Failed to Download Plank Theme"
    mkdir -p $HOME/.local/share/plank/themes/ || handle_error "Failed to create $HOME/.local/share/plank/themes/ directory"
    unzip $path/plank_theme.zip -d $HOME/.local/share/plank/themes/ || handle_error "Failed to extract Plank Dock theme in $HOME/.local/share/plank/themes/"

    cp /usr/share/applications/plank.desktop $HOME/.config/autostart/ || handle_error "Failed to make Plank Auto-Start at Launch"

    dconf load / < $path/bigsur-configs || handle_error "Failed to import BigSur Theme configurations"

    gsettings set org.cinnamon.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/Appearance.jpg || handle_error "Failed to apply BigSur Wallpaper"
    clear

    log_message "INFO" "Cleaning Up Cloned Repositories"
    echo '-> Cleaning Up Cloned Repositories...'
    rm -rf McMojave-circle WhiteSur-gtk-theme McMojave-cursors || handle_error "Failed to clean cloned repositories"
    clear

    signOut "cinnamon-session-quit --logout --force"

else

    handle_error "No internet Connection Available. Exiting..."

fi
