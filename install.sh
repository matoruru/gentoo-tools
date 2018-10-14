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

# to enable layman overlays
sudo layman -L
# to add overlays
sudo layman -a jorgicio

IS_INSTALLED=true

sudo emerge -avuDN @world          \
   app-laptop/laptop-mode-tools    \
   app-editors/neovim              \
   app-emulation/docker            \
   app-i18n/mozc                   \
   app-shells/fish                 \
   app-shells/peco                 \
   app-misc/neofetch               \
   app-text/dictd                  \
   dev-lang/ruby                   \
   dev-lang/lua                    \
   dev-lang/luajit                 \
   dev-lang/perl                   \
   dev-java/groovy                 \
   dev-haskell/stack-bin           \
   dev-ruby/colorize               \
   dev-util/dialog                 \
   dev-util/ctags                  \
   dev-vcs/git                     \
   dev-vcs/bzr                     \
   www-client/qutebrowser          \
   media-gfx/feh                   \
   media-gfx/scrot                 \
   media-gfx/gnome-font-viewer     \
   media-fonts/hack                \
   media-fonts/fantasque-sans-mono \
   media-fonts/monoid              \
   media-fonts/hermit              \
   media-sound/alsa-utils          \
   media-sound/moc                 \
   net-im/corebird                 \
   net-libs/nodejs                 \
   sys-process/time                \
   x11-wm/xmonad                   \
   x11-wm/xmonad-contrib           \
   x11-terms/rxvt-unicode          \
   x11-themes/capitaine-cursors    \
   x11-misc/rofi                   \
   x11-misc/compton                \
   x11-misc/xmobar                 \
   x11-apps/mesa-progs             \
   x11-apps/xsetroot               \
   x11-apps/xmodmap                \
   x11-apps/xbacklight             \
   x11-base/xorg-server            \
   || IS_INSTALLED=false

if "$IS_INSTALLED"; then
   echo 'emerge is finish with succeed!'
else
   echo 'emerge is finish with failed...'
   exit
fi

ping www.google.com -c5 -i 0.2 || ping_failure

# install dic
(
   cd ~/repositories/matoruru
   git clone git@github.com:matoruru/dic.git
   cd dic;bash install.sh
)

# copy Picture to ~/
cp -r Pictures ~/
sudo cp setwp.sh /usr/local/bin/setwp
sudo chmod +x /usr/local/bin/setwp
setwp ~/Pictures/ruru.png

# enable to make wifi on/off
sudo cp wificommands/wifioff.sh /usr/local/bin/wifioff
sudo cp wificommands/wifion.sh  /usr/local/bin/wifion
sudo chmod +x /usr/local/bin/wifi*

# install fish theme (yimmy)
bash fish-theme.sh

# install fonts
mkdir ~/.fonts
find fonts/ -name "*.tar.bz2"|xargs -n 1 -I XXX tar vxf XXX -C ~/.fonts/
( cd ~/.fonts;fc-cache -vf )


# install vim
bash vim.sh

# install nvim settings
bash nvim.sh

# enable sound
bash soundEnable.sh

# create a link to apache's documentroot
bash htdocs.sh

# create executable file in path
sudo cp screenshot.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/screenshot.sh

# enable docker with non-root user
bash docker.sh

# set symbolic links to cursor images
bash cursors.sh

# enable tap as click
sudo ln -srf 40-libinput.conf /usr/share/X11/xorg.conf.d/
