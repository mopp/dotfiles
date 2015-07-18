#!/bin/sh


DOTFILES_DIR=$HOME/git/dotfiles


command_exists()
{
    if ! type "$1" &> /dev/null; then
        echo "$1 not found"
        return 1
    fi
}


sym_link()
{
    if [ $# -ne 1 ] && [ $# -ne 2 ]; then
        echo "Invalid argument."
        return 1
    fi

    if [ ! -e $DOTFILES_DIR/$1 ]; then
        echo "$1 is NOT exist."
        return 1
    fi

    src=$(readlink -f $1)
    [ $# -eq 2 ] && dst=$2 || dst=$HOME/$1

    echo ln -s $src $dst

    return 0
}




# Check commands
command_exists "git"
echo git clone git@github.com:mopp/dotfiles.git $DOTFILES_DIR


sym_link ".vimrc"
sym_link ".zshrc"
