#!/bin/bash

echo 'Updating the Database...'
sleep 1
sudo apt update
clear

echo 'Installing required Packages...'
sleep 1
sudo apt install sassc optipng inkscape libcanberra-gtk-module libglib2.0-dev libxml2-utils git dconf-editor -y
clear

echo 'Installing Icons Theme...'
sleep 1
git clone https://github.com/vinceliuice/McMojave-circle.git
bash McMojave-circle/install.sh
clear

echo 'Installing GTK Theme...'
sleep 1
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
bash WhiteSur-gtk-theme/install.sh
clear

echo 'Installing Cursors Theme...'
sleep 1
git clone https://github.com/vinceliuice/McMojave-cursors.git
bash McMojave-cursors/install.sh
clear

echo 'Extracting and Installing Wallpapers...'
sleep 1
mkdir $HOME/Pictures/Wallpapers
unzip Wallpapers.zip -d $HOME/Pictures/Wallpapers/
clear

echo 'Installing Plank Dock and Nautilus File Manager...'
sleep 1
sudo apt install plank nautilus -y

echo 'Applying Cinnamon DE - Bigsur Edition Theme...'
sleep 1
unzip cinnamon.zip -d $HOME/.local/share/
mkdir -p $HOME/.local/share/plank/themes/
unzip plank_theme.zip -d $HOME/.local/share/plank/themes/
cp /usr/share/applications/plank.desktop $HOME/.config/autostart/
dconf load / < bigsur-configs
gsettings set org.cinnamon.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/'Appearance Dark.jpg'
clear

echo 'Log out and Log in for full theme effect...'
