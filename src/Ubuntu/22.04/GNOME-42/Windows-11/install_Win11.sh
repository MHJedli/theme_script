#!/bin/bash

path=$(pwd)/src/Ubuntu/22.04/GNOME-42/Windows-11
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log

trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in Windows 11 Theme Installation at $(date)" >> "$LOG_FILE"

if check_internet; then
    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"

    log_message "INFO" "Updating the database"
    echo "Updating the database..."
    sleep 1
    sudo apt update || handle_error "Failed to update the database"
    clear

    log_message "INFO" "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions"
    echo "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
    sleep 1
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions -y || handle_error "Failed to install packages"
    clear

else

    handle_error "No internet Connection Available. Exiting..."

fi


log_message "INFO" "Installing Themes, Icons and Fonts"
echo "Installing Themes, Icons and Fonts..."
sleep 1
tar --extract --file $path/my-icons.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Icons"
tar --extract --file $path/my-themes.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Themes"
tar --extract --file $path/my-fonts.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Fonts"
clear

log_message "INFO" "Installing The Extensions"
echo "Installing The Extensions..."
sleep 1
tar --extract --file $path/my-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract the Extensions"
clear

log_message "INFO" "Applying Windows 11 Configurations"
echo "Applying Windows 11 Configurations..."
sleep 1
dconf load / < $path/full-gnome-settings || handle_error "Failed to apply Windows 11 configurations"
clear

log_message "INFO" "Extracting Wallpapers in ~/Pictures and Applying Background"
echo "Extracting Wallpapers in ~/Pictures and Applying Background..."
sleep 1
mkdir -p ~/Pictures/Wallpapers || handle_error "Failed to create ~/Pictures/Wallpapers Directory"
cp -r $path/Background/* ~/Pictures/Wallpapers || handle_error "Failed to copy Wallpapers"
gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/windows-11-blue-stock-white-background-light-official-3840x2400-5616.jpg || handle_error "Failed to Apply Background Theme"
clear

signOut "gnome-session-quit --no-prompt"
log_message "INFO" "Windows 11 Theme Installation Script Ended Succesfully"