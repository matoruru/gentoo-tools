# use it after emergeing fish
touch    ~/.config/fish/config.fish
ln    -s ~/.config/fish/config.fish ~/.fishrc
echo  "alias nano='nano -w'"                  >> ~/.fishrc
echo  "alias ll='ls -alF'"                    >> ~/.fishrc
echo  "alias udn='sudo emerge-webrsync;sudo emerge -auDN @world'"       >> ~/.fishrc
