#!/usr/bin/env bash

path=$(pwd)/src/Ubuntu/22.04/GNOME-42/GTK-Graphite
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

clear
echo "Continue script execution in GTK Graphite Theme Installation at $(date)" >> "$LOG_FILE"

printc "YELLOW" "-> Checking for Internet Connection..."

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"
    printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Installation"
    sleep 1

    log_message "INFO" "Updating the Database"
    printc "YELLOW" "-> Updating database..."
    sleep 1
    sudo apt update || handle_error "Failed to update System Database"
    clear

    log_message "INFO" "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions"
    printc "YELLOW" "-> Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
    sleep 1
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions jq curl -y || handle_error "Failed to install Packages"
    clear

    log_message "INFO" "Installing Themes and Icons"
    printc "YELLOW" "-> Installing Themes and Icons..."
    sleep 1
    downloadFile "1u0y0jHAf3-y553lB-U7kYsbjjMl5nmnc" "${themePaths["GTKGraphite"]}/my-icons.tar.gz" || handle_error "Failed to Download GTK Graphite Icons"
    tar --extract --file ${path}/my-icons.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Icons"

    downloadFile "11IJHFRXmZF_qWRd0tkbmelZX2OBMLVWn" "${themePaths["GTKGraphite"]}/my-themes.tar.gz" || handle_error "Failed to Download GTK Graphite Theme"
    tar --extract --file ${path}/my-themes.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Themes"
    clear

    log_message "INFO" "Installing The Extensions"
    printc "YELLOW" "-> Installing The Extensions..."
    sleep 1
    downloadFile "1DUIah7NfCBdIshA1737ToQmdB2cwJd5H" "${themePaths["GTKGraphite"]}/my-extensions.tar.gz" || handle_error "Failed to Download GTK Graphite Extensions"
    tar --extract --file ${path}/my-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Extensions"

    clear
    log_message "INFO" "Applying GTK Graphite Configurations"
    printc "YELLOW" "-> Applying GTK Graphite Configurations..."
    sleep 1
    dconf load / < ${path}/full-gnome-settings || handle_error "Failed to Apply GTK Graphite configurations"
    clear

    log_message "INFO" "Extracting Wallpapers in ~/Pictures and Applying Background"
    printc "YELLOW" "-> Extracting Wallpapers in ~/Pictures and Applying Background..."
    sleep 1
    cp -r ${path}/Wallpapers ~/Pictures || handle_error "Failed to Copy Wallpapers in ~/Pictures"
    gsettings set org.gnome.desktop.background picture-uri file://${HOME}/Pictures/Wallpapers/wave-Dark-nord-ubuntu.png || handle_error "Failed to Apply Background Wallpaper"
    clear

    signOut "gnome-session-quit --no-prompt"

else

    handle_error "No internet Connection Available. Exiting..."

fi


