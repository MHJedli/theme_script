#!/bin/bash

path=$(pwd)/src/Ubuntu/22.04/GNOME-42/GTK-Graphite
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

clear
echo "Continue script execution in GTK Graphite Theme Installation at $(date)" >> "$LOG_FILE"


if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"
    log_message "INFO" "Updating the Database"
    echo "Updating database..."
    sleep 1
    sudo apt update || handle_error "Failed to update System Database"
    clear

    log_message "INFO" "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions , conky"
    echo "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
    sleep 1
    sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions jq curl conky -y || handle_error "Failed to install Packages"
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
tar --extract --file $path/my-extensions.tar.gz -C ~/ --strip-components=2 || handle_error "Failed to extract Extensions"
clear

while true; do
        echo -n "Do you want to install Conky System Monitor and Weather Widget ? (Y/n): "
        read -r r
        log_message "INFO" "User chose $r option"
        if [[ "$r" == "Y" || "$r" == "y" || "$r" == "" ]]; then
            log_message "INFO" "User chose to install conky widget"

            log_message "INFO" "Setting Up The Fonts and Conky"
            echo "Setting Up The Fonts and Conky..."
            sleep 1
            cp -r $path.fonts ~/ || handle_error "Failed to copy Conky fonts"
            cp -r $path.harmattan-assets ~/ || handle_error "Failed to copy Conky Assets"
            cp -r $path.harmattan-themes ~/ || handle_error "Failed to copy COnky themes"
            mkdir -p ~/.config/autostart || handle_error "Failed to create ~/.config/autostart Directory"
            cp $path/conky_startup/* ~/.config/autostart/ || handle_error "Failed to setup Conky autostart"

        elif [[ "$r" == "n" || "$r" == "N" ]]; then
            log_message "INFO" "User chose not to install conky"
            sudo apt remove conky || handle_error "Failed to remove conky"
            echo "Skipped Conky Installation..."
            sleep 1
            return
        else
            invalidOption
        fi
done

clear
log_message "INFO" "Applying GTK Graphite Configurations"
echo "Applying GTK Graphite Configurations..."
sleep 1
dconf load / < $path/full-gnome-settings || handle_error "Failed to Apply GTK Graphite configurations"
clear

log_message "INFO" "Extracting Wallpapers in ~/Pictures and Applying Background"
echo "Extracting Wallpapers in ~/Pictures and Applying Background..."
sleep 1
cp -r $path/Wallpapers ~/Pictures || handle_error "Failed to Copy Wallpapers in ~/Pictures"
gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/wave-Dark-nord-ubuntu.png || handle_error "Failed to Apply Background Wallpaper"
clear

signOut "gnome-session-quit --no-prompt"
log_message "INFO" "GTK Graphite Theme Installation Script Ended Succesfully"