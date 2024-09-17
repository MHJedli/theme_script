#!/bin/bash

path=$(pwd)/src/Ubuntu/22.04/GNOME-42/My-Theme
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log

trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in My Personal Theme Installation at $(date)" >> "$LOG_FILE"

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"

    log_message "INFO" "Updating the Database"
    echo "Updating database..."
    sleep 1
    sudo apt update || handle_error "Failed to update the Database"
    clear
    
    log_message "INFO" "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions"
    echo "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
    sleep 1
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions -y || handle_error "Failed to install packages"
    clear


else

    handle_error "No internet Connection Available. Exiting..."

fi


log_message "INFO" "Installing Themes and Icons"
echo "Installing Themes and Icons..."
sleep 1
tar --extract --file $path/my-icons.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Icons"
tar --extract --file $path/my-themes.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Themes"
clear

log_message "INFO" "Installing The Extensions"
echo "Installing The Extensions..."
sleep 1
tar --extract --file $path/my-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to Extract the Extensions"
clear

log_message "INFO" "Applying My Personal Theme Configurations"
echo "Applying My Personal Theme Configurations..."
sleep 1
dconf load / < $path/full-gnome-settings || handle_error "Failed to Apply My Personal Theme configurations"
clear

log_message "INFO" "Extracting Wallpapers in ~/Pictures and Applying Background"
echo "Extracting Wallpapers in ~/Pictures and Applying Background..."
sleep 1
cp $path/Background/wallpaper.jpg ~/Pictures || handle_error "Failed to Copy Wallpapers in ~/Pictures"
gsettings set org.gnome.desktop.background picture-uri-dark file://$HOME/Pictures/wallpaper.jpg || handle_error "Failed to Apply Background Wallpaper"
clear

signOut "gnome-session-quit --no-prompt"
log_message "INFO" "My Personal Theme Installation Script Ended Succesfully"