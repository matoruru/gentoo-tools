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
   app-office/libreoffice          \
   app-editors/retext              \
   app-editors/neovim              \
   app-emulation/docker            \
   app-shells/fish                 \
   app-shells/peco                 \
   app-misc/sl                     \
   app-misc/oneko                  \
   app-misc/neofetch               \
   app-text/qpdfview               \
   app-text/dictd                  \
   app-portage/layman              \
   dev-lang/ruby                   \
   dev-lang/lua                    \
   dev-lang/luajit                 \
   dev-lang/perl                   \
   dev-python/spyder               \
   dev-java/groovy                 \
   dev-util/dialog                 \
   dev-util/ctags                  \
   dev-util/android-studio         \
   dev-util/android-tools          \
   dev-vcs/git                     \
   dev-vcs/bzr                     \
   www-client/qutebrowser          \
   media-gfx/feh                   \
   media-gfx/scrot                 \
   media-gfx/pinta                 \
   media-gfx/gnome-font-viewer     \
   media-fonts/hack                \
   media-fonts/fantasque-sans-mono \
   media-fonts/monoid              \
   media-fonts/hermit              \
   media-sound/alsa-utils          \
   media-sound/moc                 \
   net-misc/youtube-viewer         \
   net-im/corebird                 \
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
   www-servers/apache              \
   || IS_INSTALLED=false

if "$IS_INSTALLED"; then
   echo 'emerge is finish with succeed!'
else
   echo 'emerge is finish with failed...'
   exit
fi

ping www.google.com -c5 -i 0.2 || ping_failure

# copy Picture to ~/
cp -r Pictures ~/
sudo cp setwp.sh /usr/local/bin/setwp
sudo chmod +x /usr/local/bin/setwp
setwp ~/Pictures/ruru.png

# install fish theme (yimmy)
bash fish-theme.sh

# install fonts
mkdir ~/.fonts
tar vxf  Cica3.tar.bz2 -C ~/.fonts/
tar vxf  osaka.tar.bz2 -C ~/.fonts/
tar vxf monaco.tar.bz2 -C ~/.fonts/
tar vxf myfont.tar.bz2 -C ~/.fonts/
( cd ~/.fonts;fc-cache -vf )

# install vim
bash vim.sh

# install nvim settings
if [[ ! -d $HOME/.config/nvim/dein ]]; then
   mkdir -p $HOME/.config/nvim/dein
   cd       $HOME/.config/nvim/dein
   curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
   sh installer.sh ~/.config/nvim/dein
fi

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
