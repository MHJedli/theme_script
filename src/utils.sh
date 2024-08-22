#!/bin/bash

# Theme Paths
declare -A themePaths=(
    ["BigSur"]="src/Mint/21.3/Cinnamon-BigSur"
    ["GTKGraphite"]="src/Ubuntu/22.04/GNOME-42/GTK-Graphite"
    ["PTheme"]="src/Ubuntu/22.04/GNOME-42/My-Theme"
    ["Win11"]="src/Ubuntu/22.04/GNOME-42/Windows-11"
    ["WinEverforestDark"]="src/Ubuntu/22.04/GNOME-42/Windows-Everforest-Dark"
)

# invalidOption print Function
invalidOption() {
    echo "No Option Selected !"
    echo "Press Enter To Continue ..."
    read
    "$1"
}

showMenu() {
    local title="$1"
    shift
    clear
    echo "--------------------------------------"
    echo "| $title |"
    echo "--------------------------------------"
    local index=1
    for option in "$@"; do
        echo "$index. $option"
        ((index++))
    done
    echo -n "Enter Option: "
}

themeMenu() {
    local theme=$1
    local installScript=$2
    local screenshotsDir=$3
    local fileManager=$4
    local previousMenu=$5
    while true; do
        clear
        echo "-------------------------------------------------"
        echo "| $theme   |"
        echo "-------------------------------------------------"
        echo "1. Apply Theme"
        echo "2. Preview Theme"
        echo "3. Return To Previous Menu"
        echo -n "Enter Option: "
        read option
        case $option in
            1) 
                bash "$installScript" 
                ;;
            2)
                $fileManager "$screenshotsDir" 
                ;;
            3) 
                "$previousMenu"
                return 
                ;;
            *) 
                invalidOption 
                themeMenu "$theme" "$installScript" "$screenshotsDir" "$fileManager" "$previousMenu"
                ;;
        esac
    done
}