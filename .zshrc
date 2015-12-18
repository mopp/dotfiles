#---------------------------------------------------------------------------------------"
# Environment variables.
#   CC              C compiler command
#   CFLAGS          C compiler flags
#   LDFLAGS         linker flags, e.g. -L<lib dir> if you have libraries in a nonstandard directory <lib dir>
#   LIBS            libraries to pass to the linker, e.g. -l<library>
#   CPPFLAGS        C/C++/Objective C preprocessor flags, e.g. -I<include dir> if you have headers in a nonstandard directory <include dir>
#   CXX             C++ compiler command
#   CXXFLAGS        C++ compiler flags
#   LIBRARY_PATH    this is used by gcc before compilation to search for directories containing libraries that need to be linked to your program.
#   LD_LIBRARY_PATH this is used by your program to search for directories containing the libraries after it has been successfully compiled and linked.
#   CPATH
#   C_INCLUDE_PATH
#   CPLUS_INCLUDE_PATH
#   CPLUS_LIBRARY_PATH
#   DYLD_FALLBACK_LIBRARY_PATH
#   DYLD_LIBRARY_PATH
#   BOOST_ROOT
#---------------------------------------------------------------------------------------"
export LANG=en_US.UTF-8

# Setting for each OS.
case $OSTYPE in
    solaris*)
        export TERM='rxvt'
        export PATH=/home/grd/m5191121/local.solaris/bin/:$PATH
        ;;
    darwin*)
        export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
        export PATH=/usr/local/bin:$PATH
        export PATH=/usr/local/sbin:$PATH
        export PATH=/usr/texbin:$PATH
        export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
        export MANPATH=/usr/local/share/man:$MANPATH

        # Setting for zsh completion and highlight.
        export FPATH=/usr/local/share/zsh-completions:$FPATH
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

        [[ -e $(alias run-help) ]] && unalias run-help
        autoload run-help
        export HELPDIR=/usr/local/share/zsh/helpfiles

        alias eclipse='/Applications/eclipse/eclipse'
        ;;
    linux*)
        export JAVA_FONTS=/usr/share/fonts/TTF

        case $(hostname) in
            flan)
                source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
                ;;
            rosetta)
                export TERM=xterm-256color
                ;;
        esac

        if [[ -x $(which clang) ]]; then
            export CC=clang
            export CXX=clang++
        fi

        if grep '^fbterm' /proc/$PPID/cmdline > /dev/null; then
            export TERM=fbterm
        fi
        ;;
esac

# Setting for each terminal.
case $TERM in
    *rxvt*)
        stty -ixon
        ;;
esac

# Setting for Ruby.
if [[ -x $(which ruby) ]]; then
    export GEM_HOME=$(ruby -e 'print Gem.user_dir')
    export PATH=$GEM_HOME/bin:$PATH
fi

# Setting for rbenv.
if [[ -d $HOME/.rbenv ]]; then
    export PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
fi

# Setting for zslot.
# https://github.com/kmhjs/zslot.git
ZSLOT_SRC=~/Tools/zslot/src/
if [ -e $ZSLOT_SRC ]; then
    export FPATH=$ZSLOT_SRC:$FPATH
    autoload -Uz zslot
    export ZUSER_SLOT_FILE_NAME=$HOME/.zslot_info
    export ZUSER_SLOT_MAX_SLOT_ID=9
    alias zs=zslot
    alias zss='zslot -s'
    alias zsp='zslot -p'
fi

# Setting for EDITOR.
if [[ -x $(which nvim) ]]; then
    export EDITOR=nvim
elif [[ -x $(which vim) ]]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
export PAGER=less
export LESS='-R -f -X --LINE-NUMBERS --tabs=4 --ignore-case --SILENT -P --LESS-- ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'

export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# Remove duplicate in environment variables.
typeset -U PATH CDPATH FPATH MANPATH


# Complement
autoload -U compinit
compinit -u
# zmodload zsh/mathfunc;
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types
setopt auto_param_slash
setopt magic_equal_subst
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:options' description 'yes'


