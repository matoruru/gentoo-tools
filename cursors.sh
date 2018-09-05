#!/bin/bash

mkdir ~/.icons

# capitaine-cursors
ln -s /usr/share/icons/capitaine-cursors ~/.icons/

# breeze-cursors
sudo tar xvjf breeze-cursors.tar.bz2 -C /usr/share/icons
ln -s /usr/share/icons/breeze-cursors ~/.icons/
