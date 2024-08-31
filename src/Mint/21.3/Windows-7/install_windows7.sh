#!/bin/bash

path=$(pwd)/src/Mint/21.3/Windows-7
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log

clear
echo 'Updating Database...'
sleep 1
sudo apt update

clear
echo 'Installing Dconf Editor...'
sudo apt install dconf-editor

clear
echo 'Extracting and Installing Theme...'
sleep 1
if [ ! -d $HOME/.themes ]; then
  mkdir $HOME/.themes
fi
unzip $path/Windows-7-theme.zip -d $HOME/.themes

clear
echo 'Extracting and Installing Icons...'
sleep 1
if [ ! -d $HOME/.icons ]; then
  mkdir $HOME/.icons
fi
unzip $path/Windows-7-icons.zip -d $HOME/.icons

clear
echo "Extracting And Installing Wallpaper to $HOME/Pictures"
sleep 1
if [ ! -d $HOME/Pictures/Wallpapers ]; then
  mkdir $HOME/Pictures/Wallpapers
fi
unzip $path/Windows-7-wallpaper.zip -d $HOME/Pictures/Wallpapers

echo 'Applying Windows 7 Theme'
unzip $path/cinnamon.zip -d $HOME/.local/share/
dconf load / < $path/windows-7-config
gsettings set org.cinnamon.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/windows-7-wallpaper.jpg
clear

signOut "cinnamon-session-quit --logout --force"