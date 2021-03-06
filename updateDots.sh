#!/bin/bash

if [ "$#" -eq 1 ]
then
    cp -a ~/"$1" .
    exit 0
fi

cp ~/.bashrc    .
cp ~/.gitconfig .
cp ~/.gvimrc    .
cp ~/.inputrc   .
cp ~/.vimrc     .
cp -r ~/.git_template .
cp -r ~/.vim/UltiSnips .
