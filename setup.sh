#!/bin/bash

if [ ! -d ~/dotfiles ]; then
    echo "Cloning ericpts/dotfiles into ~/dotfiles"
    git clone https://github.com/ericpts/dotfiles ~/dotfiles
else
    echo "Found already existing ~/dotfiles"
fi

cd ~/dotfiles

sudo apt -qq update
sudo apt -qq install ansible software-properties-common git

cd playbooks
./launch
