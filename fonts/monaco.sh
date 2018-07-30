#!/bin/bash

cd  ~/repositories

if [[ ! -d monaco.ttf ]]; then
   git clone https://github.com/todylu/monaco.ttf
fi

mkdir                    ~/.fonts
cp monaco.ttf/monaco.ttf ~/.fonts/
