# vim:set foldmethod=marker shiftwidth=2:
#
# - Configuring Zsh Without Dependencies
#   - https://thevaluable.dev/zsh-install-configure-mouseless/
export LANG=en_US.UTF-8

# XDG Base Directory {{{
# - XDG Base Directory
#   - https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# }}}

path=($HOME/.local/bin $path)

stty -ixon      # Disable XON/XOFF flow control (Ctrl-Q)
stty stop undef # Disable terminal lock (Ctrl-S)

# $EDITOR {{{
if (($+commands[nvim])); then
  export EDITOR='nvim'
elif (($+commands[vim])); then
  export EDITOR='vim'
else
  export EDITOR='vi'
fi
# }}}

# Key bindings {{{
#
# References:
# - 18 Zsh Line Editor
#   - https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
# - Chapter 4: The Z-Shell Line Editor
#   - https://zsh.sourceforge.io/Guide/zshguide04.html
# - Editor Functions Index
#   - https://zsh.sourceforge.io/Doc/Release/Editor-Functions-Index.html
bindkey -v # Enable vi mode

bindkey '^A' beginning-of-line
bindkey '^B' backward-char
bindkey '^D' delete-char-or-list
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^K' kill-line

# Edit the current line using $EDITOR.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
# }}}

# History {{{
HISTFILE="$HOME/.zhistory"
HISTSIZE=4096
SAVEHIST=4096

# https://zsh.sourceforge.io/Doc/Release/Options.html#History
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS # Don't store function definitions.
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY # Append the history as soon as they are entered.

# Seach matched command in the history.
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-history_002dbeginning_002dsearch_002dbackward_002dend
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

bindkey "^R" history-incremental-pattern-search-backward
# }}}

# Completion {{{
# - A Guide to the Zsh Completion with Examples
#   - https://thevaluable.dev/zsh-completion-guide-examples/
autoload -Uz compinit
compinit

# Complete all unquoted arguments of the form ‘anything=expression’
setopt MAGIC_EQUAL_SUBST

bindkey '^[[Z' reverse-menu-complete # Reverse with Shift+Tab

# Enable more completers
zstyle ':completion:*' completer _extensions _complete _approximate

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle ':completion:*' menu select                  # Use menu selection style
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Ignore cases
zstyle ':completion:*' group-name ''                # Group by the type of the matched completions

zstyle ':completion:*:*:*:*:descriptions' format '%F{069}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections'  format '%F{069}-- %d (errors: %e) --%f' # For _approximate
zstyle ':completion:*:*:*:*:original'     format '%F{160}-- %d --%f'              # For _approximate
zstyle ':completion:*:messages'           format '%F{105}-- %d --%f'
zstyle ':completion:*:warnings'           format '%F{197}-- %BNo matches found%b%F{197} --%f'
# }}}

# Pager {{{
# cat, bat
if (($+commands[bat])); then
  alias cat='bat'
  export BAT_THEME='TwoDark'

  export PAGER='bat -plman'
elif (($+commands[less])); then
  export PAGER='less'
elif (($+commands[more])); then
  export PAGER='more'
fi

export LESS='-R -f -X --tabs=4 --ignore-case --SILENT -P --LESS-- ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'
# }}}

(($+commands[rustup])) && path=($HOME/.cargo/bin $path)
(($+commands[zoxide])) && eval "$(zoxide init zsh)"
(($+commands[starship])) && eval "$(starship init zsh)"
(($+commands[kubectl])) && source <(kubectl completion zsh)
(($+commands[anyenv])) && eval "$(anyenv init -)"

# ls, eza {{{
export TIME_STYLE=long-iso
if (($+commands[eza])); then
  alias eza='eza --color-scale'
  alias ls='eza'
  alias la='eza --all'
  alias ll='eza --all --long --binary --no-user --smart-group'
  alias lt='eza --all --long --binary --no-user --smart-group --sort=modified'
  alias tree='eza --all --tree --recurse'
else
  alias ls='ls --color -hF'
  alias ll='ls --color -hFl'
  alias la='ls --color -hFla'
  alias lt='ls --color -hFlat'
fi
# }}}

# grep, rg {{{
if (($+commands[rg])); then
  alias grep='rg'
else
  alias grep='grep --color=auto'
fi
# }}}

# diff, delta {{{
if (($+commands[delta])); then
  alias diff="delta"
else
  alias diff='diff -u'
fi
# }}}

# skim {{{
if (($+commands[sk])); then
  local -r sk_git='git ls-tree -r --name-only HEAD'
  local -r sk_find="find . -name '.' -or -type d -name '.*' -prune -or -type f -print | sort" # Ignore dot directly but show dot files.
  export SKIM_DEFAULT_COMMAND="$sk_git || $sk_find"

  export SKIM_DEFAULT_OPTIONS='--reverse --height 35% --border rounded --color catppuccin-mocha'

  # '^T' select from file
  # '^R' select from history
  source <(sk --shell zsh --shell-bindings)
  bindkey '^X^Q' skim-cd-widget

  # # Based on https://github.com/ajeetdsouza/zoxide/issues/228#issuecomment-1105726772
  function __local_cd_with_zoxide_by_sk() {
    cd $(zoxide query --list --score | awk '{print $2}' | sk --select-1)
    zle reset-prompt
  }
  zle -N __local_cd_with_zoxide_by_sk
  bindkey '^Q' __local_cd_with_zoxide_by_sk
fi
# }}}

alias objdump='objdump -M intel'
alias od='od -tx1 -Ax'
alias xxd='xxd -a'
alias date='date --iso-8601="seconds"'

# Elixir, Erlang/OTP
export ERL_AFLAGS="-kernel shell_history enabled"

# OS specific {{{
if [[ "$OSTYPE" == linux* ]]; then
  source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh &> /dev/null || true

  export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
else
  source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh &> /dev/null || true

  path=(/opt/homebrew/opt/rustup/bin $path)
fi
# }}}

# Print terminal colors
function print_term_colors() { # {{{
    for c ({000..255}) {
        echo -n "\e[38;5;${c}m $c";
        [ $(($c%16)) -eq 15 ] && echo
    }
}
# }}}

# Copy into the clipboard
function copy() { # {{{
    [ -p /dev/stdin ] && input='-' || input=$@

    case $OSTYPE in
        darwin*) cat $input | pbcopy ;;
        linux*)  cat $input | xclip -selection clipboard -i ;;
    esac
}
# }}}

# Copy the previous command into the clipboard
function copy_prev_cmd() { # {{{
    fc -ln -1 | copy
}
# }}}

# Load the machine local scripts.
# NOTE: the last `true` command makes the exit code successes (0).
source $HOME/.zshrc_local &> /dev/null || true
