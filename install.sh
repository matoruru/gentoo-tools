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

if [[ ! -f "./portage.lock" ]]; then
   # install portage files and then lock it
   sudo mv /etc/portage/make.conf /etc/portage/make.conf.old
   sudo ln -srf portage/make.conf /etc/portage/

   sudo ln -srf portage/env         /etc/portage/
   sudo ln -srf portage/package.env /etc/portage/

   sudo mv /etc/portage/package.use/zz-autounmask /etc/portage/zz-autounmask
   sudo rm -rf                                    /etc/portage/package.use
   sudo ln -srf portage/package.use               /etc/portage/
   sudo mv /etc/portage/zz-autounmask             /etc/portage/package.use/

   date > portage.lock
else
   echo "install.sh: portage is locked!"
fi

# to enable layman overlays
sudo layman -L
# to add overlays
sudo layman -a jorgicio

# to make /var/tmp/notmpfs
bash make-notmpfs.sh

IS_INSTALLED=true

sudo emerge -avuDNq @world         \
   app-laptop/laptop-mode-tools    \
   app-editors/nano                \
   app-editors/retext              \
   app-emulation/qemu              \
   app-emulation/virt-manager      \
   app-i18n/mozc                   \
   app-shells/fish                 \
   app-shells/peco                 \
   app-misc/neofetch               \
   app-text/dictd                  \
   app-text/tree                   \
   app-text/qpdfview               \
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
   media-gfx/feh                   \
   media-gfx/scrot                 \
   media-gfx/pinta                 \
   media-gfx/gnome-font-viewer     \
   media-fonts/hack                \
   media-fonts/hermit              \
   media-sound/alsa-utils          \
   media-sound/moc                 \
   media-sound/asunder             \
   net-analyzer/arp-scan           \
   net-fs/samba                    \
   net-misc/bridge-utils           \
   sys-apps/gptfdisk               \
   sys-fs/dosfstools               \
   sys-process/time                \
   sys-process/htop                \
   www-client/chromium             \
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

# install a file for todo list
cp todolist.txt ~/

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
mkdir -p ~/Pictures/wallpaper
ln -srf ~/Pictures/gentoo-1920x1080.jpg ~/Pictures/wallpaper/main.jpg

# enable to make wifi on/off
sudo cp wificommands/wifioff.sh /usr/local/bin/wifioff
sudo cp wificommands/wifion.sh  /usr/local/bin/wifion
sudo chmod +x /usr/local/bin/wifi*

# enable command for dual monitor
sudo cp dual.fish /usr/local/bin/dual
sudo chmod +x     /usr/local/bin/dual

# install fish theme (yimmy)
bash fish-theme.sh

# install fonts
mkdir ~/.fonts
find fonts/ -name "*.tar.bz2"|xargs -n 1 -I XXX tar vxf XXX -C ~/.fonts/
( cd ~/.fonts;fc-cache -vf )

# install n, the Node.js version manager
bash n-node.sh

# install yarn and bower
# !! after bash n-node.sh !!
export PATH=~/.npm-global/bin:$PATH
npm i -g yarn bower

# set symbolic link to stack-bin, stack and install purescript
# !! after bash n-node.sh !!
sudo ln -s /usr/bin/stack-bin /usr/bin/stack
npm i -g purescript pulp

# install vim
sudo ln -sr vim.sh /usr/local/bin/vimupdater
sudo chmod +x      /usr/local/bin/vimupdater
vimupdater
mkdir -p ~/.vim/.tmp/undo   \
         ~/.vim/.tmp/backup \
         ~/.vim/.tmp/swp

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
sudo ln -srf ntp.conf /etc/ntp.conf
sudo rc-update add ntpd default

# kvm
sudo gpasswd -a matoruru kvm
sudo usermod -aG libvirt matoruru
sudo rc-update add libvirtd default
sudo cp /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.old
sudo ln -rfs libvirtd.conf /etc/libvirt/
