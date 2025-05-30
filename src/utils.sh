#!/usr/bin/env bash

# Define Working Directory Path : 
WORK_DIR=$(pwd)

# Define Distribution Variables : 
DISTRIBUTION=$(grep ^ID= /etc/os-release | cut -d= -f2 | tr -d '"')
DISTRIBUTION_NAME=$(grep ^PRETTY_NAME= /etc/os-release | cut -d= -f2 | tr -d '"')
UBUNTU_BASE=$(grep ^ID_LIKE= /etc/os-release | cut -d= -f2 | tr -d '"' | grep "ubuntu")
FEDORA_BASE=$(grep ^ID_LIKE= /etc/os-release | cut -d= -f2 | tr -d '"' | grep "fedora")

# Define Color Variables
# Usage : 
# echo -e "${<COLOR_TO_USE>}<MESSAGE TO PRINT>${RESET}"
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
CYAN='\e[36m'
RESET='\e[0m'

printc(){
    
    case $1 in
    	"RED")
    		color=$RED
    		;;
    	"GREEN")
    		color=$GREEN
    		;;
    	"YELLOW")
    		color=$YELLOW
    		;;
    	"CYAN")
    		color=$CYAN
    		;;
    esac

    echo -e "${color}$2${RESET}"
}

# Function that prints a message box
print_msgbox(){
    local title=$1
    local msg=$2
    whiptail --title "$title" --msgbox \
    "$msg" \ 10 80
}


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

options_menu() {
    local selected_option=$1
    local install_script=$2
    local remove_script=$3
    local previous_menu=$4
    log_message "INFO" "Displaying ${selected_option} Menu"
    local option=$(whiptail --title "$selected_option" --menu "Choose an option" 30 80 16 \
    "Install" "" \
    "Reset" "" \
    "Preview" "" \
    "<-- Back" "Return To Previous Menu" \
    3>&1 1>&2 2>&3)

    case $option in
        "Install")
            log_message "INFO" "User chose to install ${selected_option}"
            . "$install_script"
            ;;
        "Remove")
            log_message "INFO" "User chose to remove ${selected_option}"
            . "$remove_script"
            ;;
        "Preview")
            log_message "INFO" "User chose to preview ${selected_option}"
            ;;
        "<-- Back")
            log_message "INFO" "User chose to return To Previous Menu"
            "$previous_menu"
            ;;
        *)
            echo "Ending Utility Script GUI Execution at $(date)" >> "$LOG_FILE"
            echo "Exiting..."
            ;;
    esac
}

# Function that download external sources from Google Drive with Bypassing Security Check Message
# Parameters :
# $1 : File ID
# $2 : Path/to/file.extension
# Usage : downloadFile "<FILE_ID>" "<Path/to/file.extension>"
downloadFile(){
    wget -O "$2" "https://drive.usercontent.google.com/download?id=$1&export=download&confirm=yes"
}

# Function that handle errors
# Parameters :
# $1 : Log Message
# $? : argument that will be used with 'trap' command to catch the exit status
handle_error() {
    local exit_status=$?
    local msg="$1"
    log_message "ERROR" "${msg} (Exit status: ${exit_status})"
	whiptail --title "ERROR" --msgbox \
	"
    An error occurred: ${msg}
    Please check the log file for more details :
    ${LOG_FILE}
    " \ 10 80
    exit $exit_status
}

# Function that gives the User the choice to sign out from the current session right away or not
# Parameter :
# $1 : DE sign out command
# Usage : signOut "<Command to logout of current session>"
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