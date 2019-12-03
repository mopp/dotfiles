# vim:set foldmethod=marker:
export LANG=en_US.UTF-8
export XDG_HOME_CONFIG=$HOME/.config

# Define environment specific settings. {{{
case $OSTYPE in
    darwin*)
        # For homebrew.
        export path=(
            /usr/local/bin
            /usr/local/opt/coreutils/libexec/gnubin
            /usr/local/opt/gettext/bin
            /usr/local/opt/libiconv/bin
            /usr/local/opt/llvm/bin
            /usr/local/opt/make/libexec/gnubin
            /usr/local/opt/ncurses/bin
            $path
        )

        for e ('ncurses' 'gettext' 'libiconv' 'llvm') {
            export path=(/usr/local/opt/$e/bin $path);
            export LDFLAGS="-L/usr/local/opt/$e/lib $LDFLAGS";
            export CPPFLAGS="-I/usr/local/opt/$e/include $CPPFLAGS"
            export LD_LIBRARY_PATH="/usr/local/opt/$e/lib:$LD_LIBRARY_PATH"
        }

        export manpath=(
            /usr/local/opt/coreutils/libexec/gnumang
            /usr/local/opt/make/libexec/gnumang
            /usr/local/share/mang
            $manpath
        )

        export fpath=(/usr/local/share/zsh-completions $fpath)
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ;;
    linux*)
        source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

        case $TERM in
            *rxvt*)
                stty -ixon      # Disable XON/XOFF flow control.
                stty stop undef # Disable terminal lock by <Ctrl-S>.
                ;;
        esac
        ;;
esac

export fpath=(~/.zfunc/ $fpath)
# }}}

# Options. {{{
setopt null_glob
unsetopt beep
unsetopt listbeep

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;'
# }}}

# History. {{{
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
# }}}

# Complement {{{
autoload -Uz compinit
compinit

zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:messages' format '%F{003}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{196}No matches for:''%F{228} %d'$DEFAULT
# }}}

# Define EDITOR variable. {{{
# `bindkey` uses this setting.
if (($+commands[nvim])); then
    export EDITOR=nvim
elif (($+commands[vim])); then
    export EDITOR=vim
else
    export EDITOR=vi
fi
# }}}

# Initializations. {{{
if (($+commands[rustup])); then
    RUST_SYSROOT=$(rustc --print sysroot)
    export RUST_SRC_PATH=$RUST_SYSROOT/lib/rustlib/src/rust/src
    export LD_LIBRARY_PATH=$RUST_SYSROOT/lib:$LD_LIBRARY_PATH
fi

export GOENV_GOPATH_PREFIX=$HOME/.local/go

(($+commands[fasd]))   && eval "$(fasd --init auto)"
(($+commands[anyenv])) && eval "$(anyenv init -)"

export path=(
    $HOME/.local/bin
    $HOME/.cargo/bin
    $GOPATH/bin
    $path)
# }}}

# Commands. {{{
if (($+commands[exa])); then
    export EXA_COLORS='uu=38;5;221:gu=38;5;221:da=38;5;038'
    # export TIME_STYLE='long-iso'
    alias ls='exa --color-scale --time-style=long-iso -gh --git'
    alias ll='exa --color-scale --time-style=long-iso -gh --git -l'
    alias la='exa --color-scale --time-style=long-iso -gh --git -a'
    alias lla='exa --color-scale --time-style=long-iso -gh --git -la'
    alias lt='exa --color-scale --time-style=long-iso -gh --git -lT'
    alias lta='exa --color-scale --time-style=long-iso -gh --git -lTa'
else
    export TIME_STYLE='long-iso'
    alias ls='ls --color -hF'
    alias ll='ls --color -hFl'
    alias la='ls --color -hFa'
    alias lla='ls --color -hFal'
fi

if (($+commands[rg])); then
    alias grep='rg'
else
    alias grep='grep --color=auto'
fi

if (($+commands[colordiff])); then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

if (($+commands[kubectl])); then
    source <(kubectl completion zsh)
fi

export PAGER=less
export LESS='-R -f -X --tabs=4 --ignore-case --SILENT -P --LESS-- ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'
# }}}

# Aliases. {{{
alias -g H='| head'
alias -g L='| less'
alias -g M='| more'
alias -g T='| tail'
alias objdump='objdump -M intel'
alias od='od -tx1 -Ax'
alias xxd='xxd -a'

# http://d.hatena.ne.jp/se-kichi/20101017/1287341473
function extract() {
    case $1 in
        *.tar.gz|*.tgz) tar xzvf $1 ;;
        *.tar.xz) tar Jxvf $1 ;;
        *.zip) unzip $1 ;;
        *.lzh) lha e $1 ;;
        *.tar.bz2|*.tbz) tar xjvf $1 ;;
        *.tar.Z) tar zxvf $1 ;;
        *.gz) gzip -dc $1 ;;
        *.bz2) bzip2 -dc $1 ;;
        *.Z) uncompress $1 ;;
        *.tar) tar xvf $1 ;;
        *.arj) unarj $1 ;;
    esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
# }}}

# Prompts. {{{
autoload -Uz add-zsh-hook vcs_info

add-zsh-hook precmd () {
    prev_status_code=$(printf '%3d' $?)
    vcs_info
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{196}-%f'
zstyle ':vcs_info:git:*' stagedstr '%F{047}+%f'
zstyle ':vcs_info:git:*' formats '%F{146}[<%b>%u%c%F{146}]%f'
zstyle ':vcs_info:git:*' actionformats '[%b|%a]'

local newline=$'\n'
local mode_normal='%B%F{118}[NORMAL]%f%b'
local mode_insert='%B%F{039}[INSERT]%f%b'
PROMPT2='--%(!.#.>) '

function zle-keymap-select zle-line-init {
    [ $KEYMAP = 'vicmd' ] && mode=$mode_normal || mode=$mode_insert

    PROMPT="%F{251}[%D{%F %T}]$mode%F{197}[%n@%m]%F{%(?.046.196)}[exit: $prev_status_code]%F{110}[%~]$vcs_info_msg_0_$newline%B%F{203}%(!.#.>)%f%b "

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
# }}}

# Keybinds. {{{
autoload -Uz history-search-end edit-command-line
zle -N edit-command-line
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -v
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^P' history-beginning-search-backward-end
bindkey -M viins '^N' history-beginning-search-forward-end
bindkey -M viins "^R" history-incremental-pattern-search-backward
bindkey -M viins '^X^E' edit-command-line
bindkey -M viins '^[[Z' reverse-menu-complete
# }}}

# Functions. {{{
function print_term_colors() {
    for c ({000..255}) {
        echo -n "\e[38;5;${c}m $c";
        [ $(($c%16)) -eq 15 ] && echo
    }
}

function date_timestamp() {
    date --date="@$1" '+%Y/%m/%d %H:%M:%S'
}

function urand() {
    od -vAn -N4 -tu4 < /dev/urandom | tail -n 1 | tr -d ' '
}

function du_rank() {
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

function copy() {
    [ -p /dev/stdin ] && input='-' || input=$@

    case $OSTYPE in
        darwin*) cat $input | pbcopy ;;
        linux*)  cat $input | xclip -selection clipboard -i ;;
    esac
}

function copy_prev_cmd() {
    fc -ln -1 | copy
}
# }}}

# Load a machine local scripts. {{{
# NOTE: the last `true` command makes the exit code successes (0).
[ -s $HOME/.zshrc_local ] && source $HOME/.zshrc_local || true
# }}}
