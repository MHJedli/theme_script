# MY CUSTOM THEME SCRIPT FOR UBUNTU 22.04 - GNOME DE 42.9
![Screenshot from 2024-02-09 22-46-13](https://github.com/Mouadh-Jedli/theme_script/assets/53920740/d805280a-1bdf-45f0-a634-62e73a7232fe)

# NOTE
*   Instead of theme_script.sh, we have backup.sh and restore.sh so you can either restore a backed up theme<br>
    or do a full backup of your theme (Extensions, custom themes, custom icons and its configurations)

Extensions used for this theme : 

*   Activate GNOME
*   Add to Desktop
*   Blur my Shell
*   Caffeine
*   Coverflow Alt-Tab
*   Custom OSD
*   Dash to Dock
*   IdeaPad (Conservation mode for IdeaPad Laptops)
*   Just Perfection
*   Media Controls
*   Removable Drive Menu
*   Unite
*   User Themes
*   Vitals
*   Wayland or X11
*   Wifi QR Code

Custom Themes used for this theme in Tweaks app :

*   Applications : Orchis-Purple-Dark
*   Icons : Reversal-purple-dark
*   Shell : Orchis-Purple-Dark

How to restore this custom theme (Install it) : 
<pre>
  git clone https://github.com/Mouadh-Jedli/theme_script.git
  cd theme_script
  bash restore.sh or ./restore.sh
</pre>

# NOTE
The restore.sh will set "wallpaper.jpg" inside "Background" folder as default background. If you want to change it inside the script<br>
just replace the background image with another with keeping "wallpaper.jpg" as its name

With restore.sh :

*   Extensions, Tweaks and Dconf Editor apps will be installed
*   All the extensions will be installed on ~/.local/share/gnome-shell/extensions
*   All the themes and icons will be installed in ~/.themes and in ~/.icons

How to full backup your custom theme with its config :
<pre>
  git clone https://github.com/Mouadh-Jedli/theme_script.git
  cd theme_script
  bash backup.sh or ./backup.sh
</pre>

With backup.sh :

*   Dconf Editor app will be installed
*   ~/.icons will be zipped into my-icons.tar.gz
*   ~/.themes will be zipped into my-themes.tar.gz
*   ~/.local/share/gnome-shell/extensions will be zipped into my-extensions.tar.gz
*   a "full-gnome-settings" file will generated (your GNOME configs)

# SCREENSHOTS
![Screenshot from 2024-02-09 22-52-55](https://github.com/Mouadh-Jedli/theme_script/assets/53920740/abfe3d74-d3f2-4fc4-ac91-abc3453c1dc9)
![Screenshot from 2024-02-09 22-53-21](https://github.com/Mouadh-Jedli/theme_script/assets/53920740/10625ca4-21ee-4efd-aa91-3600ebaf1aaf)
![Screenshot from 2024-02-09 22-59-33](https://github.com/Mouadh-Jedli/theme_script/assets/53920740/42f8e05b-e3b8-4d0c-b2c5-2fc90be87f20)
![Screenshot from 2024-02-09 22-55-01](https://github.com/Mouadh-Jedli/theme_script/assets/53920740/6c6a8829-5736-4345-b910-0706d3080bcd)
![Screenshot from 2024-02-09 22-55-52](https://github.com/Mouadh-Jedli/theme_script/assets/53920740/7eb7c171-f5ad-4b4c-9ec5-f44aed38dfa2)

