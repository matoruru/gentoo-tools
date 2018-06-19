# use it after emergeing fish
touch    ~/.config/fish/config.fish
ln    -s ~/.config/fish/config.fish ~/.fishrc
echo  "alias nano='nano -w'"                  >> ~/.fishrc
echo  "alias ll='ls -alF'"                    >> ~/.fishrc
echo  "alias emerge='sudo emerge'"            >> ~/.fishrc
echo  "alias udn='emerge -auDN @world'"       >> ~/.fishrc
