#!/bin/bash

path=$(pwd)/src/Mint/21.3/Windows-7
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

echo "Continue script execution in Windows 7 Theme Installation at $(date)" >> "$LOG_FILE"

clear
if check_internet; then
  log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"

  log_message "INFO" "Updating the DataBase"
  echo '-> Updating Database...'
  sleep 1
  sudo apt update || handle_error "Failed to update the Database"

  clear
  log_message "INFO" "Installing Dconf Editor"
  echo '-> Installing Dconf Editor...'
  sudo apt install dconf-editor || handle_error "Failed to install Dconf Editor"

  clear
  log_message "INFO" "Installing Windows 7 Theme"
  echo '-> Installing Theme...'
  sleep 1
  downloadFile "1oNmWWd-zzgpqNo9lCkydXe7lWV-KckSQ" "${themePaths["Win7"]}/Windows-7-theme.zip" || handle_error "Failed to Download Windows 7 Theme"
  mkdir -p $HOME/.themes || handle_error "Failed to create ~/.themes directory"
  unzip $path/Windows-7-theme.zip -d $HOME/.themes || handle_error "Failed to Extract Windows 7 Theme"

  clear
  log_message "INFO" "Installing Windows 7 Icons"
  echo '-> Installing Icons...'
  sleep 1
  downloadFile "1K00zSz8Rbv1vsWnkI3nowTumiX__sr2z" "${themePaths["Win7"]}/Windows-7-icons.zip" || handle_error "Failed to Download Windows 7 Icons"
  mkdir -p $HOME/.icons || handle_error "Failed to Create ~/.icons directory"
  unzip $path/Windows-7-icons.zip -d $HOME/.icons || handle_error "Failed to Extract Windows 7 icons"

  clear
  log_message "INFO" "Extracting and Installing Windows 7 Wallpaper to $HOME/Pictures"
  echo "-> Installing Wallpapers to $HOME/Pictures"
  sleep 1
  downloadFile "1MYkqvFKj2Q0AeheVw9tCSeME4_9a-x6N" "${themePaths["Win7"]}/Windows-7-wallpaper.zip" || handle_error "Failed to Download Windows 7 Wallpapers"
  mkdir -p $HOME/Pictures/Wallpapers || handle_error "Failed to Create ~/Pictures/Wallpapers directory"
  unzip $path/Windows-7-wallpaper.zip -d $HOME/Pictures/Wallpapers || handle_error "Failed to Extract Windows 7 Wallpapers"

  log_message "INFO" "Applying Windows 7 Theme"
  echo '-> Applying Windows 7 Theme...'
  downloadFile "1oytGtqqLeosE6DZ0CYE7qTMdPfdvY5Oz" "${themePaths["Win7"]}/cinnamon.zip" || handle_error "Failed to Download Cinnamon Extensions"
  unzip $path/cinnamon.zip -d $HOME/.local/share/ || handle_error "Failed to Extract Cinnamon Extensions"
  dconf load / < $path/windows-7-config || handle_error "Failed to load Windows 7 Configs"
  gsettings set org.cinnamon.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/windows-7-wallpaper.jpg || handle_error "Failed to apply Windows 7 Wallpaper"

  clear
  log_message "INFO" "Siging Out"
  signOut "cinnamon-session-quit --logout --force"

else

  handle_error "No internet Connection Available. Exiting..."

fi

