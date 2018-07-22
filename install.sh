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
   app-shells/fish            \
   app-misc/sl                \
   www-client/google-chrome   \
   media-gfx/feh              \
   x11-wm/xmonad              \
   x11-apps/xinput            \
   x11-terms/rxvt-unicode     \
   x11-misc/lightdm           \
   x11-misc/dmenu             \
   x11-misc/xcompmgr          \
   x11-base/xorg-server       \
   layman

# check whether necessary files is exist or not
NECESSARY_FILES=()
NECESSARY_FILES+=( "/usr/bin/ruby"                   )
NECESSARY_FILES+=( "/usr/bin/lua"                    )
NECESSARY_FILES+=( "/usr/bin/luajit"                 )
NECESSARY_FILES+=( "/usr/bin/groovy"                 )
NECESSARY_FILES+=( "/usr/bin/git"                    )
NECESSARY_FILES+=( "/bin/fish"                       )
NECESSARY_FILES+=( "/usr/bin/sl"                     )
NECESSARY_FILES+=( "/usr/bin/google-chrome-stable"   )
NECESSARY_FILES+=( "/bin/fish"                       )
NECESSARY_FILES+=( "/usr/bin/feh"                    )
NECESSARY_FILES+=( "/usr/bin/xmonad"                 )
NECESSARY_FILES+=( "/usr/bin/xinput"                 )
NECESSARY_FILES+=( "/usr/bin/urxvt"                  )
NECESSARY_FILES+=( "/usr/bin/dmenu"                  )
NECESSARY_FILES+=( "/usr/bin/xcompmgr"               )
NECESSARY_FILES+=( "/usr/bin/layman"                 )
for file in ${NECESSARY_FILES[@]}
do
   if [[ ! -f $file ]]; then
      echo2log "$file is not exist..."
   else
      echo     "$file is exist!"
   fi
done

echo INPORTANT!! just created ~/gentoo-tools-failed-log !
