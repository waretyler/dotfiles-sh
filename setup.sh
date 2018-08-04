#!/bin/bash


rm ~/.profile 
ln -s "$(pwd)/environment.sh" ~/.profile

rm ~/.zshrc 
ln init.sh ~/.zshrc

