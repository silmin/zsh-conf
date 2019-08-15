#!/usr/bin/env bash

type zsh > /dev/null

if [ $? -eq 0 ] ; then
    # zsh is installed
    exit 0
else
    # zsh is not installed
    exit 1
fi
