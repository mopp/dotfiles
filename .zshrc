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


export LANG=ja_JP.UTF-8

CLANG_OPTION='-Wall -Wextra -Winit-self -Wconversion -Wno-unused-parameter -Wwrite-strings -Wno-sign-compare -Wno-pointer-sign -Wno-missing-field-initializers -Wcast-qual -Wformat=2 -Wstrict-aliasing=2 -Wdisabled-optimization -Wfloat-equal -Wpointer-arith -Wbad-function-cast -Wcast-align -Wredundant-decls -Winline'

case ${OSTYPE} in
    darwin*)
        export ANDROID_HOME=$HOME/Tools/Android/sdk/tools:$HOME/Tools/Android/sdk/platform-tools
        export PATH=$ANDROID_HOME:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH
        export PATH=$HOME/.mopp/bin:/usr/local/opt/ruby/bin:$PATH
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
        alias gcc='/usr/local/bin/gcc-4.9 -Wall'
        alias g++='/usr/local/bin/g++-4.9 -Wall'
        alias clang="clang-3.5 -std=c11 ${CLANG_OPTION}"
        alias clang++="clang++-3.5 -std=c++11 ${CLANG_OPTION}"
        ;;
    linux*)
        case $(uname -n) in
            march*)
                export PATH=$HOME/.mopp/bin:$PATH
                export PATH=$HOME/.gem/ruby/2.0.0/bin:$PATH
                export PATH=$HOME/Tools/Android/android-sdk-linux/tools:$HOME/Tools/Android/android-sdk-linux/platform-tools:$PATH

                export MANPATH=$HOME/.mopp/share/man:$HOME/.mopp/cross/share/man:$MANPATH

                # export CC='clang'
                # export CXX='clang++'
                alias clang="clang -std=c11 ${CLANG_OPTION}"
                alias clang++="clang++ -std=c++11 ${CLANG_OPTION}"
                ;;
            mopuntu*)
                export CC='/usr/local/bin/clang'
                export CFLAGS='-I./ -I /usr/local/include/'
                export CXX='/usr/local/bin/clang++'
                export CXXFLAGS='-I./ -I/usr/local/include/c++/4.9.0/x86_64-linux-gnu/ -I/usr/local/include/c++/4.9.0/ -I/usr/local/include/ -I/usr/include/'
                export LDFLAGS='-L./ -L/usr/local/lib64/ -L/lib64/ -L/usr/lib/x86_64-linux-gnu/'
                export CPPFLAGS='-I./ -I/usr/local/include/c++/4.9.0/x86_64-linux-gnu/ -I/usr/local/include/c++/4.9.0/ -I/usr/local/include/ -I/usr/include/'

                #末尾にコロンを付けないこと
                export LIBRARY_PATH=/usr/local/libexec/gcc/x86_64-linux-gnu/4.9.0:/usr/local/lib64:/usr/local/lib32:/usr/local/lib/:/lib64/:/lib32/:/lib/
                export LD_LIBRARY_PATH=$LIBRARY_PATH
                export LD_RUN_PATH=$LIBRARY_PATH

                alias clang="clang -std=c11 ${CLANG_OPTION}"
                alias clang++="clang++ -std=c++11 ${CLANG_OPTION}"
                ;;
        esac
        ;;
esac

# 重複削除
typeset -U PATH CDPATH FPATH MANPATH

export EDITOR=vim
export PAGER=less
export LESS='-R -f -X --LINE-NUMBERS --tabs=4 --ignore-case --SILENT -P --LESS-- ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'

# for Java
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

alias cl=clear
alias clang++='clang++ -Wall'
alias grep='grep --color=auto'
alias la='ls -ahF --color'
alias ll='ls -hlF --color'
alias ls='ls -hF --color'


# functions
function vimman() {
    vim -c 'Ref man '$1 -c 'winc j' -c 'q'
}

function cleanVim() {
    rm -rf ~/.vim/view/*
    rm -rf ~/.vim/vimfiler/*
    rm -rf ~/.vim/neocomplete/*
    rm ~/.viminfo
}

function reload_zshrc() {
    source ~/.zshrc
}


### 補完 ###
autoload -U compinit
compinit -u
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
setopt no_beep              # ビーブ音を鳴らさない
setopt nolistbeep           # 補完時にビーブ音を鳴らさない
# setopt correct              # コマンド入力ミス修正
bindkey -e                  # emacsのキーバインド設定

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Ctrl+wで､直前の/までを削除する｡
