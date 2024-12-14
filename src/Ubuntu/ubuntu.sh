#!/usr/bin/env bash

# External Functions/Files
source $(pwd)/src/utils.sh

# Ubuntu Main Menu
showUbuntuMenu(){
    log_message "INFO" "Displaying Ubuntu Menu"
    showMenu \
    "               Ubuntu             " \
    "22.04 LTS - GNOME 42" \
    "24.04 LTS - GNOME 46" \
    "Return To Main Menu"

    read option
    log_message "INFO" "User selected option ${option} in Ubuntu Menu"
    case $option in 
        1)
            log_message "INFO" "User chose 22.04 LTS - GNOME 42"
            showUbuntu22LTSGMenu
            ;;
        2)
            log_message "INFO" "User chose 24.04 LTS - GNOME 46"
            showUbuntu24LTSGMenu
            ;;
        3)
            log_message "INFO" "User chose to return to Main Menu"
            showMainMenu
            ;;
        *)
            log_message "WARN" "User chose an invalid option : ${option}"
            invalidOption showUbuntuMenu
            ;;
    esac
 
}

# Ubuntu 22.04 Menu
showUbuntu22LTSGMenu(){
    log_message "INFO" "Displaying Ubuntu 22.04 LTS - GNOME 42 DE Menu"

    showMenu \
    " Ubuntu 22.04 LTS - GNOME 42 DE   " \
    "GTK Graphite" \
    "My P Theme" \
    "Windows 11" \
    "Windows Everforest Dark" \
    "MacOS V1" \
    "Return To Previous Menu"

    read option
    log_message "INFO" "User selected option ${option} in Ubuntu 22.04 LTS - GNOME 42 DE"
    case $option in
        1)
            log_message "INFO" "User chose GTK Graphite"
            showGGThemeMenu
            ;;
        2)
            log_message "INFO" "User chose My P Theme"
            showPThemeMenu
            ;;
        3)
            log_message "INFO" "User chose Windows 11"
            showWinEThemeMenu
            ;;
        4)
            log_message "INFO" "User chose Windows Everforest Dark"
            showWinEDThemeMenu
            ;;
        5)
            log_message "INFO" "User chose MacOS V1"
            showMacV1Menu
            ;;
        6)
            log_message "INFO" "User chose to return to previous Menu"
            showUbuntuMenu
            ;;
        *)
            log_message "WARN" "User chose an invalid option : ${option}"
            invalidOption showUbuntu22LTSGMenu
            ;;
    esac
}

# MacOS V1 Menu
showMacV1Menu(){

    themeMenu \
    "          Selected Theme : MacOS V1        " \
    "${themePaths["MacV1"]}/install_MacV1.sh" \
    "${themePaths["MacV1"]}/reset_to_defaults.sh" \
    "${themePaths["MacV1"]}/Screenshots/" \
    "nautilus" "showUbuntu22LTSGMenu"

}

# GTK Graphite Menu
showGGThemeMenu(){

    themeMenu \
    "        Selected Theme : GTK Graphite      " \
    "${themePaths["GTKGraphite"]}/install_GG.sh" \
    "${themePaths["GTKGraphite"]}/reset_to_defaults.sh" \
    "${themePaths["GTKGraphite"]}/Screenshots/" \
    "nautilus" "showUbuntu22LTSGMenu"
}

# My Personal Theme Menu
showPThemeMenu(){

    themeMenu \
    "         Selected Theme : My P Theme       " \
    "${themePaths["PTheme"]}/install_MP.sh" \
    "${themePaths["PTheme"]}/reset_to_defaults.sh" \
    "${themePaths["PTheme"]}/Screenshots/" \
    "nautilus" "showUbuntu22LTSGMenu"
}

# Windows 11 Theme Menu
showWinEThemeMenu(){

    themeMenu \
    "         Selected Theme : Windows 11       " \
    "${themePaths["Win11"]}/install_Win11.sh" \
    "${themePaths["Win11"]}/reset_to_defaults.sh" \
    "${themePaths["Win11"]}/Screenshots/" \
    "nautilus" \
    "showUbuntu22LTSGMenu"
}

# Windows Everforest Theme Menu
showWinEDThemeMenu(){

    themeMenu \
    "   Selected Theme : Windows Everforest Dark" \
    "${themePaths["WinEverforestDark"]}/install_WinED.sh" \
    "${themePaths["WinEverforestDark"]}/reset_to_defaults.sh" \
    "${themePaths["WinEverforestDark"]}/Screenshots/" \
    "nautilus" \
    "showUbuntu22LTSGMenu"
}

# Ubuntu 24.04
showUbuntu24LTSGMenu(){
    log_message "INFO" "Displaying Ubuntu 24.04 LTS - GNOME 46 DE Menu"
    clear
    echo 'Themes Will Be Available Soon For Ubuntu 24.04...'
    sleep 2
    showUbuntuMenu
}
