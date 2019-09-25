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

            # replace theme str 'sorin' to 'pure'
            lnum=`cat ~/.zpreztorc | grep -n theme | grep zstyle | awk -F':' '{print $1}'`
            gsed -e "${lnum}s/sorin/pure/g" ~/.zpreztorc >| ~/.zpreztorc.new
            \cp ~/.zpreztorc.new .zprezto/runcoms/zpreztorc     # disable aliace
            \rm ~/.zpreztorc.new                                # disable aliace

        else
            # brew is not installed
            echo "brew is not installed."
            echo "please install brew."
            exit 1
        fi
    else
        # replace theme str 'sorin' to 'pure'
        lnum=`cat ~/.zpreztorc | grep -n theme | grep zstyle | awk -F':' '{print $1}'`
        sed -e "${lnum}s/sorin/pure/g" ~/.zpreztorc >| ~/.zpreztorc.new
        \cp ~/.zpreztorc.new .zprezto/runcoms/zpreztorc     # disable aliace
        \rm ~/.zpreztorc.new                                # disable aliace
    fi

    exit 0

else
    # zsh is not installed
    echo "zsh is not installed."
    echo "please install zsh."
    exit 1
fi
