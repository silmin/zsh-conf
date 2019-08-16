#!/usr/bin/env bash

type zsh > /dev/null

if [ $? -eq 0 ] ; then
    # zsh is installed
    #pos=`which zsh`
    #chsh -s $pos

    kernel=`uname`
    if [ $kernel = "Darwin" ] ; then
        # replace sed (BSD -> GNU)
        type brew > /dev/null
        if [ $? -eq 0 ] ; then
            # brew is installed
            brew install gawk
            brew install gnu-sed
            
            echo "path=(
                /usr/local/opt/gnu-sed/libexec/gnubin(N-/)
                /usr/local/opt/gawk/libexec/gnubin(N-/)
                ${path}
            )
            manpath=(
                /usr/local/opt/gnu-sed/libexec/gnuman(N-/)
                /usr/local/opt/gawk/libexec/gnuman(N-/)
                ${manpath}
            )" >> ~/.zshrc

            source ~/.zshrc

        else
            # brew is not installed
            echo "brew is not installed."
            echo "please install brew."
            exit 1
        fi
    fi
    exit 0
else
    # zsh is not installed
    echo "zsh is not installed."
    echo "please install zsh."
    exit 1
fi
