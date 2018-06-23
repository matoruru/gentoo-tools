#!/bin/bash

# do not execute this script at CLI login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  echo "please execute after you can be able to login with GUI."
  exit
fi

sudo emerge -av             \
   dev-lang/ruby            \
   dev-lang/lua             \
   dev-lang/luajit          \
   www-client/google-chrome 

