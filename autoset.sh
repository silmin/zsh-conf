#!/usr/bin/env bash

type zsh > /dev/null

if [ $? -eq 0 ] ; then
    # zsh is installed
    pos=`which zsh`
    chsh -s $pos

    # install prezto
    cd ~
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "{ZDOTDIR:~$HOME}/.prezto"

    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done

    # replace theme str 'sorin' to 'pure'
    lnum=`cat ~/.zpreztorc | grep -n theme | grep zstyle | awk -F':' '{print $1}'`
    sed -e "${lnum}s/sorin/pure/g" ~/.zpreztorc >| ~/.zpreztorc.new

    # set option
    lnum=`cat ~/.zpreztorc | grep -n \'prompt\' | awk -F':' '{print $1}'`
    gsed -e "${lnum}isyntax-highlighting \\" \
        -e "${lnum}iautosuggestions \\" ~/.zpreztorc >| ~/.zpreztorc.new

    # override
    \cp ~/.zpreztorc.new .zprezto/runcoms/zpreztorc     # disable aliace
    \rm ~/.zpreztorc.new                                # disable aliace

    exit 0

else
    # zsh is not installed
    echo "zsh is not installed."
    echo "please install zsh."
    exit 1
fi
