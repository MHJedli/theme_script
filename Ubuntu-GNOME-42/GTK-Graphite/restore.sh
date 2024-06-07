#!/bin/bash

path=$(pwd)/Ubuntu-GNOME-42/GTK-Graphite


echo "Updating database..."
sleep 1
sudo apt update
clear

echo "Installing Dconf Editor , GNOME Tweaks and GNOME Extensions..."
sleep 1
sudo apt install dconf-editor gnome-tweaks gnome-shell-extensions
clear

echo "Installing Conky..."
sleep 1
sudo apt install jq curl conky
clear

echo "Installing Themes and Icons..."
sleep 1
tar --extract --file $path/my-icons.tar.gz -C ~/ --strip-components=2
tar --extract --file $path/my-themes.tar.gz -C ~/ --strip-components=2
clear

echo "Installing The Extensions..."
sleep 1
tar --extract --file $path/my-extensions.tar.gz -C ~/ --strip-components=2
clear

echo "Setting Up The Fonts and Conky..."
sleep 1
cp -r $path.fonts ~/
cp -r $path.harmattan-assets ~/
cp -r $path.harmattan-themes ~/
mkdir ~/.config/autostart
cp $path/conky_startup/* ~/.config/autostart/
clear

echo "Applying The Custom DE Settings..."
sleep 1
dconf load / < $path/full-gnome-settings
clear

echo "Extracting Wallpapers in ~/Pictures and Applying Background..."
sleep 1
cp -r $path/Wallpapers ~/Pictures
gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/wave-Dark-nord-ubuntu.png
clear

echo -n "You want to Log Out Now To Fully Apply The Theme ? (Y/n) : "
read r
if [[ "$r" == "Y" || "$r" == "y" ]]; then
    echo "Logging out in 3 seconds ..."
    sleep 3
    gnome-session-quit --no-prompt
fi