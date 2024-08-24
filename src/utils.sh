#!/bin/bash

# LOG File
LOG_FILE=src/logfile.log

# Initialize log file
echo "Starting script execution at $(date)" > "$LOG_FILE"

# Function that log every step taken in a log file
# Exemple of Usage :
# log_message "INFO" "Script execution started"
# log_message "ERROR" "An error occurred in the script"
log_message() {
    local LOG_LEVEL="$1"
    shift
    local MESSAGE="$@"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$LOG_LEVEL] $MESSAGE" >> "$LOG_FILE"
}

# Used Associative Arrays to declare Theme Paths for easier use
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

# Function that prints the Menu of different versions of a selected distro
# Usage :
# showMenu "<Title>" "<Option_1>" "<Option_2>" "<Option_3>" ...
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


# Function that prints the menu of a selected theme
# Usage :
# themeMenu "Selected Theme : <Theme Name>" "${themePaths["<Theme_Key>"]}/<Theme_Script>.sh" "${themePaths["<Theme_Key>"]}/Screenshots/" "<File_Manager>" "<Current_Menu_Name>"
themeMenu() {
    local theme=$1
    local trimmedTheme=$(echo "$theme" | awk '{$1=$1};1')
    local installScript=$2
    local screenshotsDir=$3
    local fileManager=$4
    local previousMenu=$5
    while true; do
        log_message "INFO" "Displaying the $(echo "$trimmedTheme" | awk '{$1=$1};1') Menu"
        clear
        echo "-------------------------------------------------"
        echo "| $theme   |"
        echo "-------------------------------------------------"
        echo "1. Apply Theme"
        echo "2. Preview Theme"
        echo "3. Return To Previous Menu"
        echo -n "Enter Option: "
        read option
        log_message "INFO" "User selected option $option in the $trimmedTheme"
        case $option in
            1)
                log_message "INFO" "User chose to Apply the Theme" 
                bash "$installScript" 
                ;;
            2)
                log_message "INFO" "User chose to Preview the Theme"
                $fileManager "$screenshotsDir" 
                ;;
            3)
                log_message "INFO" "User chose to return to Previous Menu"
                "$previousMenu"
                return 
                ;;
            *)
                log_message "WARN" "User chose an invalid option : $option"
                invalidOption 
                themeMenu "$theme" "$installScript" "$screenshotsDir" "$fileManager" "$previousMenu"
                ;;
        esac
    done
}

signOut(){
    local signOutCommand=$1
    echo -n "Do you want to log out now to fully apply the theme? (Y/n): "
    read -r r
    if [[ "$r" == "Y" || "$r" == "y" || "$r" == "" ]]; then
        echo "Logging out in 3 seconds..."
        sleep 3
        "$signOutCommand"
        cinnamon-session-quit --logout --force
    else
        echo "Please log out manually to apply the changes."
    fi
}