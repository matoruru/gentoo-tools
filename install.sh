#!/bin/bash

IS_INSTALLED=true

sudo emerge -avD              \
   dev-lang/ruby              \
   dev-lang/lua               \
   dev-lang/luajit            \
   dev-lang/perl              \
   dev-java/groovy            \
   dev-vcs/git                \
   app-shells/fish            \
   app-misc/sl                \
   app-text/qpdfview          \
   www-client/google-chrome   \
   media-gfx/feh              \
   x11-wm/xmonad              \
   x11-wm/xmonad-contrib      \
   x11-terms/rxvt-unicode     \
   x11-misc/lightdm           \
   x11-misc/dmenu             \
   x11-misc/compton           \
   x11-base/xorg-server       \
   layman                     \
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
