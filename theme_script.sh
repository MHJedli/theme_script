#!/usr/bin/env bash

# External Functions/Files
source src/utils.sh
DIRECTORY_PATH=$(pwd)
UBUNTU_OR_BASED_MENU="${DIRECTORY_PATH}/src/menus/ubuntu_or_based_menu.sh"
UTILS="${DIRECTORY_PATH}/src/utils.sh"
SCRIPTS_PATH="${DIRECTORY_PATH}/src/scripts/scripts_path.sh"

# LOG File
LOG_FILE=src/logfile.log

# Initialize log file
echo "Starting script execution at $(date)" > "$LOG_FILE"

# Main Menu
show_main_menu(){
    log_message "INFO" "Displaying Main Menu"
    local option=$(whiptail --title "Linux Theme Script" --menu "Choose an option\n(Currently using : ${DISTRIBUTION_NAME})" 30 80 16 \
    "Ubuntu or Ubuntu-based" "Install Themes for your Distribution" \
    "Quit" "Exit Linux Theme Script" \
    3>&1 1>&2 2>&3)

    case $option in
        "Ubuntu or Ubuntu-based")
            log_message "INFO" "User chose the Ubuntu or Ubuntu-based Menu"
            source "$UBUNTU_OR_BASED_MENU"
            ;;
        "Quit")
            echo "Ending Theme Script GUI Execution at $(date)" >> "$LOG_FILE"
            echo "Exiting Theme Script..."
            exit 0
            ;;
        *)
            echo "Ending Theme Script GUI Execution at $(date)" >> "$LOG_FILE"
            echo "Exiting Theme Script..."
            exit 0
            ;;
    esac
}

check_integrity(){

    log_message "INFO" "Checking integrity of the script in auto mode"

    log_message "INFO" "1. Checking for Menus and Utils Definitions"
    local menus=("$UBUNTU_OR_BASED_MENU" )
    for menu in "${menus[@]}"; do
        if [[ ! -f "$menu" ]]; then
            log_message "ERROR" "Menu file not found: $menu"
            echo "Menu file not found: $menu"
            exit 1
        fi
    done

    log_message "INFO" "2. Checking for Utils Definition"
    if [[ -f "$UTILS" ]]; then
        log_message "INFO" "Utils file found: $UTILS"
    else
        log_message "ERROR" "Utils file not found: $UTILS"
        echo "Utils file not found: $UTILS"
        exit 1
    fi

    log_message "INFO" "3. Checking for Script Definitions"
    if [[ -f "$SCRIPTS_PATH" ]]; then
        log_message "INFO" "Script Paths file found: $SCRIPTS_PATH"
        
    else
        log_message "ERROR" "Script Paths file not found: $SCRIPTS_PATH"
        echo "Script Paths file not found: $SCRIPTS_PATH"
        exit 1
    fi

    log_message "INFO" "4. Checking for Script Files"
    for script in "${!scriptPaths[@]}"; do
        if [[ -f "${scriptPaths[$script]}" ]]; then
            log_message "INFO" "Script file found: ${scriptPaths[$script]}"
        else
            log_message "ERROR" "Script file not found: ${scriptPaths[$script]}"
            echo "Script file not found: ${scriptPaths[$script]}"
            exit 1
        fi
    done
    
}



# Begin Theme Script
if check_integrity; then
    source "$UTILS"
    source "$SCRIPTS_PATH"
    show_main_menu
fi

# End Theme Script