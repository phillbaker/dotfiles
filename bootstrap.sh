#!/bin/bash
cd "$(dirname "${BASH_SOURCE}")"
git pull
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}
function doExamples() {
  for file in `ls ~/.*.example`; do mv "${file}" "${file%.example}"; done
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
  doExamples
else
	read -p "This may overwrite existing files in your home directory. It will copy examples to their non-example locations. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi

  read -p "Copy examples to their non-example locations? Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doExamples
  fi
fi
unset doIt
unset doExamples
source ~/.bash_profile