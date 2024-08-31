#!/bin/bash

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
if [ ! -d ~/.themes ]; then
  mkdir ~/.themes
fi
unzip Windows-7-theme.zip -d ~/.themes

clear
echo 'Extracting and Installing Icons...'
sleep 1
if [ ! -d ~/.icons ]; then
  mkdir ~/.icons
fi
unzip Windows-7-icons.zip -d ~/.icons

clear
echo "Extracting And Installing Wallpaper to $HOME/Pictures"
sleep 1
if [ ! -d ~/Pictures/Wallpapers ]; then
  mkdir ~/Pictures/Wallpapers
fi
unzip Windows-7-wallpaper.zip -d $HOME/Pictures/Wallpapers

echo 'Applying Windows 7 Theme'
unzip cinnamon.zip -d $HOME/.local/share/
dconf load / < windows-7-config
gsettings set org.cinnamon.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/windows-7-wallpaper.jpg
clear

echo 'ALL DONE !'
