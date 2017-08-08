#!/bin/bash



rm ~/.profile 
ln -s "$(pwd)/.profile" ~/.profile

rm ~/.zshrc 
ln init.sh ~/.zshrc

