#!/bin/bash

path=$(pwd)/src/Ubuntu/22.04/GNOME-42/Windows-11
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log

echo "Updating the database..."
sleep 1
sudo apt update
clear

echo "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
sleep 1
sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions
clear

echo "Installing Themes and Icons..."
sleep 1
tar --extract --file $path/my-icons.tar.gz -C ~/ --strip-components=2
tar --extract --file $path/my-themes.tar.gz -C ~/ --strip-components=2
tar --extract --file $path/my-fonts.tar.gz -C ~/ --strip-components=2
clear

echo "Installing The Extensions..."
sleep 1
tar --extract --file $path/my-extensions.tar.gz -C ~/ --strip-components=2
clear

echo "Applying The Custom DE Settings..."
sleep 1
dconf load / < $path/full-gnome-settings
clear

echo "Extracting Wallpapers in ~/Pictures and Applying Background..."
sleep 1
mkdir ~/Pictures/Wallpapers
cp -r $path/Background/* ~/Pictures/Wallpapers
gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/windows-11-blue-stock-white-background-light-official-3840x2400-5616.jpg
clear

signOut "gnome-session-quit --no-prompt"