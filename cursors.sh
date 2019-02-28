#!/bin/bash

mkdir ~/.icons

# breeze-cursors
sudo tar xvjf breeze-cursors.tar.bz2 -C /usr/share/icons
ln -s /usr/share/icons/breeze-cursors ~/.icons/
