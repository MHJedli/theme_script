#!/bin/bash


# Function that log every step taken for easier debugging
# Parameters :
# $1 : Log Level [INFO, WARN, ERROR]
# $@ : Log Message
# Exemple :
# log_message "INFO" "Script execution started"
# log_message "ERROR" "An error occurred in the script"
log_message() {
    local LOG_LEVEL="$1"
    shift
    local MESSAGE="$@"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$LOG_LEVEL] $MESSAGE" >> "$LOG_FILE"
}


# Function that handle errors
# Parameters :
# $1 : Log Message
# $? : argument that will be used with 'trap' command to catch the exit status
handle_error() {
    local exit_status=$?
    local msg="$1"
    log_message "ERROR" "$msg (Exit status: $exit_status)"
    echo "An error occurred: $msg"
    echo "Please check the log file at $LOG_FILE for more details."
    exit $exit_status
}

# Used Associative Arrays to declare Theme Paths for easier use
declare -A themePaths=(
    ["BigSur"]="src/Mint/21.3/Cinnamon-BigSur"
    ["Win7"]="src/Mint/21.3/Windows-7"
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
    if [ $# -gt 0 ]; then
    "$1"
    fi
}

# Function that prints the Menu of different versions of a selected distro
# Parameters : 
# $1 : Menu Title
# $@ : Menu Options
# Example : 
# showMenu "Title" "Option 1" "Option 2" ...
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
# Parameters :
# $1 : Title
# $2 : Script.sh
# $3 : Screenshot Directory
# $4 : File Manager
# $5 : Previous Menu to the Current one
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
                log_message "INFO" "User chose to Apply the $trimmedTheme" 
                bash "$installScript" 
                ;;
            2)
                log_message "INFO" "User chose to Preview the $trimmedTheme"
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

# Function that gives the User the choice to sign out from the current session right away or not
# Parameter :
# $1 : DE sign out command
signOut(){
    local signOutCommand=$1
    while true; do
        echo -n "Do you want to log out now to fully apply the theme? (Y/n): "
        read -r r
        if [[ "$r" == "Y" || "$r" == "y" || "$r" == "" ]]; then
            echo "Logging out in 3 seconds..."
            sleep 3
            $signOutCommand
        elif [[ "$r" == "n" || "$r" == "N" ]]; then
            echo "Please log out manually to apply the changes."
            return
        else
            invalidOption
        fi
    done
}

# Function to check internet connectivity
check_internet() {
    ping -c 1 -q google.com >&/dev/null
    return $?
}