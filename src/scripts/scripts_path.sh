#!/usr/bin/env bash

SCRIPT_DIR=$(pwd)

# Used Associative Arrays to declare Theme Paths for easier use
declare -A THEME_PATHS=(
    # GNOME Themes
    ["GTK-Graphite-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/GTK-Graphite/install_GG.sh"
    ["GTK-Graphite-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/GTK-Graphite/reset_to_defaults.sh"
    ["GTK-Graphite-46-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/GTK-Graphite/install_GG.sh"
    ["GTK-Graphite-46-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/GTK-Graphite/reset_to_defaults.sh"

    ["My-Theme-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/My-Theme/install_MP.sh"
    ["My-Theme-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/My-Theme/reset_to_defaults.sh"
    ["My-Theme-46-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/My-Theme/install_MP.sh"
    ["My-Theme-46-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/My-Theme/reset_to_defaults.sh"

    ["Win-11-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/Windows-11/install_Win11.sh"
    ["Win-11-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/Windows-11/reset_to_defaults.sh"
    ["Win-11-46-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/Windows-11/install_Win11.sh"
    ["Win-11-46-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/Windows-11/reset_to_defaults.sh"

    ["Win-Everforest-Dark-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/Windows-Everforest-Dark/install_WinED.sh"
    ["Win-Everforest-Dark-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/Windows-Everforest-Dark/reset_to_defaults.sh"
    ["Win-Everforest-Dark-46-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/Windows-Everforest-Dark/install_WinED.sh"
    ["Win-Everforest-Dark-46-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/Windows-Everforest-Dark/reset_to_defaults.sh"

    ["MacOS-V1-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/MacOS-V1/install_MacV1.sh"
    ["MacOS-V1-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/22.04/MacOS-V1/reset_to_defaults.sh"
    ["MacOS-V1-46-installer"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/MacOS-V1/install_MacV1.sh"
    ["MacOS-V1-46-remover"]="${SCRIPT_DIR}/src/scripts/GNOME/24.04/MacOS-V1/reset_to_defaults.sh"

    # Cinnamon Themes
    ["Win7-installer"]="${SCRIPT_DIR}/src/scripts/Cinnamon/Windows-7/install_windows7.sh"
    ["Win7-remover"]="${SCRIPT_DIR}/src/scripts/Cinnamon/Windows-7/reset_to_defaults.sh"

    ["Ventura-installer"]="${SCRIPT_DIR}/src/scripts/Cinnamon/Cinnamon-Ventura/install_ventura.sh"
    ["Ventura-remover"]="${SCRIPT_DIR}/src/scripts/Cinnamon/Cinnamon-Ventura/reset_to_defaults.sh"
)