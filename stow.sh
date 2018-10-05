#!/bin/bash

echo "Linking dotfiles to home directory ($HOME)";

cd ~/dotfiles

for file in ~/dotfiles/*; do
    if [ -d ${file} ]; then
        stow -R $(basename $file)
        echo "$(basename $file) stowed.";
    fi
done

cd ~-

echo "Files are now stowed";
