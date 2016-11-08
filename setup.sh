#!/bin/zsh

pushd $(dirname ${0}) > /dev/null
FILES=$(pwd -P)
echo symlinking to ${FILES}

xargs -n 1 -i ln -s ${FILES}/"{}" ~/."{}" <<(ls ${FILES} | grep -vP "^$(basename ${0})$")

vim +PlugInstall

