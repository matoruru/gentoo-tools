cd
sudo emerge -C nodejs
curl -L https://git.io/n-install | bash -s -- -y
sudo ln -s ~/n/bin/n /usr/local/bin/
sudo n lts
sudo n latest

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
