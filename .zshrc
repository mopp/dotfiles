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
export XDG_HOME_CONFIG=$HOME/.config

case $OSTYPE in
    darwin*)
        export PATH=/usr/local/bin:$PATH
        export PATH=/usr/local/sbin:$PATH
        export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
        export PATH=/usr/local/opt/llvm/bin:$PATH
        export PATH=/usr/local/opt/make/libexec/gnubin:$PATH
        export MANPATH=/usr/local/share/man:$MANPATH
        export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
        export MANPATH=/usr/local/opt/make/libexec/gnuman:$MANPATH
        export LDFLAGS="-L/usr/local/opt/llvm/lib "$LDFLAGS
        export CPPFLAGS="-I/usr/local/opt/llvm/include "$CPPFLAGS

        # Setting for zsh completion and highlight.
        export FPATH=/usr/local/share/zsh-completions:$FPATH
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

        [[ -e $(alias run-help) ]] && unalias run-help
        autoload run-help
        export HELPDIR=/usr/local/share/zsh/helpfiles
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

export PATH=$HOME/.local/bin:$PATH

# Complement
autoload -Uz compinit
compinit -u
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
# setopt share_history

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


# For terminals.
case $TERM in
    *rxvt*)
        stty -ixon
        stty stop undef
        ;;
esac

# For Ruby.
if [[ -x $(which ruby) ]]; then
    export GEM_HOME=$(ruby -e 'print Gem.user_dir')
    export PATH=$GEM_HOME/bin:$PATH
fi

# For rbenv.
if [[ -d $HOME/.rbenv ]]; then
    export PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
fi

# For erlenv.
if [[ -d $HOME/.erlenv ]]; then
    export PATH=$HOME/.erlenv/bin:$PATH
    eval "$(erlenv init -)"
fi

# For nvm.
if [[ -x $(which nvm) ]]; then
    export NVM_DIR="$HOME/.nvm"
    source /usr/share/nvm/nvm.sh
    source /usr/share/nvm/install-nvm-exec
fi

# For cargo.
if [[ -d $HOME/.cargo/ ]]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi

# For rustup
if [[ -x $(which rustup) ]]; then
    CURRENT_TOOLCHAIN_NAME=$(rustup show | grep default | tail -n1 | cut -d' ' -f1)
    export RUST_SRC_PATH=~/.multirust/toolchains/${CURRENT_TOOLCHAIN_NAME}/lib/rustlib/src/rust/src
fi

if [[ -x $(which rustc) ]]; then
    export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH
fi

# For colormake.
if [[ -x "$(which colormake)" ]]; then
    alias maken='make'
    alias makec='colormake'
    compdef _make colormake
fi

# For colordiff.
if [[ -x "$(which colordiff)" ]]; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

# For EDITOR variable.
if [[ -x $(which nvim) ]]; then
    export EDITOR=nvim
elif [[ -x $(which vim) ]]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# For fasd
if [[ -x "$(which fasd)" ]]; then
    eval "$(fasd --init auto)"
fi

# For direnv
if [[ -x "$(which direnv)" ]]; then
    eval "$(direnv hook zsh)"
fi

# For less.
export PAGER=less
export LESS='-R -f -X --tabs=4 --ignore-case --SILENT -P --LESS-- ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'

# Aliases
alias grep='grep --color=auto'
alias la='ls -ahF --color'
alias ll='ls -hlF --color'
alias ls='ls -hF --color'
alias od='od -tx1 -Ax'
alias xxd='xxd -a'
alias objdump='objdump -M intel'
alias -g L='| less'
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'


# Remove duplicate in environment variables.
typeset -U PATH CDPATH FPATH MANPATH


# Functions
function clean_vim() {
    rm -rf ~/.vim/bundle/temp/
    rm -rf ~/.vim/bundle/.cache/init.vim/temp
    rm -rf ~/.local/share/nvim/
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

function conv_timestamp() {
    date --date="@$1" '+%Y/%m/%d %H:%M:%S'
}

function select_from_git_status() {
    files=($(git status --short | awk '{print $2}'))
    select answer in $files; do
        echo $answer
        break
    done
}

function open_from_git_status() {
    $EDITOR $(select_from_git_status)
}
