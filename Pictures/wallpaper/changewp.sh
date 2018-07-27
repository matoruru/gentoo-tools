#!/bin/bash

if [[ -f main.jpg ]]; then
   rm main.jpg
fi
cp $1 main.jpg

bash ~/.fehbg &
