#!/bin/bash

# Ubuntu 22.04 Menu
showUbuntu22LTSGMenu(){
    clear
    echo "--------------------------------------"
    echo "|   Ubuntu 22.04 LTS - GNOME 42 DE   |"
    echo "--------------------------------------"
    echo "Choose the theme that you want to apply : "
    echo "1. GTK Graphite"
    echo "2. My P Theme"
    echo "3. Windows 11"
    echo "4. Windows Everforest Dark"
    echo "5. Return to Previous Menu"
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
    esac
}

# Ubuntu 24.04
showUbuntu24LTSGMenu(){
    clear
    echo 'Themes will be available soon for Ubuntu 24.04...'
    sleep 2
    showUbuntuMenu
}

# Ubuntu Menu
showUbuntuMenu(){
    clear
    echo "--------------------------------------"
    echo "|                Ubuntu              |"
    echo "--------------------------------------"
    echo '1. Ubuntu 22.04 LTS - GNOME 42'
    echo '2. Ubuntu 24.04 LTS - GNOME 46'
    echo '3. Return to Main Menu'
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
    esac
 
}

# Linux Mint 21.3 Cinnamon Menu
showMint213CMenu(){
    clear
    echo "--------------------------------------"
    echo "|    Linux Mint 21.3 - Cinnamon DE    |"
    echo "--------------------------------------"
    echo "Choose the theme that you want to apply : "
    echo '1. MacOS BigSur'
    echo '2. Return to Main Menu'
    echo -n "Enter Option :"
    read option
    case $option in
    1)
        showBigSurMenu
        ;;
    2)
        showMainMenu
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
    esac
}

# Linux Mint Menu
showMintMenu(){
    clear
    echo "--------------------------------------"
    echo "|             Linux Mint             |"
    echo "--------------------------------------"
    echo '1. 21.3 - Cinnamon Edition'
    echo '2. Return to Main Menu'
    echo -n 'Enter Option: '
    read option

    case $option in
        1)
            showMint213CMenu
            ;;
        2)
            showMainMenu
            ;;
    esac
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
    echo "<CTRL+C>. Quit"
    echo -n "Enter Option: "
    read option

    case $option in
        1)
            showUbuntuMenu
            ;;
        2)
            showMintMenu
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
            bash $Path/restore.sh
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
            bash $Path/restore.sh
            ;;
        2)
            nautilus $Path/Screenshots/
            ;;
        3)
            showUbuntu22LTSGMenu
            ;;
        *)
            echo "No Option Selected !"
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
            bash $Path/restore.sh
            ;;

        2)
            nautilus $Path/Screenshots/
            ;;
        3)
            showUbuntu22LTSGMenu
            ;;
        *)
            echo "No Option Selected !"
            echo "Press Enter to Continue ..."
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
    echo -n "Enter Option: "
    read option
    case $option in
        1)
            bash $Path/restore.sh
            ;;
        2)
            nautilus $Path/Screenshots/
            ;;
        3)
            showUbuntu22LTSGMenu
            ;;
        *)
            echo "No Option Selected !"
            read
            showWinEThemeMenu
            ;;
    esac
}

# Main Script
showMainMenu