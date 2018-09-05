#!/bin/bash

if [[ ! -d $HOME/.fonts ]]; then
   mkdir ~/.fonts
fi
cd       ~/.fonts

wget https://gist.githubusercontent.com/epegzz/1634235/raw/4691e901750591f9cab0b4ae8b7c0731ebf28cce/Monaco_Linux-Powerline.ttf

if [[ -f Monaco_Linux-Powerline.ttf ]]; then
   fc-cache -vf
else
   echo "Monaco_Linux-Powerline.ttf is not found."
fi
