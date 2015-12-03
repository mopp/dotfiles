#!/bin/bash


DOTFILES_DIR=$HOME/Workspace/repo/dotfiles


command_exists()
{
    if [[ -x $(which "${1}") ]]; then
        return 0
    fi

    echo "$1 command not found."
    return 1
}


ask()
{
    while read -p "${1} [y/n] " ans ; do
        case $ans in
            [Yy]*)
                return 1
                ;;
            [Nn]*)
                return 0
                ;;
            *)
                echo "Please input yes or no.";;
        esac
    done
}


is_create_sym_link()
{
    ask "Do you want to link ${1} ?"
}


sym_link()
{
    if [ $# -ne 2 ] && [ $# -ne 3 ]; then
        echo "Invalid argument."
        return 1
    fi

    if [ ! -e $DOTFILES_DIR/$2 ]; then
        echo "${2} is NOT exist."
        return 1
    fi

    if [ $1 -eq 1 ]; then
        is_create_sym_link $2
        if [ $? -eq 0 ]; then
            return 1
        fi
    fi

    src=$DOTFILES_DIR/$2
    dst=$HOME/$3

    echo $src $dst
    ln -s $src $dst

    return 0
}


sym_link_no_conf()
{
    sym_link 0 $1 $2
}


sym_link_conf(){
    sym_link 1 $1 $2
}




# Check commands
command_exists "git"
if [ $? -eq 1 ]; then
    exit 1
fi

if [ ! -e $DOTFILES_DIR ]; then
    git clone https://github.com/mopp/dotfiles.git $DOTFILES_DIR
fi

sym_link_no_conf ".vimrc"
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/view
mkdir -p ~/.config/
ln -s ~/.vim ~/.config/nvim
sym_link_no_conf ".vimrc" ".config/nvim/init.vim"

NEOBUNDLE_DIR=~/.vim/bundle/neobundle.vim
if [ ! -e $NEOBUNDLE_DIR ]; then
    git clone https://github.com/Shougo/neobundle.vim $NEOBUNDLE_DIR
fi

sym_link_no_conf ".zshrc"
sym_link_no_conf ".gitconfig"
sym_link_no_conf ".vrapperrc"

ask "Do you want to install zslot ?"
TOOLS_DIR=~/Tools/
if [ $? -eq 1 ]; then
    if [ ! -e $TOOLS_DIR ]; then
        mkdir $TOOLS_DIR
    fi
    git clone https://github.com/kmhjs/zslot.git $TOOLS_DIR
fi

os_type=$(uname)
case "${os_type}" in
    Darwin*)
        ask "Do you want to install homebrew ?"
        if [ $? -eq 1 ]; then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi
        ;;
    Linux*)
        sym_link_conf ".xinitrc"
        sym_link_conf ".Xdefaults"
        sym_link_conf ".Xmodmap"

        ask "Do you want to link i3 window manager config files ?"
        if [ $? -eq 1 ]; then
            mkdir -p ~/.i3
            sym_link_no_conf "i3_config" "$HOME/.i3/config"
            sym_link_no_conf "i3exit" "$HOME/.i3/i3exit"
            sym_link_no_conf ".i3status.conf"
        fi
        ;;
    *)
        echo "Unknown: $os_type"
        ;;
esac
