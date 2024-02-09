#! /bin/bash
echo "This script is used to install extensions and themes for GNOME 42 !"
sleep 2

echo "Installing GNOME extensions and Tweaks"
#sudo apt install gnome-shell-extensions -y
#sudo apt install gnome-tweaks -y

# Preparing Variables
extensions_path=~/.local/share/gnome-shell/extensions

# UUID extractor 
function extract_uuid(){
echo $1 | grep -o '"uuid": "[^"]*' | grep -o '[^"]*$'
}

echo "Downloading the extensions : \n"

echo "Downloading GSConnect :"
sleep 1
wget -O GSConnect.zip https://extensions.gnome.org/extension-data/gsconnectandyholmes.github.io.v50.shell-extension.zip
clear

echo "Downloading Activate GNOME :"
sleep 1
wget -O Activate_GNOME.zip https://extensions.gnome.org/extension-data/activate_gnomeisjerryxiao.v9.shell-extension.zip
clear

echo "Downloading Add to Desktop : "
sleep 1
wget -O add_to_desktop.zip https://extensions.gnome.org/extension-data/add-to-desktoptommimon.github.com.v10.shell-extension.zip
clear

echo "Downloading Blur My Shell : "
sleep 1
wget -O blur_my_shell.zip https://extensions.gnome.org/extension-data/blur-my-shellaunetx.v47.shell-extension.zip
clear

echo "Downloading Caffeine : "
sleep 1
wget -O caffeine.zip https://extensions.gnome.org/extension-data/caffeinepatapon.info.v42.shell-extension.zip
clear

echo "Downloading CoverFlow-Alt-Tab : "
sleep 1
wget -O coverflow.zip https://extensions.gnome.org/extension-data/CoverflowAltTabpalatis.blogspot.com.v55.shell-extension.zip
clear

echo "Downloading Custom OSD : "
sleep 1
wget -O custom_osd.zip https://extensions.gnome.org/extension-data/custom-osdneuromorph.v24.shell-extension.zip
clear

echo "Downloading Dash to Dock : "
sleep 1
wget -O dash_to_dock.zip https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v84.shell-extension.zip
clear

echo "Downloading Disk Usage : "
sleep 1
wget -O disk_usage.zip https://extensions.gnome.org/extension-data/disk-usage0ct0puce.com.v14.shell-extension.zip
clear

echo "Downloading IdeaPad : "
sleep 1
wget -O ideapad.zip https://extensions.gnome.org/extension-data/ideapadlaurento.frittella.v11.shell-extension.zip
clear

echo "Downloading Just Perfection : "
sleep 1
wget -O just_perfection.zip https://extensions.gnome.org/extension-data/just-perfection-desktopjust-perfection.v26.shell-extension.zip
clear

echo "Downloading Media Control : "
sleep 1
wget -O media_controls.zip https://extensions.gnome.org/extension-data/mediacontrolscliffniff.github.com.v24.shell-extension.zip
clear

echo "Downloading Removable Drive Menu : "
sleep 1
wget -O removable_drive.zip https://extensions.gnome.org/extension-data/drive-menugnome-shell-extensions.gcampax.github.com.v51.shell-extension.zip
clear

echo "Downloading Unite : "
sleep 1
wget -O unite.zip https://extensions.gnome.org/extension-data/unitehardpixel.eu.v72.shell-extension.zip
clear

echo "Downloading User Themes : "
sleep 1
wget -O user_themes.zip https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v49.shell-extension.zip
clear

echo "Downloading Wayland or X11 ? : "
sleep 1
wget -O wayland_or_x11.zip https://extensions.gnome.org/extension-data/waylandorx11injcristianrojas.github.com.v11.shell-extension.zip
clear

echo "Downloading WiFi QR scan : "
sleep 1
wget -O wifi_qr.zip https://extensions.gnome.org/extension-data/wifiqrcodeglerro.pm.me.v10.shell-extension.zip
clear

echo "Extracting the extensions"
unzip GSConnect.zip -d $extensions_path/GSConnect
unzip Activate_GNOME.zip -d $extensions_path/Activate_GNOME
unzip add_to_desktop.zip -d $extensions_path/add_to_desktop
unzip blur_my_shell.zip -d $extensions_path/blur_my_shell
unzip caffeine.zip -d $extensions_path/caffeine
unzip coverflow.zip -d $extensions_path/coverflow
unzip custom_osd.zip -d $extensions_path/custom_osd
unzip dash_to_dock.zip -d $extensions_path/dash_to_dock
unzip disk_usage.zip -d $extensions_path/disk_usage
unzip ideapad.zip -d $extensions_path/ideapad
unzip just_perfection.zip -d $extensions_path/just_perfection
unzip media_controls.zip -d $extensions_path/media_controls
unzip removable_drive.zip -d $extensions_path/removable_drive
unzip unite.zip -d $extensions_path/unite
unzip user_themes.zip -d $extensions_path/user_themes
unzip wayland_or_x11.zip -d $extensions_path/wayland_or_x11
unzip wifi_qr.zip -d $extensions_path/wifi_qr

