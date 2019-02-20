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
ping www.github.com -c5 -i 0.2 || ping_failure

# to enable layman overlays
sudo layman -L
# to add overlays
sudo layman -a jorgicio

# to make /var/tmp/notmpfs
bash make-notmpfs.sh

IS_INSTALLED=true

sudo emerge -avuDN @world          \
   app-laptop/laptop-mode-tools    \
   app-editors/neovim              \
   app-editors/nano                \
   app-emulation/qemu              \
   app-emulation/virt-manager      \
   app-i18n/mozc                   \
   app-shells/fish                 \
   app-shells/peco                 \
   app-misc/neofetch               \
   app-text/dictd                  \
   app-text/tree                   \
   dev-lang/ruby                   \
   dev-lang/lua                    \
   dev-lang/luajit                 \
   dev-lang/perl                   \
   dev-lang/php                    \
   dev-haskell/stack-bin           \
   dev-ruby/colorize               \
   dev-ruby/nokogiri               \
   dev-util/dialog                 \
   dev-util/ctags                  \
   dev-util/idea-community         \
   dev-vcs/git                     \
   dev-vcs/bzr                     \
   media-gfx/feh                   \
   media-gfx/scrot                 \
   media-gfx/gnome-font-viewer     \
   media-fonts/hack                \
   media-fonts/hermit              \
   media-sound/alsa-utils          \
   media-sound/moc                 \
   media-sound/asunder             \
   net-analyzer/arp-scan           \
   net-fs/samba                    \
   net-im/corebird                 \
   net-libs/nodejs                 \
   net-misc/bridge-utils           \
   sys-apps/yarn                   \
   sys-process/time                \
   sys-process/htop                \
   x11-drivers/xf86-video-intel    \
   x11-wm/xmonad                   \
   x11-wm/xmonad-contrib           \
   x11-terms/rxvt-unicode          \
   x11-terms/kitty                 \
   x11-themes/capitaine-cursors    \
   x11-misc/rofi                   \
   x11-misc/compton                \
   x11-misc/xmobar                 \
   x11-misc/xclip                  \
   x11-misc/wmname                 \
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

ping www.github.com -c5 -i 0.2 || ping_failure

# install dic
(
   cd ~/repositories/matoruru
   git clone git@github.com:matoruru/dic.git
   cd dic;bash install.sh
)

# copy Picture to ~/ and set wallpaper
cp -r Pictures ~/
sudo cp setwp.sh /usr/local/bin/setwp
sudo chmod +x /usr/local/bin/setwp
curl -o ~/Pictures/gentoo-1920x1080.jpg https://www.gentoo.org/assets/img/wallpaper/gentoo-10/purple/1920x1080.jpg
setwp ~/Pictures/gentoo-1920x1080.jpg

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

# set symbolic link to stack-bin, stack and install purescript
sudo ln -s /usr/bin/stack-bin /usr/bin/stack
bash purescript.sh

# install vim
bash vim.sh
mkdir -p ~/.vim/.tmp/undo   \
         ~/.vim/.tmp/backup \
         ~/.vim/.tmp/swp

# install nvim settings
bash nvim.sh

# enable sound
# bash soundEnable.sh

# create a link to apache's documentroot
bash htdocs.sh

# create executable file in path
sudo cp screenshot.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/screenshot.sh

# set symbolic links to cursor images
bash cursors.sh

# enable tap as click
sudo ln -srf 40-libinput.conf /usr/share/X11/xorg.conf.d/

# add dbus to default
sudo rc-update add dbus default

# use ntpd
sudo rc-update add ntpd default

# kvm
sudo gpasswd -a matoruru kvm
sudo usermod -aG libvirt matoruru
sudo rc-update add libvirtd default
sudo cp /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.old
sudo ln -rfs libvirtd.conf /etc/libvirt/
