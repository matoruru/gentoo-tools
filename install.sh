#!/bin/bash

IS_INSTALLED=true

sudo emerge -av                 \
   app-laptop/laptop-mode-tools \
   app-office/libreoffice       \
   app-editors/retext           \
   app-shells/fish              \
   app-shells/peco              \
   app-misc/sl                  \
   app-misc/oneko               \
   app-misc/neofetch            \
   app-text/qpdfview            \
   app-text/dictd               \
   app-portage/layman           \
   dev-lang/ruby                \
   dev-lang/lua                 \
   dev-lang/luajit              \
   dev-lang/perl                \
   dev-python/spyder            \
   dev-java/groovy              \
   dev-util/dialog              \
   dev-util/ctags               \
   dev-vcs/git                  \
   www-client/qutebrowser       \
   media-gfx/feh                \
   media-gfx/scrot              \
   media-sound/alsa-utils       \
   media-sound/moc              \
   net-misc/youtube-viewer      \
   x11-wm/xmonad                \
   x11-wm/xmonad-contrib        \
   x11-terms/rxvt-unicode       \
   x11-themes/gentoo-xcursors   \
   x11-misc/rofi                \
   x11-misc/compton             \
   x11-misc/xmobar              \
   x11-misc/unclutter           \
   x11-apps/mesa-progs          \
   x11-apps/xsetroot            \
   x11-apps/xmodmap             \
   x11-base/xorg-server         \
   www-servers/apache           \
   || IS_INSTALLED=false

if "$IS_INSTALLED"; then
   echo 'emerge is finish with succeed!'
else
   echo 'emerge is finish with failed...'
   exit
fi

# copy Picture and wallpaper directory to ~/
cp -r Pictures ~/
mkdir          ~/Pictures/Screenshots
chmod 755 ~/Pictures/wallpaper/changewp.sh

# install fish theme (yimmy)
bash fish-theme.sh

# install fonts
bash fonts/monaco.sh
bash fonts/powerline-font.sh
fc-cache -fv

# install vim
bash vim.sh

# enable sound
bash soundEnable.sh

# create a link to apache's documentroot
bash htdocs.sh