echo "Renaming the extensions by their UUID and moving them to the extensions folder : "
GSConnect_json="$(cat $extensions_path/GSConnect/metadata.json)"
GSConnect_uuid="$(extract_uuid "$GSConnect_json")"
mv $extensions_path/GSConnect $extensions_path/$GSConnect_uuid

Activate_GNOME_json="$(cat $extensions_path/Activate_GNOME/metadata.json)"
Activate_GNOME_uuid="$(extract_uuid "$Activate_GNOME_json")"
mv $extensions_path/Activate_GNOME $extensions_path/$Activate_GNOME_uuid

add_to_desktop_json="$(cat $extensions_path/add_to_desktop/metadata.json)"
add_to_desktop_uuid="$(extract_uuid "$add_to_desktop_json")"
mv $extensions_path/add_to_desktop $extensions_path/$add_to_desktop_uuid

blur_my_shell_json="$(cat $extensions_path/blur_my_shell/metadata.json)"
blur_my_shell_uuid="$(extract_uuid "$blur_my_shell_json")"
mv $extensions_path/blur_my_shell $extensions_path/$blur_my_shell_uuid

caffeine_json="$(cat $extensions_path/caffeine/metadata.json)"
caffeine_uuid="$(extract_uuid "$caffeine_json")"
mv $extensions_path/caffeine $extensions_path/$caffeine_uuid

coverflow_json="$(cat $extensions_path/coverflow/metadata.json)"
coverflow_uuid="$(extract_uuid "$coverflow_json")"
mv $extensions_path/coverflow $extensions_path/$coverflow_uuid

custom_osd_json="$(cat $extensions_path/custom_osd/metadata.json)"
custom_osd_uuid="$(extract_uuid "$custom_osd_json")"
mv $extensions_path/custom_osd $extensions_path/$custom_osd_uuid

dash_to_dock_json="$(cat $extensions_path/dash_to_dock/metadata.json)"
dash_to_dock_uuid="$(extract_uuid "$dash_to_dock_json")"
mv $extensions_path/dash_to_dock $extensions_path/$dash_to_dock_uuid

disk_usage_json="$(cat $extensions_path/disk_usage/metadata.json)"
disk_usage_uuid="$(extract_uuid "$disk_usage_json")"
mv $extensions_path/disk_usage $extensions_path/$disk_usage_uuid

ideapad_json="$(cat $extensions_path/ideapad/metadata.json)"
ideapad_uuid="$(extract_uuid "$ideapad_json")"
mv $extensions_path/ideapad $extensions_path/$ideapad_uuid

just_perfection_json="$(cat $extensions_path/just_perfection/metadata.json)"
just_perfection_uuid="$(extract_uuid "$just_perfection_json")"
mv $extensions_path/just_perfection $extensions_path/$just_perfection_uuid

media_controls_json="$(cat $extensions_path/media_controls/metadata.json)"
media_controls_uuid="$(extract_uuid "$media_controls_json")"
mv $extensions_path/media_controls $extensions_path/$media_controls_uuid

removable_drive_json="$(cat $extensions_path/removable_drive/metadata.json)"
removable_drive_uuid="$(extract_uuid "$removable_drive_json")"
mv $extensions_path/removable_drive $extensions_path/$removable_drive_uuid

unite_json="$(cat $extensions_path/unite/metadata.json)"
unite_uuid="$(extract_uuid "$unite_json")"
mv $extensions_path/unite $extensions_path/$unite_uuid

user_themes_json="$(cat $extensions_path/user_themes/metadata.json)"
user_themes_uuid="$(extract_uuid "$user_themes_json")"
mv $extensions_path/user_themes $extensions_path/$user_themes_uuid

wayland_or_x11_json="$(cat $extensions_path/wayland_or_x11/metadata.json)"
wayland_or_x11_uuid="$(extract_uuid "$wayland_or_x11_json")"
mv $extensions_path/wayland_or_x11 $extensions_path/$wayland_or_x11_uuid

wifi_qr_json="$(cat $extensions_path/wifi_qr/metadata.json)"
wifi_qr_uuid="$(extract_uuid "$wifi_qr_json")"
mv $extensions_path/wifi_qr $extensions_path/$wifi_qr_uuid

