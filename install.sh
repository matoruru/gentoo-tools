#!/bin/bash

IS_INSTALLED=true

sudo emerge -avD                \
   app-laptop/laptop-mode-tools \
   app-office/libreoffice       \
   sys-power/upower             \
   sys-power/acpitool           \
   dev-lang/ruby                \
   dev-lang/lua                 \
   dev-lang/luajit              \
   dev-lang/perl                \
   dev-java/groovy              \
   dev-vcs/git                  \
   app-shells/fish              \
   app-misc/sl                  \
   app-misc/oneko               \
   app-text/qpdfview            \
   www-client/google-chrome     \
   media-gfx/feh                \
   media-sound/alsa-utils       \
   media-sound/moc              \
   net-misc/ntp                 \
   net-misc/youtube-viewer      \
   x11-wm/xmonad                \
   x11-wm/xmonad-contrib        \
   x11-terms/rxvt-unicode       \
   x11-misc/rofi                \
   x11-misc/compton             \
   x11-misc/xmobar              \
   x11-misc/unclutter           \
   x11-misc/xplanet             \
   x11-apps/mesa-progs          \
   x11-base/xorg-server         \
   layman                       \
   || IS_INSTALLED=false

if "$IS_INSTALLED"; then
   echo 'emerge is finish with succeed!'
else
   echo 'emerge is finish with failed...'
   exit
fi

# copy Picture and wallpaper directory to ~/
cp -r Pictures ~/
chmod 755 ~/Pictures/wallpaper/changewp.sh

# install fish theme (yimmy)
bash fish-theme.sh

# install fonts
bash fonts/monaco.sh
bash fonts/powerline-font.sh
