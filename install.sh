#!/bin/bash

function echo2log {
   echo $1 >> ~/gentoo-tools-failed-log
}

if [[ -f $HOME/gentoo-tools-install-log ]]; then
   rm ~/gentoo-tools-failed-log
fi
touch ~/gentoo-tools-failed-log

sudo emerge -avD              \
   dev-lang/ruby              \
   dev-lang/lua               \
   dev-lang/luajit            \
   dev-lang/perl              \
   dev-java/groovy            \
   dev-vcs/git                \
   www-client/google-chrome   \
   sys-kernel/linux-firmware  \
   media-gfx/feh              \
   x11-wm/xmonad              \
   x11-terms/rxvt-unicode     \
   x11-misc/lightdm           \
   x11-misc/dmenu             \
   layman

