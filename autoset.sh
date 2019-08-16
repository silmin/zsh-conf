#!/usr/bin/env bash

type zsh > /dev/null

if [ $? -eq 0 ] ; then
    # zsh is installed
    pos=`which zsh`
    chsh -s $pos

    # install prezto
    cd
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "{ZDOTDIR:~$HOME}/.prezto"

    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
    
    exit 0
else
    # zsh is not installed
    echo "zsh is not installed."
    echo "please install zsh."
    exit 1
fi
