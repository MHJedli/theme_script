#!/usr/bin/env bash

# External Functions/Files
ROOT_PATH=$(pwd)
TMP_PATH="${ROOT_PATH}/tmp"
UTILS="${ROOT_PATH}/src/utils.sh"
source "$UTILS"
LOG_FILE="${ROOT_PATH}/src/logfile.log"

trap 'handle_error "An unexpected error occurred."' ERR
clear

# Begin Windows 7 Theme Installation
echo "Continue script execution in Windows 7 Theme Installation at $(date)" >> "$LOG_FILE"

log_message "INFO" "Changing to the script directory"
printc "YELLOW" "-> Changing to the script directory..."
cd "$(dirname "${BASH_SOURCE[0]}")" && pwd || handle_error "Failed to change to the script directory"

printc "YELLOW" "-> Checking for Internet Connection..."

if check_internet; then

  log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"
  printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Installation..."

  log_message "INFO" "Updating the DataBase"
  printc "YELLOW" "-> Updating Database..."
  sudo apt update || handle_error "Failed to update the Database"

  log_message "INFO" "Installing Dconf Editor"
  printc "YELLOW" "-> Installing Dconf Editor..."
  sudo apt install dconf-editor || handle_error "Failed to install Dconf Editor"

  log_message "INFO" "Installing Windows 7 Theme"
  printc "YELLOW" "-> Installing Windows 7 Theme..."
  downloadFile "1oNmWWd-zzgpqNo9lCkydXe7lWV-KckSQ" "${TMP_PATH}/Windows-7-theme.zip" || handle_error "Failed to Download Windows 7 Theme"
  mkdir -p ${HOME}/.themes || handle_error "Failed to create ~/.themes directory"
  unzip ${TMP_PATH}/Windows-7-theme.zip -d ${HOME}/.themes || handle_error "Failed to Extract Windows 7 Theme"

  log_message "INFO" "Installing Windows 7 Icons"
  printc "YELLOW" "-> Installing Windows 7 Icons..."
  downloadFile "1K00zSz8Rbv1vsWnkI3nowTumiX__sr2z" "${TMP_PATH}/Windows-7-icons.zip" || handle_error "Failed to Download Windows 7 Icons"
  mkdir -p ${HOME}/.icons || handle_error "Failed to Create ~/.icons directory"
  unzip ${TMP_PATH}/Windows-7-icons.zip -d ${HOME}/.icons || handle_error "Failed to Extract Windows 7 icons"

  log_message "INFO" "Extracting and Installing Windows 7 Wallpaper to ${HOME}/Pictures"
  printc "YELLOW" "-> Installing Wallpapers to ${HOME}/Pictures..."
  downloadFile "1MYkqvFKj2Q0AeheVw9tCSeME4_9a-x6N" "${TMP_PATH}/Windows-7-wallpaper.zip" || handle_error "Failed to Download Windows 7 Wallpapers"
  mkdir -p ${HOME}/Pictures/Wallpapers || handle_error "Failed to Create ~/Pictures/Wallpapers directory"
  unzip ${TMP_PATH}/Windows-7-wallpaper.zip -d ${HOME}/Pictures/Wallpapers || handle_error "Failed to Extract Windows 7 Wallpapers"

  log_message "INFO" "Applying Windows 7 Theme"
  printc "YELLOW" "-> Applying Windows 7 Theme..."
  downloadFile "1oytGtqqLeosE6DZ0CYE7qTMdPfdvY5Oz" "${TMP_PATH}/cinnamon.zip" || handle_error "Failed to Download Cinnamon Extensions"
  unzip ${TMP_PATH}/cinnamon.zip -d ${HOME}/.local/share/ || handle_error "Failed to Extract Cinnamon Extensions"

  dconf load / < windows-7-config || handle_error "Failed to load Windows 7 Configs"
  gsettings set org.cinnamon.desktop.background picture-uri file://${HOME}/Pictures/Wallpapers/windows-7-wallpaper.jpg || handle_error "Failed to apply Windows 7 Wallpaper"

  echo "Windows 7 Theme Installation Completed Successfully at $(date)" >> "$LOG_FILE"

  log_message "INFO" "Cleaning up temporary files"
  printc "YELLOW" "-> Cleaning up temporary files..."
  rm -rf ${TMP_PATH}/*

  if whiptail --title "Windows 7 Theme Installation" --yesno "Windows 7 Theme has been installed successfully.\nDo you want to sign out to fully apply the theme ?" 10 60; then
      log_message "INFO" "User chose to sign out after installation"
      cinnamon-session-quit --logout --force || handle_error "Failed to sign out"
  fi

else

  handle_error "No internet Connection Available. Exiting..."

fi
# End Windows 7 Theme Installation