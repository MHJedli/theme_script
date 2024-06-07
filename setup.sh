#!/bin/bash

# Function Definitions
showMainMenuOptions(){
    clear
    echo "Choose the theme that you want to apply : "
    echo "1. GTK Graphite"
    echo "2. My P Theme"
    echo "3. Windows 11"
    echo "4. Windows Everforest Dark"
    echo "<CTRL+C>. Quit"
    echo -n "Enter Option: "
}

chooseMainMenuOptions(){
    case $1 in
        1)
            applyGGTheme
            ;;
        2)
            applyPTheme
            ;;
        3)
            applyWinETheme
            ;;
        4)
            applyWinEDTheme
            ;;
    esac
}

applyGGTheme(){
    clear
    Path="Ubuntu-GNOME-42/GTK-Graphite"
    echo "-> GTK Graphite :"
    echo "1. Apply Theme"
    echo "2. Preview Theme"
    echo -n "Enter Option: "
    read option
    case $option in
        1)
            bash $Path/restore.sh
            ;;
        2)
            nautilus $Path/Screenshots/
            ;;
        *)
            echo "No Option Selected"
            ;;
    esac
    echo "Press Enter to Go back to Main Menu ..."
    read
}

applyPTheme(){
    clear
    Path="Ubuntu-GNOME-42/My-Theme"
    echo "-> My P Theme :"
    echo "1. Apply Theme"
    echo "2. Preview Theme"
    echo -n "Enter Option: "
    read option
    case $option in
        1)
            bash $Path/restore.sh
            ;;
        2)
            nautilus $Path/Screenshots/
            ;;
        *)
            echo "No Option Selected"
            ;;
    esac
    echo "Press Enter to Go back to Main Menu ..."
    read
}

applyWinETheme(){
    clear
    Path="Ubuntu-GNOME-42/Windows-11"
    echo "-> Windows 11 :"
    echo "1. Apply Theme"
    echo "2. Preview Theme"
    echo -n "Enter Option: "
    read option
    case $option in
        1)
            bash $Path/restore.sh
            ;;

        2)
            nautilus $Path/Screenshots/
            ;;
        *)
            echo "No Option Selected !"
            ;;
    esac
    echo "Press Enter to Go back to Main Menu ..."
    read
}

applyWinEDTheme(){
    clear
    Path="Ubuntu-GNOME-42/Windows-Everforest-Dark"
    echo "-> Windows Everforest Dark :"
    echo "1. Apply Theme"
    echo "2. Preview Theme"
    echo -n "Enter Option: "
    read option
    case $option in
        1)
            bash $Path/restore.sh
            ;;
        2)
            nautilus $Path/Screenshots/
            ;;
        *)
            echo "No Option Selected"
            ;;
    esac
    echo "Press Enter to Go back to Main Menu ..."
    read
}

# Main Script
while :
do
    showMainMenuOptions
    read option
    chooseMainMenuOptions $option 
done