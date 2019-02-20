# install purs and pulp in ~/purescript
mkdir -p ~/purescript
cd ~/purescript
npm i -D purescript pulp

# purs.bin is installed but delete it and compile it
cd node_modules/.bin

# create links in /usr/local/bin
sudo ln -sr ./purs /usr/local/bin/
sudo ln -sr ./pulp /usr/local/bin/
