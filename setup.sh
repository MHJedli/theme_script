#!/bin/bash

# External Functions
source src/utils.sh

# System Release
system_release=$(cat /etc/issue)

# LOG File
LOG_FILE=src/logfile.log

# Initialize log file
echo "Starting script execution at $(date)" > "$LOG_FILE"

# Linux Mint Menu
showMintMenu(){
    log_message "INFO" "Displaying Linux Mint Menu"
    showMenu \
    "          Linux Mint              " \
    "21.3 - Cinnamon Edition" \
    "Return To Main Menu"

    read option
    log_message "INFO" "User selected option $option in Linux Mint Menu"
    case $option in
        1)
            log_message "INFO" "User chose 21.3 - Cinnamon Edition"
            showMint213CMenu
            ;;
        2)
            log_message "INFO" "User chose to return to Main Menu"
            showMainMenu
            ;;
        *)
            log_message "WARN" "User chose an invalid option : $option"
            invalidOption showMintMenu
            ;;
    esac
}

# Linux Mint 21.3 Cinnamon Menu
showMint213CMenu(){
    log_message "INFO" "Displaying Linux Mint 21.3 - Cinnamon DE Menu"
    showMenu \
    " Linux Mint 21.3 - Cinnamon DE    " \
    "MacOS BigSur" \
    "Ventura" \
    "Windows 7" \
    "Return To Main Menu"

    read option
    log_message "INFO" "User selected option $option in Linux Mint 21.3 - Cinnamon DE Menu"
    case $option in
    1)
        log_message "INFO" "User chose MacOS BigSur"
        showBigSurMenu
        ;;
    2)
        log_message "INFO" "User chose Ventura"
        showVenturaMenu
        ;;
    3)
        log_message "INFO" "User chose Windows 7"
        showWindows7Menu
        ;;
    4)
        log_message "INFO" "User chose to return to Main Menu"
        showMainMenu
        ;;
    *)
        log_message "WARN" "User chose an invalid option : $option"
        invalidOption showMint213CMenu
        ;;
    esac
}

# Windows 7 theme for LM Menu
showWindows7Menu(){

    log_message "INFO" "Displaying Windows 7 Menu"

    themeMenu "         Selected Theme : Windows 7        " \
    "${themePaths["Win7"]}/install_windows7.sh" \
    "${themePaths["Win7"]}/reset_to_defaults.sh" \
    "${themePaths["Win7"]}/Screenshots/" \
    "nemo" \
    "showMint213CMenu"
}

# MacOS BigSur theme for LM Menu
showBigSurMenu(){
    log_message "INFO" "Displaying MacOS BigSur Menu"

    themeMenu "         Selected Theme : MacOS BigSur     " \
    "${themePaths["BigSur"]}/install_bigsur.sh" \
    "${themePaths["BigSur"]}/reset_to_defaults.sh" \
    "${themePaths["BigSur"]}/Screenshots/" \
    "nemo" \
    "showMint213CMenu"
}

# MacOS Ventura-like theme for LM Menu
showVenturaMenu(){
    log_message "INFO" "Displaying Ventura Menu"

    themeMenu "           Selected Theme : Ventura        " \
    "${themePaths["Ventura"]}/install_ventura.sh" \
    "${themePaths["Ventura"]}/reset_to_defaults.sh" \
    "${themePaths["Ventura"]}/Screenshots/" \
    "nemo" \
    "showMint213CMenu"    
}

# Ubuntu Menu
showUbuntuMenu(){
    log_message "INFO" "Displaying Ubuntu Menu"
    showMenu \
    "               Ubuntu             " \
    "22.04 LTS - GNOME 42" \
    "24.04 LTS - GNOME 46" \
    "Return To Main Menu"

    read option
    log_message "INFO" "User selected option $option in Ubuntu Menu"
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
            log_message "WARN" "User chose an invalid option : $option"
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
    log_message "INFO" "User selected option $option in Ubuntu 22.04 LTS - GNOME 42 DE"
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
            log_message "WARN" "User chose an invalid option : $option"
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
    "${themePaths["WinEverforestDark"]}/install_Win11.sh" \
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

# Main Menu
showMainMenu(){
    clear
    log_message "INFO" "Displaying Main Menu"
    echo "--------------------------------------"
    echo "|   Welcome to the Theme Installer   |"
    echo "--------------------------------------"
    echo "Choose Your Linux Distribution : ( Distribution In Use -> '${system_release:0:-6}' )"
    echo '1. Ubuntu'
    echo '2. Linux Mint'
    echo "q. Quit"
    echo -n "Enter Option : "
    read option
    log_message "INFO" "User selected option $option in Main Menu"

    case $option in
        1)
            showUbuntuMenu
            log_message "INFO" "User chose Ubuntu"
            ;;
        2)
            showMintMenu
            log_message "INFO" "User chose Linux Mint"
            ;;
        q)
            log_message "INFO" "User chose to quit"
            exit 1
            ;;
        *)
            log_message "WARN" "User chose an invalid option : $option"
            invalidOption showMainMenu
            ;;
    esac
}

# Main Script
showMainMenu