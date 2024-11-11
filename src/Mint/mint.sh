#!/bin/bash

# External Functions/Files
source $(pwd)/src/utils.sh

# Linux Mint Main Menu
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