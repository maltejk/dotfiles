#!/usr/bin/env zsh

git submodule init
git submodule update

pushd "$(dirname "${0}")" > /dev/null
FILES="$(pwd -P)"
echo symlinking to "${FILES}"

ls "${FILES}" \
	| egrep -v "^($(basename ${0})|\..+)$" \
	| while read -r line;do
		! test -e "${HOME}/.${line}" \
			&& ln -s "${FILES}/${line}" "${HOME}/.${line}"
	done

vim +PlugInstall

