#!/usr/bin/env zsh

git submodule init
git submodule update

pushd $(dirname ${0}) > /dev/null
FILES=$(pwd -P)
echo symlinking to ${FILES}

xargs -n 1 -I "{}" ln -s ${FILES}/"{}" ~/."{}" <<(ls ${FILES} | egrep -v "^($(basename ${0})|\..+)$")

vim +PlugInstall

