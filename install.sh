#!/bin/bash

if [[ ! $(pwd) = "$HOME/repositories/matoruru/gentoo-tools" ]]; then
   echo "Invalid location!"
   echo "Move to $HOME/repositories/matoruru/gentoo-tools and execute again..."
   exit
fi

function ping_failure {
   echo "no connection... failure"
   echo "exit"
   exit
}
ping www.google.com -c5 -i 0.2 || ping_failure

IS_INSTALLED=true

sudo emerge -avuDN @world       \
   app-laptop/laptop-mode-tools \
   app-office/libreoffice       \
   app-editors/retext           \
   app-emulation/docker         \
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
   dev-vcs/bzr                  \
   www-client/qutebrowser       \
   media-gfx/feh                \
   media-gfx/scrot              \
   media-gfx/pinta              \
   media-sound/alsa-utils       \
   media-sound/moc              \
   net-misc/youtube-viewer      \
  =net-im/corebird-1.1          \
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

# copy Picture to ~/
cp -r Pictures ~/
sudo cp setwp.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/setwp.sh
setwp.sh ~/Pictures/ruru.png

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

# create executable file in path
sudo cp screenshot.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/screenshot.sh

# enable docker with non-root user
bash docker.sh

# set capitaine-theme as the cursor
mkdir ~/.icons
ln -s /usr/share/icons/capitaine-cursors ~/.icons/
