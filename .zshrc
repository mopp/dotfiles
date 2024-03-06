# vim:set foldmethod=marker:
export LANG=en_US.UTF-8
export XDG_HOME_CONFIG=$HOME/.config

# Define environment specific settings. {{{
case $OSTYPE in
    darwin*)
        # For homebrew.
        export path=(
            /opt/homebrew/opt/coreutils/libexec/gnubin
            /opt/homebrew/opt/llvm/bin
            $path
        )

        # For ruby-build
        export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

        if [ -d '/opt/homebrew/opt/llvm' ]; then
            export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
            export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
            export CC='clang'
            export CXX='clang++'
        fi

        file=/opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
        if [ -e $file ]; then
            source $file
        fi
        ;;
    linux*)
        file=/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
        if [ -e $file ]; then
            source $file
        fi

        export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"

        case $TERM in
            *rxvt*)
                stty -ixon      # Disable XON/XOFF flow control.
                stty stop undef # Disable terminal lock by <Ctrl-S>.
                ;;
        esac
        ;;
esac

# Disable man command highlight because of slow down.
# https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/27
FAST_HIGHLIGHT[chroma-man]=
# }}}

# Path. {{{
export GOPATH=$HOME/.local/go
export GOENV_GOPATH_PREFIX=$HOME/.local/go

export fpath=(~/.zfunc/ $fpath)

if (($+commands[go])); then
    export path=(
        $(go env GOPATH)/bin
        $path
    )
fi

export path=(
    $HOME/.local/bin
    $HOME/.cargo/bin
    $path
)

typeset -U PATH path
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

# External tool configurations. {{{
export ERL_AFLAGS="-kernel shell_history enabled"

if (($+commands[less])); then
    export PAGER=less
elif (($+commands[more])); then
    export PAGER=more
fi
export LESS='-R -f -X --tabs=4 --ignore-case --SILENT -P --LESS-- ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

(($+commands[anyenv])) && eval "$(anyenv init -)"
(($+commands[zoxide])) && eval "$(zoxide init zsh)"
(($+commands[kubectl])) && source <(kubectl completion zsh)
(($+commands[starship])) && eval "$(starship init zsh)"

if (($+commands[rustup])); then
    RUST_SYSROOT=$(rustc --print sysroot)
    export RUST_SRC_PATH=$RUST_SYSROOT/lib/rustlib/src/rust/src
    export LD_LIBRARY_PATH=$RUST_SYSROOT/lib:$LD_LIBRARY_PATH
fi

export TIME_STYLE='long-iso'
if (($+commands[eza])); then
    export EZA_COLORS='uu=38;5;221:gu=38;5;221:da=38;5;038'
    alias ls='eza --color-scale -gh --git'
    alias ll='eza --color-scale -gh --git -l'
    alias la='eza --color-scale -gh --git -a'
else
    alias ls='ls --color -hF'
    alias ll='ls --color -hFl'
    alias la='ls --color -hFa'
fi

if (($+commands[rg])); then
    alias grep='rg'
else
    alias grep='grep --color=auto'
fi

if (($+commands[bat])); then
    export BAT_THEME='Nord'
    alias cat='bat'
fi
# }}}

# Aliases. {{{
alias objdump='objdump -M intel'
alias od='od -tx1 -Ax'
alias xxd='xxd -a'
alias diff='diff -u'
alias date='date --iso-8601="seconds"'
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

function date_from_timestamp() {
    date --date="@$1" --iso-8601='seconds'
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

function kubexec {
    if [ "$#" -le 1 ]; then
        echo "usage: $0 <target> <command>"
        return 1
    fi

    pod_name=$(kubectl get pods --no-headers --selector app="$1" --output name | shuf --head-count=1)
    echo "$pod_name at $(kubens --current)"

    set -o xtrace
    kubectl exec --stdin=true --tty=true $pod_name --container="$1" -- ${@:2:($#-2)}
}

function kubeforward {
    if [ "$#" -le 1 ]; then
        echo "usage: $0 <ports> <target>"
        return 1
    fi

    set -o xtrace
    kubectl port-forward service/$2 $1
}

function kubevide() {
    if [ "$#" -le 0 ]; then
        echo "usage: $0 <target>"
        return 1
    fi

    kubeforward 6666:6666 "$1" &

    pod_name=$(kubectl get pods --no-headers --selector app="$1" --output name | shuf --head-count=1)

    set -o xtrace
    kubectl exec --stdin=false --tty=true $pod_name --container="$1" -- sh -c 'env SHELL=/usr/bin/zsh PATH=$HOME/.local/bin:$PATH nvim --headless --listen 0.0.0.0:6666' &

    sleep 5
    neovide --server=localhost:6666
}

function gitdargs {
    local -A opthash
    zparseopts -D -A opthash -- -pattern:

    if [ "$#" -le 0 ]; then
        echo "usage: $0 <option> <command>"
        echo "  example: $0 --pattern '*tsx' yarn pretter --write"
        return 1
    fi

    pattern="*"
    if [[ -n "${opthash[(i)--pattern]}" ]]; then
        pattern=$opthash[--pattern]
    fi

    $@ $(git diff --relative --name-only --diff-filter=M -z -- "${pattern}" | tr '\000' ' ')
}
# }}}

# Load a machine local scripts. {{{
# NOTE: the last `true` command makes the exit code successes (0).
[ -s $HOME/.zshrc_local ] && source $HOME/.zshrc_local || true
# }}}
