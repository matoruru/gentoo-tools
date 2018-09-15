#!/bin/bash

if [[ ! -d $HOME/.config/nvim/dein ]]; then
   mkdir -p $HOME/.config/nvim/dein
   cd       $HOME/.config/nvim/dein
   curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
   sh installer.sh ~/.config/nvim/dein
fi
