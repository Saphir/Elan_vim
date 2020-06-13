#!/bin/bash

function die() {
    echo "[ERROR] $@" >&2
    exit 1
}

now=$(date +%F_%T)
echo "[INFO] Make sure vim is 8.0+ with --enable-pythoninterp=yes compiled"

cd $(dirname $(readlink -m $0))

if [ -e ~/.bashrc ]
then
    cat ~/.basrhc >> ~/.bashrc.local
    rm ~/.bashrc
fi

for i in vimrc gitconfig zshrc tmux.conf p10k.zsh
do
    ln -s $(readlink -m ./${i}) ~/.${i} || die "Fail to create symbolic link ~/.${i}"
    echo "~/.${i} Done"
done

ln -s $(readlink -m .) ~/.vim || die "Fail to create symbolic link ~/.vim"


