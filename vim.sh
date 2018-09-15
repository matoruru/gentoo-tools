#!/bin/bash

echo '[Install languages (for vim):]'

function ping_failure {
   echo "no connection... failure"
   echo "exit"
   exit
}
ping www.google.com -c1 || ping_failure

# check whether necessary files is exist or not
NECESSARY_FILES=()
NECESSARY_FILES+=( "/usr/bin/lua"    )
NECESSARY_FILES+=( "/usr/bin/luajit" )
NECESSARY_FILES+=( "/usr/bin/ruby"   )
NECESSARY_FILES+=( "/usr/bin/perl"   )
for file in ${NECESSARY_FILES[@]}
do
   if [[ ! -f $file ]]; then
      echo "  !! $file is not exist..."
      echo "  !! please solve this problem, and then try again."
      exit
   fi
done

sudo echo Authentication succeeded!

echo  '[Install vim:]'
cd    ~/repositories

if [[ -d vim ]]; then
   echo "vim repo is exist!"
   echo "just update vim repo..."
   cd vim
   COMMANDOUTPUT=$( git pull )
   echo "$COMMANDOUTPUT"
   if [[ "$COMMANDOUTPUT" = "Already up to date." ]]; then exit; fi
   cd ..
else
   echo "vim repo is not exist..."
   git clone https://github.com/vim/vim.git
   if [[ ! -d vim ]]; then
      echo "cloning of vim repo finished with failure..."
      exit
   fi
fi

if [[ -f /usr/local/bin/vim ]]; then
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
   --disable-gpm                  \
   --disable-gui                  \
   --with-luajit                  \
   --with-features=huge           \
   && make -j8 && sudo make -j8 install

VIM_CURRENTVER=$( vim --version | grep patches )
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!!!!!!!!!!!!  VIM UPDATE INFO  !!!!!!!!!!!!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "  Previous Version:" $VIM_PREVIOUSVER
echo "  Current  Version:" $VIM_CURRENTVER
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# Install plugin manager for vim, dein
if [[ ! -d $HOME/.vim/dein ]]; then
   mkdir -p $HOME/.vim/dein
   cd       $HOME/.vim/dein
   curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
   sh installer.sh ~/.vim/dein
fi
