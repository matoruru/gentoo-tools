echo '[Install languages (for vim):]'
emerge dev-lang/ruby
emerge dev-lang/lua
emerge dev-lang/luajit

echo  '[Install vim:]'
cd    ~/repositories
git   clone https://github.com/vim/vim.git
cd    vim/src
./configure --enable-multibyte             \
            --enable-luainterp=dynamic     \
            --enable-perlinterp=dynamic    \
            --enable-perlinterp=dynamic    \
            --enable-pythoninterp=dynamic  \
            --enable-python3interp=dynamic \
            --enable-rubyinterp=dynamic    \
            --enable-fontset               \
            --enable-fail-if-missing       \
            --with-luajit                  \
            --with-features=huge           \
            && make && make install

# Set alias for multitably open
echo                       >> ~/.bashrc
echo  "alias vim='vim -p'" >> ~/.bashrc
echo                       >> ~/.fishrc
echo  "alias vim='vim -p'" >> ~/.fishrc

# Clone my vimrc and create symbolic link
cd  ~/repositories
git clone https://github.com/shgt/vimrc.git
ln  -s ~/repositories/vimrc/.vimrc ~/.vimrc

# Install plugin manager for vim, dein
mkdir -p           ~/.cache/dein
cd                 ~/.cache/dein
curl  https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh    installer.sh ~/.cache/dein
