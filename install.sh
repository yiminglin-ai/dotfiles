#!/usr/bin/env bash

# backup dotfiles
mkdir -p $HOME/.dotfiles_backup

# create symlinks 
for rcfile in $PWD/*/*; do
        filename=$(basename "$rcfile")
        mv -f $HOME/.$filename $HOME/.dotfiles_backup 2>/dev/null
        ln -sf $rcfile $HOME/.$filename
done

# clone zprezto 
rm -rf ~/.zprezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# make pure theme show conda env
sed -i '190i\\tif [[ -n $CONDA_DEFAULT_ENV ]]; then' ${ZDOTDIR:-$HOME}/.zprezto/modules/prompt/external/pure/pure.zsh
sed -i '191i\\t\tpsvar[12]="$CONDA_DEFAULT_ENV"' ${ZDOTDIR:-$HOME}/.zprezto/modules/prompt/external/pure/pure.zsh
sed -i '192i\\tfi' ${ZDOTDIR:-$HOME}/.zprezto/modules/prompt/external/pure/pure.zsh


# pull all submodules (vim packages)
git submodule update --init --recursive
