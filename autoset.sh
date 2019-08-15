#!/usr/bin/env bash

type zsh > /dev/null

if [ $? -eq 0 ] ; then
    # zsh is installed
    #pos=`which zsh`
    #chsh -s $pos

    kernel=`uname`
    if [ $kernel = "Darwin" ] ; then
        # replace sed (BSD -> GNU)
    fi
    exit 0
else
    # zsh is not installed
    echo "zsh is not installed."
    echo "please install zsh."
    exit 1
fi
