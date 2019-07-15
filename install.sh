#!/bin/bash

function die() {
    echo "[ERROR] $@" >&2
    exit 1
}

now=$(date +%F_%T)
echo "[INFO] Make sure vim is 8.0+ with --enable-pythoninterp=yes compiled"

cd $(dirname $(readlink -m $0))

for i in vim vimrc bashrc gitconfig cheat zshrc screenrc tmux.conf
do
    [ -e ~/.${i} ] && (mv ~/.${i} ~/.${i}.bak.$now || die "Fail to mv ~/.${i} ~/.${i}.bak.$now")
    if [[ ${i} == vim ]]
    then
        ln -s $(readlink -m .) ~/.${i} || die "Fail to create symbolic link ~/.${i}"
    else
        ln -s $(readlink -m ./${i}) ~/.${i} || die "Fail to create symbolic link ~/.${i}"
    fi
    echo "~/.${i} Done"
done
