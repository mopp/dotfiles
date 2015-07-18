#!/bin/sh


DOTFILES_DIR=$HOME/Workspace/repo/dotfiles


command_exists()
{
    if ! type "$1" &> /dev/null; then
        echo "$1 not found"
        return 1
    fi
}


ask()
{
    while read -p "$1 [y/n] " ans ; do
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
    ask "Do you want to create symbolic link $1 ?"
}


sym_link()
{
    if [ $# -ne 2 ] && [ $# -ne 3 ]; then
        echo "Invalid argument."
        return 1
    fi

    if [ ! -e $DOTFILES_DIR/$2 ]; then
        echo "$2 is NOT exist."
        return 1
    fi

    if [ $1 -eq 1 ]; then
        is_create_sym_link $2
        if [ $? -eq 0 ]; then
            return 1
        fi
    fi

    src=$(readlink -f $2)
    [ $# -eq 3 ] && dst=$3 || dst=$HOME/$2

    echo ln -s $src $dst

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

mkdir -p $DOTFILES_DIR
git clone git@github.com:mopp/dotfiles.git $DOTFILES_DIR

sym_link_no_conf ".vimrc"
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/view
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

sym_link_no_conf ".zshrc"
sym_link_no_conf ".gitconfig"
sym_link_no_conf ".vrapperrc"

os_type=$(uname)
case "${os_type}" in
    Darwin*)
        ;;
    Linux*)
        sym_link_conf ".xinitrc"
        sym_link_conf ".Xdefaults"

        ask "Do you setup i3 window manager config files ?"
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
