#!/bin/bash

path=$(pwd)/src/Mint/21.3/Cinnamon-BigSur
source $(pwd)/src/utils.sh
LOG_FILE=$(pwd)/src/logfile.log
clear


echo "Continue script execution at $(date)" >> "$LOG_FILE"


# log_message "INFO" "Updating the DB.....oyoyoyoyoyoy"
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
unzip $path/Wallpapers.zip -d $HOME/Pictures/Wallpapers/
clear

echo 'Installing Plank Dock and Nautilus File Manager...'
sleep 1
sudo apt install plank nautilus -y

echo 'Applying Cinnamon DE - Bigsur Edition Theme...'
sleep 1
unzip $path/cinnamon.zip -d $HOME/.local/share/
mkdir -p $HOME/.local/share/plank/themes/
unzip $path/plank_theme.zip -d $HOME/.local/share/plank/themes/
cp /usr/share/applications/plank.desktop $HOME/.config/autostart/
dconf load / < $path/bigsur-configs
gsettings set org.cinnamon.desktop.background picture-uri file://$HOME/Pictures/Wallpapers/Appearance.jpg
clear

signOut "cinnamon-session-quit --logout --force"