#!/bin/bash

# Linux Mint Menu
showMintMenu(){
    clear
    echo "--------------------------------------"
    echo "|             Linux Mint             |"
    echo "--------------------------------------"
    echo '1. 21.3 - Cinnamon Edition'
    echo '2. Return To Main Menu'
    echo -n 'Enter Option: '
    read option

    case $option in
        1)
            showMint213CMenu
            ;;
        2)
            showMainMenu
            ;;
        *)
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showMintMenu
            ;;
    esac
}

# Linux Mint 21.3 Cinnamon Menu
showMint213CMenu(){
    clear
    echo "--------------------------------------"
    echo "|    Linux Mint 21.3 - Cinnamon DE    |"
    echo "--------------------------------------"
    echo "Choose The Theme That You Want To Apply : "
    echo '1. MacOS BigSur'
    echo '2. Return To Main Menu'
    echo -n "Enter Option :"
    read option
    case $option in
    1)
        showBigSurMenu
        ;;
    2)
        showMainMenu
        ;;
    *)
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showMint213CMenu
            ;;
    esac
}

# MacOS BigSur theme for LM Menu
showBigSurMenu(){
    clear
    Path="src/Mint/21.3/Cinnamon-BigSur"
    echo "--------------------------------------"
    echo "|    Linux Mint 21.3 - Cinnamon DE   |"
    echo "|------------------------------------|"
    echo "|    Selected Theme : MacOS BigSur   |"
    echo "--------------------------------------"
    echo "1. Apply Theme"
    echo "2. Preview Theme"
    echo "3. Return To Previous Menu"
    echo -n "Enter Option: "
    read option
    case $option in
    1)
        bash $Path/install_bigsur.sh
        ;;
    2)
        nemo $Path/Screenshots/
        showBigSurMenu
        ;;
    3)
        showMint213CMenu
        ;;
    *)
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showBigSurMenu
            ;;
    esac
}

# Ubuntu Menu
showUbuntuMenu(){
    clear
    echo "--------------------------------------"
    echo "|                Ubuntu              |"
    echo "--------------------------------------"
    echo '1. Ubuntu 22.04 LTS - GNOME 42'
    echo '2. Ubuntu 24.04 LTS - GNOME 46'
    echo '3. Return To Main Menu'
    echo -n "Enter Option: "
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
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showUbuntuMenu
            ;;
    esac
 
}

# Ubuntu 22.04 Menu
showUbuntu22LTSGMenu(){
    clear
    echo "--------------------------------------"
    echo "|   Ubuntu 22.04 LTS - GNOME 42 DE   |"
    echo "--------------------------------------"
    echo "Choose The Theme That You Want To Apply : "
    echo "1. GTK Graphite"
    echo "2. My P Theme"
    echo "3. Windows 11"
    echo "4. Windows Everforest Dark"
    echo "5. Return To Previous Menu"
    echo -n "Enter Option: "
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
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showUbuntu22LTSGMenu
            ;;
    esac
}

# GTK Graphite Menu
showGGThemeMenu(){
    clear
    Path="src/Ubuntu/22.04/GNOME-42/GTK-Graphite"
    echo "--------------------------------------"
    echo "|   Ubuntu 22.04 LTS - GNOME 42 DE   |"
    echo "|------------------------------------|"
    echo "|    Selected Theme : GTK Graphite   |"
    echo "--------------------------------------"
    echo "1. Apply Theme"
    echo "2. Preview Theme"
    echo "3. Return To Previous Menu"
    echo -n "Enter Option: "
    read option
    case $option in
        1)
            bash $Path/install_GG.sh
            ;;
        2)
            nautilus $Path/Screenshots/
            showGGThemeMenu
            ;;
        3)
            showUbuntu22LTSGMenu
            ;;
        *)
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showGGThemeMenu
            ;;
    esac
    
}

# My Personal Theme Menu
showPThemeMenu(){
    clear
    Path="src/Ubuntu/22.04/GNOME-42/My-Theme"
    echo "--------------------------------------"
    echo "|   Ubuntu 22.04 LTS - GNOME 42 DE   |"
    echo "|------------------------------------|"
    echo "|    Selected Theme : My P Theme     |"
    echo "--------------------------------------"
    echo "1. Apply Theme"
    echo "2. Preview Theme"
    echo "3. Return To Previous Menu"
    echo -n "Enter Option: "
    read option
    case $option in
        1)
            bash $Path/install_MP.sh
            ;;
        2)
            nautilus $Path/Screenshots/
            showPThemeMenu
            ;;
        3)
            showUbuntu22LTSGMenu
            ;;
        *)
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showPThemeMenu
            ;;
    esac
}

# Windows 11 Theme Menu
showWinEThemeMenu(){
    clear
    Path="src/Ubuntu/22.04/GNOME-42/Windows-11"
    echo "--------------------------------------"
    echo "|   Ubuntu 22.04 LTS - GNOME 42 DE   |"
    echo "|------------------------------------|"
    echo "|     Selected Theme : Windows 11    |"
    echo "--------------------------------------"
    echo "1. Apply Theme"
    echo "2. Preview Theme"
    echo "3. Return To Previous Menu"
    echo -n "Enter Option: "
    read option
    case $option in
        1)
            bash $Path/install_Win11.sh
            ;;

        2)
            nautilus $Path/Screenshots/
            showWinEThemeMenu
            ;;
        3)
            showUbuntu22LTSGMenu
            ;;
        *)
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showWinEThemeMenu
            ;;
    esac
}

# Windows Everforest Theme Menu
showWinEDThemeMenu(){
    clear
    Path="src/Ubuntu/22.04/GNOME-42/Windows-Everforest-Dark"
    echo "------------------------------------------------"
    echo "|        Ubuntu 22.04 LTS - GNOME 42 DE        |"
    echo "|----------------------------------------------|"
    echo "|    Selected Theme : Windows Everforest Dark  |"
    echo "------------------------------------------------"
    echo "1. Apply Theme"
    echo "2. Preview Theme"
    echo "3. Return To Previous Menu"
    read option
    case $option in
        1)
            bash $Path/install_WinED.sh
            ;;
        2)
            nautilus $Path/Screenshots/
            showWinEDThemeMenu
            ;;
        3)
            showUbuntu22LTSGMenu
            ;;
        *)
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showWinEDThemeMenu
            ;;
    esac
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
    echo -n "Enter Option: "
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
            echo "No Option Selected !"
            echo "Press Enter To Continue ..."
            read
            showMainMenu
            ;;
    esac
}

# Main Script
showMainMenu