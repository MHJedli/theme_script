#!/bin/bash

# External Functions
source src/utils.sh

# Linux Mint Menu
showMintMenu(){
    showMenu "          Linux Mint              " "21.3 - Cinnamon Edition" "Return To Main Menu"
    read option
    case $option in
        1)
            showMint213CMenu
            ;;
        2)
            showMainMenu
            ;;
        *)
            invalidOption showMintMenu
            ;;
    esac
}

# Linux Mint 21.3 Cinnamon Menu
showMint213CMenu(){
    showMenu " Linux Mint 21.3 - Cinnamon DE    " "MacOS BigSur" "Return To Main Menu"
    read option
    case $option in
    1)
        showBigSurMenu
        ;;
    2)
        showMainMenu
        ;;
    *)
        invalidOption showMint213CMenu
        ;;
    esac
}


# MacOS BigSur theme for LM Menu
showBigSurMenu(){
    themeMenu "Selected Theme : MacOS BigSur " "${themePaths["BigSur"]}/install_bigsur.sh" "${themePaths["BigSur"]}/Screenshots/" "nemo" "showMint213CMenu"
}

# Ubuntu Menu
showUbuntuMenu(){
    showMenu "               Ubuntu             " "22.04 LTS - GNOME 42" "24.04 LTS - GNOME 46" "Return To Main Menu"
    read option
    case $option in 
        1)
            showUbuntu22LTSGMenu
            ;;
        2)
            showUbuntu24LTSGMenu
            ;;
        3)
            showMainMenu
            ;;
        *)
            invalidOption showUbuntuMenu
            ;;
    esac
 
}

# Ubuntu 22.04 Menu
showUbuntu22LTSGMenu(){
    showMenu " Ubuntu 22.04 LTS - GNOME 42 DE   " "GTK Graphite" "My P Theme" "Windows 11" "Windows Everforest Dark" "Return To Previous Menu"
    read option
    case $option in
        1)
            showGGThemeMenu
            ;;
        2)
            showPThemeMenu
            ;;
        3)
            showWinEThemeMenu
            ;;
        4)
            showWinEDThemeMenu
            ;;
        5)
            showUbuntuMenu
            ;;
        *)
            invalidOption showUbuntu22LTSGMenu
            ;;
    esac
}

# GTK Graphite Menu
showGGThemeMenu(){
    themeMenu "        Selected Theme : GTK Graphite      " "${themePaths["GTKGraphite"]}/install_GG.sh" "${themePaths["GTKGraphite"]}/Screenshots/" "nautilus" "showUbuntu22LTSGMenu"
}

# My Personal Theme Menu
showPThemeMenu(){
    themeMenu "         Selected Theme : My P Theme       " "${themePaths["PTheme"]}/install_MP.sh" "${themePaths["PTheme"]}/Screenshots/" "nautilus" "showUbuntu22LTSGMenu"
}

# Windows 11 Theme Menu
showWinEThemeMenu(){
    themeMenu "         Selected Theme : Windows 11       " "${themePaths["Win11"]}/install_Win11.sh" "${themePaths["Win11"]}/Screenshots/" "nautilus" "showUbuntu22LTSGMenu"
}

# Windows Everforest Theme Menu
showWinEDThemeMenu(){
    themeMenu "   Selected Theme : Windows Everforest Dark" "${themePaths["WinEverforestDark"]}/install_Win11.sh" "${themePaths["WinEverforestDark"]}/Screenshots/" "nautilus" "showUbuntu22LTSGMenu"
}

# Ubuntu 24.04
showUbuntu24LTSGMenu(){
    clear
    echo 'Themes Will Be Available Soon For Ubuntu 24.04...'
    sleep 2
    showUbuntuMenu
}

# Main Menu
showMainMenu(){
    clear
    echo "--------------------------------------"
    echo "|   Welcome to the Theme Installer   |"
    echo "--------------------------------------"
    echo 'Choose Your Linux Distribution :'
    echo '1. Ubuntu'
    echo '2. Linux Mint'
    echo "q. Quit"
    echo -n "Enter Option : "
    read option

    case $option in
        1)
            showUbuntuMenu
            ;;
        2)
            showMintMenu
            ;;
        q)
            exit 1
            ;;
        *)
            invalidOption showMainMenu
            ;;
    esac
}

# Main Script
showMainMenu