#!/bin/bash

if [[ ! -d $HOME/Pictures/Screenshots/ ]]; then
   mkdir -p ~/Pictures/Screenshots
fi
cd          ~/Pictures/Screenshots

tmpname=_____scReeNshoT-tmP.png
if [[ -f $tmpname ]]; then
   exit
fi

newname=$( scrot -q 100 $1 '%Y-%m-%d-%T-screenshot.png' -e 'echo $f' )
cp $newname                  $tmpname
timeout 1 feh --fullscreen --zoom 98 $tmpname
rm                           $tmpname
