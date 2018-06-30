#!/bin/bash

echo '[Install languages (for vim):]'

# check whether necessary files is exist or not
NECESSARY_FILES=()
NECESSARY_FILES+=( "/usr/bin/lua"    )
NECESSARY_FILES+=( "/usr/bin/luajit" )
NECESSARY_FILES+=( "/usr/bin/ruby"   )
NECESSARY_FILES+=( "/usr/bin/perl"   )
for file in ${NECESSARY_FILES[@]}
do
   if [ ! -f $file ]; then
      echo "  !! $file is not exist..."
      echo "  !! please solve this problem, and then try again."
      exit
   fi
done

sudo echo Authentication succeeded!

echo  '[Install vim:]'
cd    ~/repositories

if [ -d vim ]; then
   echo "vim repo is exist!"
   echo "just update vim repo..."
   cd vim && git pull && cd ..
else
   echo "vim repo is not exist..."
   git clone https://github.com/vim/vim.git
fi

if [ -f /usr/local/bin/vim ]; then
   echo "vim binary is exist!"
   echo "just update vim binary..."
   VIM_PREVIOUSVER=$( vim --version | grep patches )
   cd vim/src
   sudo make uninstall
   sudo make distclean
   cd ../..
else
   VIM_PREVIOUSVER="NOT INSTALLED"
fi

cd vim/src
./configure                       \
   --enable-multibyte             \
   --enable-luainterp=dynamic     \
   --enable-perlinterp=dynamic    \
   --enable-pythoninterp=dynamic  \
   --enable-python3interp=dynamic \
   --enable-rubyinterp=dynamic    \
   --enable-fontset               \
   --enable-fail-if-missing       \
   --with-luajit                  \
   --with-features=huge           \
   && make && sudo make install

VIM_CURRENTVER=$( vim --version | grep patches )
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!!!!!!!!!!!!  VIM UPDATE INFO  !!!!!!!!!!!!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "  Previous Version:" $VIM_PREVIOUSVER
echo "  Current  Version:" $VIM_CURRENTVER
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# Install plugin manager for vim, dein
if [ ! -d $HOME/.cache/dein ]; then
   mkdir -p $HOME/.cache/dein
   cd       $HOME/.cache/dein
   curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
   sh installer.sh ~/.cache/dein
fi
