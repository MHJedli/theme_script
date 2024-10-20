#!/bin/bash

path=$(pwd)/src/Ubuntu/22.04/GNOME-42/Windows-Everforest-Dark
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log

trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in Windows Everforest Dark Theme Installation at $(date)" >> "$LOG_FILE"

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"

    log_message "INFO" "Updating the database"
    echo "-> Updating the database..."
    sleep 1
    sudo apt update || handle_error "Failed to update the database"
    clear

    log_message "INFO" "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions"
    echo "-> Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
    sleep 1
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions -y || handle_error "Failed to install packages"
    clear

    log_message "INFO" "Installing Themes and Icons"
    echo "-> Installing Themes, Icons and Fonts..."
    sleep 1
    downloadFile "1KD9U60x1HBIz0TDW_Ls9vuzly2JaevNb" "${themePaths["WinEverforestDark"]}/my-icons.tar.gz" || handle_error "Failed to Download Windows EFD Icons"
    tar --extract --file $path/my-icons.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Icons"

    downloadFile "1WlirjnbDuj1CQ_M6poFcSngTFcRjQwnY" "${themePaths["WinEverforestDark"]}/my-themes.tar.gz" || handle_error "Failed to Download Windows EFD Theme" 
    tar --extract --file $path/my-themes.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Themes"
    clear

    log_message "INFO" "Installing The Extensions"
    echo "-> Installing The Extensions..."
    sleep 1
    downloadFile "1d53yTX9O3_wv5M31pg3AT_DHs6U6W5Lb" "${themePaths["WinEverforestDark"]}/my-extensions.tar.gz" || handle_error "Failed to Download Windows EFD Extensions"
    tar --extract --file $path/my-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract the Extensions"
    clear

    log_message "INFO" "Windows Everforest Dark Theme Configurations"
    echo "-> Windows Everforest Dark Theme Configurations..."
    sleep 1
    dconf load / < $path/full-gnome-settings || handle_error "Failed to apply Windows Everforest Dark Theme Configurations"
    clear

    log_message "INFO" "Extracting Wallpapers in ~/Pictures and Applying Background"
    echo "-> Extracting Wallpapers in ~/Pictures and Applying Background..."
    sleep 1
    cp $path/Background/wallpaper.jpg ~/Pictures || handle_error "Failed to copy Wallpapers to ~/Pictures"
    gsettings set org.gnome.desktop.background picture-uri-dark file://$HOME/Pictures/wallpaper.jpg || handle_error "Failed to Apply Background Wallpaper"
    clear

    signOut "gnome-session-quit --no-prompt"

else

    handle_error "No internet Connection Available. Exiting..."

fi

