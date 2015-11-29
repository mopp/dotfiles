#---------------------------------------------------------------------------------------"
# 環境変数設定
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
#export LANG=ja_JP.UTF-8

HOSTNAME=$(hostname)
case $OSTYPE in
    solaris*)
        export TERM='rxvt'
        export PATH=/home/grd/m5191121/local.solaris/bin/:$PATH
        ;;
    darwin*)
        export PATH=/usr/texbin:$HOME/.mopp/bin:/usr/local/opt/ruby/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH
        export MANPATH=$HOME/.mopp/share/man:/usr/local/opt/coreutils/libexec/gnuman:/usr/local/share/man:$MANPATH
        export HOMEBREW_VERBOSE

        fpath=(/usr/local/share/zsh-completions $fpath)
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

        [[ -e $(alias run-help) ]] && unalias run-help
        autoload run-help
        export HELPDIR=/usr/local/share/zsh/helpfiles

        # export CC='clang-3.5'
        # export CXX='clang++-3.5 -stdlib=libc++'
        # export CXXFLAGS="${CXXFLAGS} -nostdinc++ -I/usr/local/lib/llvm-3.5/lib/c++/v1"
        # export LDFLAGS="${LDFLAGS} -L/usr/local/lib/llvm-3.5/usr/lib"

        alias eclipse='/Applications/eclipse/eclipse'
        ;;
    linux*)
        export CC='clang'
        export CXX='clang++'
        export JAVA_FONTS=/usr/share/fonts/TTF
        export MANPATH=/usr/local/share/man/:/usr/share/man/:$MANPATH
        if [[ -x $(which ruby) ]]; then
            export GEM_HOME=$(ruby -e 'print Gem.user_dir')
            export PATH=$GEM_HOME/bin/:$PATH
        fi

        case $HOSTNAME in
            flan)
                # https://wiki.archlinuxjp.org/index.php/VDPAU
                # export LIBVA_DRIVER_NAME=vdpau

                source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
                ;;
            rosetta)
                export TERM=xterm-256color
                ;;
        esac

        if grep '^fbterm' /proc/$PPID/cmdline > /dev/null; then
            export TERM=fbterm
        fi
        ;;
esac


case $TERM in
    *rxvt*)
        stty -ixon
        ;;
esac

# Remove duplicate
typeset -U PATH CDPATH FPATH MANPATH

export EDITOR=vim
export PAGER=less
export LESS='-R -f -X --LINE-NUMBERS --tabs=4 --ignore-case --SILENT -P --LESS-- ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'

# for Java
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

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
alias -g L='| less'
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
if [ -x "$(which colordiff)" ]; then
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
    if [[ $CC == "gcc" ]]; then
        export CC='clang'
        export CXX='clang++'
    else
        export CC='gcc'
        export CXX='g++'
    fi
}



### 補完 ###
zmodload zsh/mathfunc;
setopt auto_list            # 補完候補を一覧表示
setopt auto_menu            # <TAB>で補完候補切り替え
setopt list_packed          # 補完候補を詰めて表示
setopt list_types           # 補完候補にファイル種類表示
setopt auto_param_slash     # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt magic_equal_subst    # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
zstyle ':completion:*:default' menu select=2        # 補完候補での現在カーソル位置強調
zstyle ':completion:*' list-colors ''               # 補完候補に色付け
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字小文字無視
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:options' description 'yes'
autoload -U compinit;compinit

### Move ###
setopt auto_cd      # ディレクトリ名のみで移動
setopt auto_pushd   # cdで移動時もディレクトリスタックに追加

### History ###
HISTFILE=~/.zsh_history     # 履歴を保存するファイル
HISTSIZE=10000              # メモリ上の履歴数
SAVEHIST=$HISTSIZE          # 保存する履歴数
setopt inc_append_history   # すぐに履歴ファイルに追記
setopt hist_ignore_dups     # 履歴を重複させない
setopt hist_ignore_all_dups # コマンドが重複した時古い方を削除
setopt hist_reduce_blanks   # 余分な空白を削除し保存

### Prompt ###
# PROMPT :通常プロンプト
# PROMPT2:複数行入力時プロンプト
# SPROMPT:入力ミス確認プロンプト
# RPROMPT:右側に表示されるプロンプト
setopt prompt_subst         # プロンプト内で変数展開・コマンド置換・算術演算を実行
setopt re_match_pcre
setopt transient_rprompt    # コマンド実行後は右プロンプト消去
autoload -U colors; colors
case ${OSTYPE} in
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
        case ${TERM} in
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

### Others ###
setopt no_beep      # ビーブ音を鳴らさない
setopt nolistbeep   # 補完時にビーブ音を鳴らさない
bindkey -e          # emacsのキーバインド設定
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Ctrl+wで､直前の/までを削除する｡


# https://github.com/kmhjs/zslot.git
ZSLOT_SRC=~/Tools/zslot/src/
fpath=($ZSLOT_SRC $fpath)
autoload -Uz zslot
if [ -e $ZSLOT_SRC ]; then
    export ZUSER_SLOT_FILE_NAME=$HOME/.zslot_info
    export ZUSER_SLOT_MAX_SLOT_ID=9
    alias zs=zslot
    alias zss='zslot -s'
    alias zsp='zslot -p'
fi
