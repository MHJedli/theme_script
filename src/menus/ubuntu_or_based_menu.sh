#!/usr/bin/env bash

# External Functions/Files
DIRECTORY_PATH=$(pwd)
UTILS="${DIRECTORY_PATH}/src/utils.sh"
SCRIPTS_PATH="${DIRECTORY_PATH}/src/scripts/scripts_path.sh"

source "$UTILS"
source "$SCRIPTS_PATH"

show_ubuntu_or_based_menu(){
    log_message "INFO" "Displaying Ubuntu or Ubuntu-based Menu"
    local option=$(whiptail --title "Ubuntu or Ubuntu-based" --menu "Choose your Desktop ENvironment" 30 80 16 \
    "GNOME" "" \
    "Cinnamon" "" \
    "<-- Back" "" \
    3>&1 1>&2 2>&3)

    case $option in
        "GNOME")
            log_message "INFO" "User chose GNOME Menu"
            show_gnome_menu
            ;;
        "Cinnamon")
            log_message "INFO" "User chose Cinnamon Menu"
            show_cinnamon_menu
            ;;
        "<-- Back")
            log_message "INFO" "User chose to go back"
            show_main_menu
            ;;
        *)
            echo "Ending Theme Script GUI Execution at $(date)" >> "$LOG_FILE"
            echo "Exiting Theme Script..."
            exit 0
            ;;
    esac
}

show_gnome_menu(){
    log_message "INFO" "Displaying GNOME Theme Menu"
    local option=$(whiptail --title "GNOME Theme Menu" --menu "Choose your GNOME Theme" 30 80 16 \
    "GTK-Graphite" "" \
    "MacOS-V1" "" \
    "My-Theme" "" \
    "Win-11" "" \
    "Win-Everforest-Dark" "" \
    "<-- Back" "" \
    3>&1 1>&2 2>&3)

    case $option in
        "GTK-Graphite")
            log_message "INFO" "User chose GTK Graphite Theme"
            show_gnome_version "$option"
            ;;
        "MacOS-V1")
            log_message "INFO" "User chose MacOS V1 Theme"
            show_gnome_version "$option"
            ;;
        "My-Theme")
            log_message "INFO" "User chose My Theme"
            show_gnome_version "$option"
            ;;
        "Win-11")
            log_message "INFO" "User chose Windows 11 Theme"
            show_gnome_version "$option"
            ;;
        "Win-Everforest-Dark")
            log_message "INFO" "User chose Windows Everforest Dark Theme"
            show_gnome_version "$option"
            ;;
        "<-- Back")
            log_message "INFO" "User chose to go back"
            show_ubuntu_or_based_menu
            ;;
        *)
            echo "Ending Theme Script GUI Execution at $(date)" >> "$LOG_FILE"
            echo "Exiting Theme Script..."
            exit 0
            ;;
    esac
}

show_gnome_version(){
    local selected_theme="$1"
    log_message "INFO" "Displaying GNOME Version Menu for $selected_theme"
    local option=$(whiptail --title "Apply Theme: $selected_theme" --menu "Choose your GNOME Version:" 30 80 16 \
    "GNOME 42" "(Ubuntu 22.04)" \
    "GNOME 46" "(Ubuntu 24.04)" \
    "<-- Back" "" \
    3>&1 1>&2 2>&3)
    case $option in
        "GNOME 42")
            log_message "INFO" "User chose GNOME 42 for $selected_theme"
            options_menu "$selected_theme" \
                         "${THEME_PATHS["$selected_theme"-installer]}" \
                         "${THEME_PATHS["$selected_theme"-remover]}" \
                         "show_gnome_version"
            ;;
        "GNOME 46")
            log_message "INFO" "User chose GNOME 46 for $selected_theme"
            options_menu "$selected_theme" \
                         "${THEME_PATHS["$selected_theme"-46-installer]}" \
                         "${THEME_PATHS["$selected_theme"-46-remover]}" \
                         "show_gnome_version"
            ;;
        "<-- Back")
            log_message "INFO" "User chose to go back"
            show_gnome_menu
            ;;
        *)
            echo "Ending Theme Script GUI Execution at $(date)" >> "$LOG_FILE"
            echo "Exiting Theme Script..."
            exit 0
            ;;
    esac
}

show_cinnamon_menu(){
    log_message "INFO" "Displaying Cinnamon Theme Menu"
    local option=$(whiptail --title "Cinnamon Theme Menu" --menu "Choose your Cinnamon Theme" 30 80 16 \
    "Ventura" "" \
    "Win7" "" \
    "<-- Back" "" \
    3>&1 1>&2 2>&3)

    case $option in
        "Ventura")
            log_message "INFO" "User chose Cinnamon for $option"
            options_menu "$option" \
                         "${THEME_PATHS["$option"-installer]}" \
                         "${THEME_PATHS["$option"-remover]}" \
                         "show_cinnamon_menu"
            ;;
        "Win7")
            log_message "INFO" "User chose Cinnamon for $option"
            options_menu "$option" \
                         "${THEME_PATHS["$option"-installer]}" \
                         "${THEME_PATHS["$option"-remover]}" \
                         "show_cinnamon_menu"
            ;;
        "<-- Back")
            log_message "INFO" "User chose to go back"
            show_ubuntu_or_based_menu
            ;;
        *)
            echo "Ending Theme Script GUI Execution at $(date)" >> "$LOG_FILE"
            echo "Exiting Theme Script..."
            exit 0
            ;;
    esac
}

# Begin ubuntu or based menu
show_ubuntu_or_based_menu
# End ubuntu or based menu