# Move.
setopt auto_cd      # moving only directory name.
setopt auto_pushd   # add directory stack during cd moving.


# History.
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks


# Prompt
# PROMPT : Normal prompt.
# PROMPT2: Multiline prompt.
# SPROMPT: Miss command prompt.
# RPROMPT: Right prompt
setopt prompt_subst
setopt re_match_pcre
setopt transient_rprompt
autoload -U colors
colors
case $OSTYPE in
    darwin*)
        PROMPT="%F{161}%n@%m:%% %f"
        PROMPT2="%F{039}%B>%b %f"
        SPROMPT="%F{202}correct: %R -> %r [n,y,a,e]? %f"
        RPROMPT="%F{105}[%~]%f"
        ;;
    solaris*)
        PROMPT="%F{1}%n@%m:%% %f"
        PROMPT2="%F{2}%B>%b %f"
        SPROMPT="%F{3}correct: %R -> %r [n,y,a,e]? %f"
        RPROMPT="%F{4}[%~]%f"
        ;;
    linux*)
        case $TERM in
            rxvt*)
                PROMPT="%F{161}%n@%m:%% %f"
                PROMPT2="%F{039}%B>%b %f"
                SPROMPT="%F{202}correct: %R -> %r [n,y,a,e]? %f"
                RPROMPT="%F{105}[%~]%f"
                ;;
            *)
                PROMPT="%F{1}%n@%m:%% %f"
                PROMPT2="%F{2}%B>%b %f"
                SPROMPT="%F{3}correct: %R -> %r [n,y,a,e]? %f"
                RPROMPT="%F{4}[%~]%f"
                ;;
        esac
        ;;
esac


# Others
setopt no_beep
setopt nolistbeep
bindkey -e
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Remove strings to '/' by Ctrl+w

# Only past commands beginning with the current input would have been shown.
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward


# aliases
alias octave='octave-cli -q'
alias R='R -q'
alias cl=clear
alias clang='clang -std=c11 -Wall -Wextra -Wconversion -Wno-unused-parameter -Wno-sign-compare -Wno-pointer-sign -Wcast-qual'
alias clang++='clang++ -std=c++1y -Wall -Wextra -Wconversion -Wno-unused-parameter -Wno-sign-compare -Wno-pointer-sign -Wcast-qual'
alias grep='grep --color=auto'
alias la='ls -ahF --color'
alias ll='ls -hlF --color'
alias ls='ls -hF --color'
alias od='od -tx1 -Ax'
alias xxd='xxd -a'
alias pdflatex='pdflatex -interaction=nonstopmode -halt-on-error'
alias aspell='aspell --lang=en -c -t'
alias objdump='objdump -M intel'
alias -g L='| less'
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'

if [[ -x "$(which colormake)" ]]; then
    # alias normal_make='make'
    # alias make='colormake'
    compdef _make colormake
fi

if [[ -x "$(which colordiff)" ]]; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi


# functions
function clean_vim() {
    rm -rf ~/.vim/view/*
    rm -rf ~/.vim/unite/*
    rm -rf ~/.vim/bundle/.neobundle/*
    rm -rf ~/.vim/vimfiler/*
    rm -rf ~/.vim/neocomplete/*
    rm ~/.viminfo
}

function reload_zshrc() {
    source ~/.zshrc
}

function man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

function calc() {
    echo $1 | bc
}

function dict() {
    grep "$1" ~/tmp/ejdic-hand-txt/ejdic-hand-utf8.txt -E -A 1 -wi --color
}

function urand() {
    od -vAn -N4 -tu4 < /dev/urandom | tail -n 1 | tr -d ' '
}

function rank_du() {
    du -s * | sort -nr
}

function switch_cc_cxx() {
    if [[ $CC == "clang" ]]; then
        export CC='gcc'
        export CXX='g++'
    else
        export CC='clang'
        export CXX='clang++'
    fi
}
