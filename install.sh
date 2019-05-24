#!/bin/bash

function die() {
    echo "[ERROR] $@" >&2
    exit 1
}

echo "[INFO] Make sure vim is 8.0+ with --enable-pythoninterp=yes compiled"

if [ -e ~/.vim ]
then
    die "Remove ~/.vim before this installation"
fi
if [ -e ~/.vimrc ]
then
    die "Remove ~/.vimrc before this installation"
fi

cd $(dirname $(readlink -m $0))
ln -s $(readlink -m .) ~/.vim || die "Fail to create symbolic link ~/.vim"
ln -s $(readlink -m ./vimrc) ~/.vimrc || die "Fail to create symbolic link ~/.vimrc"

