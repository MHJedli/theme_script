#!/usr/bin/env bash

path=$(pwd)/src/Ubuntu/22.04/GNOME-42/MacOS-V1
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
trap 'handle_error "An unexpected error occurred."' ERR

clear

echo "Continue script execution in MacOS V1 Theme Installation at $(date)" >> "$LOG_FILE"

printc "YELLOW" "-> Checking for Internet Connection..."

if check_internet; then

    log_message "INFO" "Internet Connection Detected. Proceeding with Theme Installation"
    printc "GREEN" "-> Internet Connection Detected. Proceeding with Theme Installation..."
    sleep 1

    log_message "INFO" "Updating System Database"
    printc "YELLOW" "-> Updating System Database..."
    sleep 1
    sudo apt update || handle_error "Failed to Update System Database"
    clear

    log_message "INFO" "Installing Required Packages"
    printc "YELLOW" "-> Installing Required Packages..."
    sleep 1
    sudo apt install plank dconf-editor gnome-tweaks gnome-shell-extensions -y || handle_error "Failed to Install Required Packages"

    log_message "INFO" "Installing ulauncher"
    printc "YELLOW" "-> Installing ulauncher..."
    sleep 1
    sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update && sudo apt install ulauncher -y || handle_error "Failed to Install ulauncher"

    log_message "INFO" "Installing Mac Theme Pack : Dark"
    printc "YELLOW" "-> Installing Mac Theme Pack : Dark..."
    sleep 1
    if [[ -d $(pwd)/WhiteSur-gtk-theme ]]; then
        rm -rf $(pwd)/WhiteSur-gtk-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git || handle_error "Failed to Download Mac Theme"
    bash WhiteSur-gtk-theme/install.sh -c Dark -t blue || handle_error "Failed to Install Mac Theme"
    clear

    log_message "INFO" "Installing Mac Icons Pack"
    printc "YELLOW" "-> Installing WhiteSur Icons Pack..."
    sleep 1
    if [[ -d $(pwd)/WhiteSur-icon-theme ]]; then
        rm -rf $(pwd)/WhiteSur-icon-theme
    fi
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git || handle_error "Failed to Download Mac Icons"
    bash WhiteSur-icon-theme/install.sh || handle_error "Failed to Install Mac Icons"
    clear

    log_message "INFO" "Installing Mac Cursors Pack"
    printc "YELLOW" "-> Installing Mac Cursors Pack..."
    sleep 1
    if [[ -d $(pwd)/WhiteSur-cursors ]]; then
        rm -rf $(pwd)/WhiteSur-cursors
    fi
    git clone https://github.com/vinceliuice/McMojave-cursors.git || handle_error "Failed to Download Mac Cursors"
    bash McMojave-cursors/install.sh || handle_error "Failed to Install Mac Cursors"
    clear

    log_message "INFO" "Installing Fonts"
    printc "YELLOW" "-> Installing Fonts ${HOME}/.local/share"
    sleep 1
    downloadFile "1lviuvDhrVpXutpp_bduXrMIvBN_RWvOS" "${themePaths["MacV1"]}/fonts.zip" || handle_error "Failed to Download Fonts"
    unzip -o ${path}/fonts.zip -d ${HOME}/.local/share || handle_error "Failed to Install Fonts"
    clear

    log_message "INFO" "Installing Wallpapers"
    printc "YELLOW" "-> Installing Wallpapers to ${HOME}/Pictures/Wallpapers/"
    sleep 1
    downloadFile "1SdLGCEsqkP8BPllR7RPb8_2G70e4BXJu" "${themePaths["MacV1"]}/wallpapers.zip" || handle_error "Failed to Download Mac Wallpapers"
    mkdir -p ${HOME}/Pictures/Wallpapers/ || handle_error "Failed to create ${HOME}/Pictures/Wallpapers/ Directory"
    unzip -o ${path}/wallpapers.zip -d ${HOME}/Pictures/Wallpapers/ || handle_error "Failed to Install Wallpapers to ${HOME}/Pictures/Wallpapers/"
    clear

    log_message "INFO" "Installing Extensions"
    printc "YELLOW" "-> Extracting Extensions..."
    sleep 1
    downloadFile "19t-OkOyy2skgCLPRcVk4KoXGGqcEzPCK" "${themePaths["MacV1"]}/extensions.zip" || handle_error "Failed to Download Mac Extensions"
    unzip -o ${path}/extensions.zip -d ${HOME}/.local/share/gnome-shell/ || handle_error "Failed to Install Mac Extensions"
    clear

    log_message "INFO" "Applying ulauncher Configs"
    printc "YELLOW" "-> Applying ulauncher configs..."
    sleep 1
    downloadFile "1kBC3Pqoru1ex1wHoJOmohsyjPyKKPHYY" "${themePaths["MacV1"]}/ulauncher.zip" || handle_error "Failed to Download ulauncher Configs"
    unzip -o ${path}/ulauncher.zip -d ${HOME}/.config/ || handle_error "Failed to Apply ulauncher Configs"
    clear

    log_message "INFO" "Setting Plank and ulauncher as autostart apps"
    printc "YELLOW" "-> Setting Plank and ulauncher as autostart apps..."
    sleep 1
    mkdir -p ${HOME}/.config/autostart/ || handle_error "Failed to Create the autostart directory"
    cp /usr/share/applications/plank.desktop ${HOME}/.config/autostart/ || handle_error "Failed to setup plank as autostart app"
    cp /usr/share/applications/ulauncher.desktop ${HOME}/.config/autostart/ || handle_error "Failed to setup ulauncher as autostart app"
    clear

    log_message "INFO" "Applying Mac V1 Configurations"
    printc "YELLOW" "-> Applying Mac V1 Configurations..." 
    dconf load / < ${path}/MacV1 || handle_error "Failed to Apply Mac V1 Configurations"
    clear

    log_message "INFO" "Setting Wallpaper"
    printc "YELLOW" "-> Setting Wallpaper..."
    sleep 1
    gsettings set org.gnome.desktop.background picture-uri-dark file://${HOME}/Pictures/Wallpapers/macosw/SequoiaDark.png || handle_error "Failed to Apply Wallpaper"

    signOut "gnome-session-quit --no-prompt"

else

    handle_error "No internet Connection Available. Exiting..."

fi