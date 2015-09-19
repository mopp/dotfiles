" Vimrc By mopp :)
" __      __  _                              ____             __  __
" \ \    / / (_)                            |  _ \           |  \/  |
"  \ \  / /   _   _ __ ___    _ __    ___   | |_) |  _   _   | \  / | ___  _ __  _ __
"   \ \/ /   | | | '_ ` _ \  | '__|  / __|  |  _ <  | | | |  | |\/| |/ _ \| '_ \| '_ \
"    \  /    | | | | | | | | | |    | (__   | |_) | | |_| |  | |  | | (_) | |_) | |_) |
"     \/     |_| |_| |_| |_| |_|     \___|  |____/   \__, |  |_|  |_|\___/| .__/| .__/
"                                                     __/ |               | |   | |
"                                                    |___/                |_|   |_|
"---------------------------------------------------------------------------------------"

" バックアップファイルと一時ファイル設定
if isdirectory(expand('~/.vim/backup'))
    set backupdir=~/.vim/backup
    set directory=~/.vim/backup
endif
set backup
set writebackup     " 上書き前にバックアップ作成
set swapfile

" インデント設定
set backspace=2      " Backspaceの動作
set autoindent
set smartindent
set expandtab        " <Tab>の代わりに空白
set shiftwidth=4     " 自動インデントなどでずれる幅
set smarttab         " 行頭に<Tab>でshiftwidth分インデント
set softtabstop=4    " <Tab>, <BS>が対応する空白の数
set tabstop=4        " 画面上で<Tab>文字が占める幅
set formatoptions+=j " 行連結の時自動でコメント解除して連結

" エンコーディング関連
set encoding=utf-8                          " vim内部で通常使用する文字エンコーディング
set fileencodings=utf-8,sjis,cp932,euc-jp   " 既存ファイルを開く際の文字コード自動判別
set fileformats=unix,mac,dos                " 改行文字設定

" 検索と補完
set hlsearch            " 検索結果強調-:nohで解除
set incsearch           " インクリメンタルサーチを有効
set ignorecase          " 大文字小文字無視
set smartcase           " 大文字があれば通常の検索
set completeopt=menu    " 挿入モードでの補完設定
set wildmenu            " コマンドの補完候補を表示
let c = substitute($PWD, '[\r\|\n].*', '', 'g')
let &path = c . '/,' . c . '/include/,' . substitute($PATH, '/[a-zA-Z]*bin:', '/include/,', 'g')
unlet c
set cscopequickfix=s-,c-,d-,i-,t-,e-

" 折りたたみ
set foldenable
set foldcolumn=3            " 左側に折りたたみガイド表示
set foldmethod=indent       " 折畳の判別
set foldtext=Mopp_fold()    " 折りたたみ時の表示設定
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo " fold内に移動すれば自動で開く

" 履歴など
set history=500                 " コマンドの保存履歴数
set viminfo='1000,<500,f1       " viminfoへの保存設定
set viewoptions=cursor,folds    " :mkviewで保存する設定
if isdirectory(expand('~/.vim/undo'))
    set undodir=~/.vim/undo
    set undofile
endif

" その他
if !has('nvim')
    set clipboard=unnamed,autoselect
endif
set helplang=ja                 " ヘルプ検索で日本語を優先
set whichwrap=b,s,h,l,<,>,[,]   " カーソルを行頭、行末で止まらないようにする
set timeout                     " マッピングのタイムアウト有効
set timeoutlen=1000             " マッピングのタイムアウト時間
set ttimeoutlen=0               " キーコードのタイムアウト時間
set matchpairs+=<:>             " 括弧のハイライト追加
if !has('gui_running')
    set spelllang+=cjk              " 日本語などの文字をスペルミスとしない
endif
let g:loaded_2html_plugin  = 1  " 標準Pluginを読み込まない
let g:loaded_gzip          = 1
let g:loaded_netrwPlugin   = 1
let g:loaded_rrhelper      = 1
let g:loaded_tar           = 1
let g:loaded_tarPlugin     = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip           = 1
let g:loaded_zipPlugin     = 1

" 外観設定
set ambiwidth=double    " マルチバイト文字や記号でずれないようにする
set cmdheight=2         " コマンドラインの行数
set cursorline          " 現在行に下線表示
set laststatus=2        " ステータスラインを表示する時
set nowrap              " はみ出しの折り返し設定
set number              " 行番号表示
set ruler               " カーソルの現在地表示
set showcmd             " 入力中のコマンド表示
set showmatch           " 括弧強調
set showtabline=2       " タブバーを常に表示
set t_Co=256
set list
set listchars=tab:>\ ,trail:\|,extends:<,precedes:<
set statusline=%<%F\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}%=%l/%L,%c%V%8P
let g:lisp_rainbow     = 1
let g:lisp_instring    = 1
let g:lispsyntax_clisp = 1
let g:c_syntax_for_h   = 1
let g:tex_conceal      = ''


"-------------------------------------------------------------------------------"
" Functions
"-------------------------------------------------------------------------------"
function! Mopp_fold()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*', '', '')
    for i in range(&shiftwidth * v:foldlevel - 2)
        let line = '-' . line
    endfor
    let line = '+' . line

    let tail = printf('[ %2d Lines Lv%02d ] --- ', (v:foldend - v:foldstart + 1), v:foldlevel)

    let space_size = (winwidth(0) - &foldcolumn - strdisplaywidth(line . tail) - 1) - ((&number) ? max([&numberwidth, len(line('$'))]) : 0)

    return printf('%s%' . space_size . 'S%s', line, '', tail)
endfunction


function! Mopp_paste(register, paste_type, paste_cmd)
    let reg_type = getregtype(a:register)
    let store = getreg(a:register)
    call setreg(a:register, store, a:paste_type)
    exe 'normal "' . a:register . a:paste_cmd
    call setreg(a:register, store, reg_type)
endfunction


function! Mopp_copy_to_clipboard()
    silent execute "normal! '<,'>" '"*yy'
    let tmp = @*
    let @+ = tmp
endfunction


"-----------------------------------------------------------------------------------"
" Mappings                                                                          |
"-----------------------------------------------------------------------------------"
" コマンド        | ノーマル | 挿入 | コマンドライン | ビジュアル | 選択 | 演算待ち |
" map  / noremap  |    @     |  -   |       -        |     @      |  @   |    @     |
" nmap / nnoremap |    @     |  -   |       -        |     -      |  -   |    -     |
" vmap / vnoremap |    -     |  -   |       -        |     @      |  @   |    -     |
" omap / onoremap |    -     |  -   |       -        |     -      |  -   |    @     |
" xmap / xnoremap |    -     |  -   |       -        |     @      |  -   |    -     |
" smap / snoremap |    -     |  -   |       -        |     -      |  @   |    -     |
" map! / noremap! |    -     |  @   |       @        |     -      |  -   |    -     |
" imap / inoremap |    -     |  @   |       -        |     -      |  -   |    -     |
" cmap / cnoremap |    -     |  -   |       @        |     -      |  -   |    -     |
"-----------------------------------------------------------------------------------"

" Metaキーを有効化 Reference from http://d.hatena.ne.jp/thinca/20101215/1292340358
" if has('mac') && !has('gui_running')
"     for i in map( range(char2nr('a'), char2nr('z')) + range(char2nr('A'), char2nr('Z')) + range(char2nr('0'), char2nr('9')) , 'nr2char(v:val)')
"         execute 'set <M-'.i.'>='.i
"     endfor
" endif

let g:mapleader = ' '

" 矯正
inoremap <BS> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
noremap <BS> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>

inoremap <silent> jj <ESC>
noremap j gj
noremap k gk

" 移動
cnoremap <C-A> <Home>
noremap! <C-E> <End>
noremap! <C-F> <Right>
noremap! <C-B> <Left>
noremap! <C-D> <Del>
noremap! <M-f> <S-Right>
noremap! <M-b> <S-Left>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
noremap <C-J> G
noremap <C-K> gg
noremap <C-H> ^
noremap <C-L> $

" バッファ操作
noremap <silent> [B :<C-U>bfirst<CR>
noremap <silent> ]B :<C-U>blast<CR>
noremap <silent> [b :<C-U>bprevious<CR>
noremap <silent> ]b :<C-U>bnext<CR>

" Tab操作
noremap <Leader>to :tabnew<Space>
noremap <Leader>tc :tabclose<CR>
noremap <Leader>j gT
noremap <Leader>k gt

" 画面分割
noremap <Leader>sp :split<Space>
noremap <Leader>vsp :vsplit<Space>

" ロケーションリスト移動
nnoremap <silent> [o :lprevious<CR>
nnoremap <silent> ]o :lnext<CR>
nnoremap <silent> [O :<C-u>lfirst<CR>
nnoremap <silent> ]O :<C-u>llast<CR>

" Windowサイズ変更
noremap <silent> <S-Left>  :<C-U>wincmd <<CR>
noremap <silent> <S-Right> :<C-U>wincmd ><CR>
noremap <silent> <S-Up>    :<C-U>wincmd -<CR>
noremap <silent> <S-Down>  :<C-U>wincmd +<CR>

" <C-Space> で <NUL> が来るため
map <NUL> <C-Space>
map! <NUL> <C-Space>

" Yank & Paste
nnoremap Y y$
nnoremap <silent> <Leader>pp :set paste!<CR>
xnoremap <silent> <C-Space>  :<C-U>call Mopp_copy_to_clipboard()<CR>
nnoremap <silent> <Leader>lp :<C-U>call Mopp_paste(v:register, 'l', 'p')<CR>
nnoremap <silent> <Leader>lP :<C-U>call Mopp_paste(v:register, 'l', 'P')<CR>
nnoremap <silent> <Leader>cp :<C-U>call Mopp_paste(v:register, 'c', 'p')<CR>
nnoremap <silent> <Leader>cP :<C-U>call Mopp_paste(v:register, 'c', 'P')<CR>
nnoremap <silent> mlp :<C-U>call Mopp_paste('*', 'l', 'p')<CR>
nnoremap <silent> mlP :<C-U>call Mopp_paste('*', 'l', 'P')<CR>
nnoremap <silent> mcp :<C-U>call Mopp_paste('*', 'c', 'p')<CR>
nnoremap <silent> mcP :<C-U>call Mopp_paste('*', 'c', 'P')<CR>
nnoremap <silent> mp  :<C-U>call Mopp_paste('*', 'l', 'p')<CR>

" 入れ替え
noremap ; :
noremap : ;

" カーソル下のwordをhelpする
" nnoremap <silent> <Leader>h :vertical aboveleft help <C-R><C-W><CR>
nnoremap <silent> <Leader>h :help <C-R><C-W><CR>
nnoremap <silent> <Leader>ht :tab help <C-R><C-W><CR>

" カレントウィンドウのカレントディレクトリを変更
nnoremap <Leader>cd :lcd %:p:h<CR>

" 検索ハイライト消去
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" 空行を追加
nnoremap <silent> <CR> :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<CR>", v:count1)<CR>
" nnoremap <silent> <Leader>O   :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Space>O", v:count1)<CR>

" Tagが複数あればリスト表示
nnoremap <C-]> g<C-]>zz

" xでレジスタを汚さない
" nnoremap x "_x
" nnoremap X "_X

" マクロ
noremap Q @@

" http://vim-users.jp/2011/04/hack214/
onoremap ( t(
onoremap ) t)
onoremap ; t;
onoremap < t<
onoremap > t>
onoremap [ t[
onoremap ] t]

nnoremap <Leader>w :write<CR>


"-------------------------------------------------------------------------------"
" Commands
"-------------------------------------------------------------------------------"
command! -nargs=0 SpellCheckToggle :setlocal spell!

" カーソル位置のハイライト情報表示
command! -nargs=0 EchoHiID echomsg synIDattr(synID(line('.'), col('.'), 1), 'name')

function! s:to_bin(number)
    let map = {   '0' : '0000', '1' : '0001', '2' : '0010', '3' : '0011',
                \ '4' : '0100', '5' : '0101', '6' : '0110', '7' : '0111',
                \ '8' : '1000', '9' : '1001', 'a' : '1010', 'b' : '1011',
                \ 'c' : '1100', 'd' : '1101', 'e' : '1110', 'f' : '1111'
                \ }
    return join(map(split(printf('%x', a:number), '\zs'), 'map[v:val]'), ' ')
endfunction

" 式を実行させてその返り値を指定した基数の数値で出力する.
function! s:exp_conv(s, base) abort
    if a:s == ''
        return
    endif

    if !(a:base == 2 || a:base == 8 || a:base == 10 || a:base == 16)
        echoerr "Base is 2, 8, 10, 16 only."
        return
    endif

    " execute expression.
    execute 'let t =' a:s

    let num = str2nr(t, 10)
    let str = (a:base == 2) ? (s:to_bin(num)) : (printf(((a:base == 10) ? "%d" : ((a:base == 16) ? "0x%x" : "%o")), num))

    echomsg str
    return str
endfunction
command! -nargs=1 Bin call <SID>exp_conv(<f-args>, 2)
command! -nargs=1 Dec call <SID>exp_conv(<f-args>, 10)
command! -nargs=1 Hex call <SID>exp_conv(<f-args>, 16)
inoremap <silent><expr> <C-G>b <SID>exp_conv(input('= '),  2)
inoremap <silent><expr> <C-G>d <SID>exp_conv(input('= '), 10)
inoremap <silent><expr> <C-G>h <SID>exp_conv(input('= '), 16)
imap <C-G><C-B> <C-G>b
imap <C-G><C-H> <C-G>h

function! s:str2nr_possible(str)
    return (len(substitute(a:str, '\d*', '', 'g')) == 0 ) ? str2nr(a:str) : a:str
endfunction

function! s:tab_buffer(buf)
    let b = s:str2nr_possible(a:buf)

    if bufexists(b) == 0
        echoerr string(b) . ' NOT exists buffer'
        return
    endif

    silent execute 'tab sbuffer ' . b
endfunction
command! -nargs=1 -complete=buffer TabBuffer :call <SID>tab_buffer(<q-args>)

function! s:drop_buffer(buf)
    let b = s:str2nr_possible(a:buf)

    if type(b) == type(0)
        if bufexists(b) == 0
            echoerr 'Buffer ' . b . ' NOT exists.'
            return
        endif
        silent execute 'drop' expand('#' . b . ':p')
    else
        silent execute 'drop' b
    endif
endfunction
command! -nargs=1 -complete=file DropBuffer :call <SID>drop_buffer(<q-args>)


"-------------------------------------------------------------------------------"
" GUI
"-------------------------------------------------------------------------------"
if has('gui_running')
    " gm
    set guioptions-=e
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=l
    set guioptions-=L

    let no_buffers_menu = 1

    set mousehide
    set vb
    set t_vb=

    if has('mac')
        set macmeta
        set guifont=Ricty-Regular:h13
    else
        set guifont=Ricty\ 12
        set lines=40
        set columns=120
    endif
endif


"-------------------------------------------------------------------------------"
" autocmd.
"-------------------------------------------------------------------------------"
" Not depend on any plugin.
augroup noplugin
    autocmd!

    " .vimrc
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

    " 挿入モード解除時に自動でpasteをoff
    autocmd InsertLeave * setlocal nopaste

    " 状態の保存と復元
    autocmd BufWinLeave * if (bufname('%') != '') | silent mkview!  | endif
    autocmd BufWinEnter * if (bufname('%') != '') | silent! loadview | endif

    " git
    autocmd FileType git setlocal foldlevel=99

    " nask
    autocmd BufWinEnter *.nas nested setlocal filetype=nasm

    " json
    autocmd BufWinEnter *.json nested setlocal filetype=json

    " Arduino
    autocmd BufWinEnter *.pde,*.ino nested setlocal filetype=arduino

    " markdown
    autocmd BufWinEnter *.{md,mdwn,mkd,mkdn,mark*} nested setlocal filetype=markdown

    " gnuplot
    autocmd BufWinEnter *.plt nested setlocal filetype=gnuplot

    " Lisp
    autocmd FileType lisp setlocal nocindent nosmartindent lisp lispwords=define

    " Octave
    autocmd BufWinEnter *.m,*.oct setlocal filetype=octave

    " Enable wrap in text.
    autocmd BufWinEnter *.txt setlocal wrap

    " Tex
    autocmd BufWinEnter *.tex setlocal spell wrap

    " sh
    autocmd BufWinEnter *.sh setlocal filetype=sh
augroup END


"-------------------------------------------------------------------------------"
" neovim.
"-------------------------------------------------------------------------------"
" Copy and modify from mapping source in unite.vim
function! s:get_mapping_list(map_cmd) abort
    redir => mapping_str
    silent! execute a:map_cmd
    redir END

    let mapping_list = []
    let mapping_lines = split(mapping_str, '\n')
    let mapping_lines = filter(copy(mapping_lines), "v:val =~ '\\s\\+\\*\\?@'") + filter(copy(mapping_lines), "v:val !~ '\\s\\+\\*\\?@'")
    for line in map(mapping_lines, "substitute(v:val, '<NL>', '<C-J>', 'g')")
        " attribute
        let attr = ''

        " right
        let map_rhs = matchstr(line, '^\a*\s*\S\+\s*\zs.*\ze\s*')
        if map_rhs =~ '^\*\s.*'
            let map_rhs = map_rhs[2:]
            let attr = '*'
        endif

        " left
        let map_lhs = matchstr(line, '^\a*\s*\zs\S\+')
        if map_lhs =~ '^<SNR>' || map_lhs =~ '^<Plug>'
            continue
        endif
        let map_lhs = substitute(map_lhs, '<NL>', '<C-j>', 'g')
        let map_lhs = substitute(map_lhs, '\(<.*>\)', '\1', 'g')

        call add(mapping_list, [map_lhs, map_rhs, attr])
    endfor

    return mapping_list
endfunction

if has('nvim')
    set wildmode=full

    let s:is_term_map_enable = 1
    function! s:toggle_terminal_map() abort
        if s:is_term_map_enable == 1
            let g:toggle_mapinfo_list = <SID>get_mapping_list('tmap')
            " Disable
            for mapinfo in g:toggle_mapinfo_list
                echo mapinfo[0]
                execute 'tunmap' mapinfo[0]
            endfor
            let s:is_term_map_enable = 0
        else
            " Enable
            for mapinfo in g:toggle_mapinfo_list
                let map_cmd = (mapinfo[2] == '*') ? ('tnoremap') : ('tmap')
                execute map_cmd mapinfo[0] mapinfo[1]
            endfor
            let s:is_term_map_enable = 1
        endif
    endfunction

    command! -nargs=0 ToggleTerminaMap call <SID>toggle_terminal_map()

    tnoremap <ESC> <C-\><C-n>
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l
    nnoremap <Leader>tm :terminal
    nnoremap <Leader>vst :vsplit term://zsh<CR>
endif


"-------------------------------------------------------------------------------"
" Plugin
"-------------------------------------------------------------------------------"
" neobundleが存在しない場合これ以降を読み込まない
if !isdirectory(expand('~/.vim/bundle/neobundle.vim'))
    syntax enable
    colorscheme desert
    finish
endif

" Neobundle
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin()

" NeoBundle 'ap/vim-css-color'
" NeoBundle 'kyuhi/vim-emoji-complete'
" NeoBundleLazy 'taku-o/vim-copypath', {  'commands'  : ['CopyFileName', 'CopyPath'] }

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Shougo/vimproc.vim', { 'build' : { 'mac' : 'make -f make_mac.mak', 'linux' : 'make' } }
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'luochen1990/rainbow'
NeoBundle 'mopp/mopbuf.vim'
NeoBundle 'mopp/mopkai.vim'
NeoBundle 'mopp/smartnumber.vim'
NeoBundle 'sudo.vim'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'tpope/vim-repeat'

NeoBundleLazy 'FooSoft/vim-argwrap', { 'function_prefix' : 'argwrap' }
NeoBundleLazy 'Shougo/deoplete.nvim', { 'depends' : 'Shougo/neosnippet', 'insert' : 1, 'disabled' : (!has('nvim')) }
NeoBundleLazy 'Shougo/neocomplete.vim', { 'depends' : 'Shougo/neosnippet', 'insert' : 1, 'disabled' : (!has('lua')) }
NeoBundleLazy 'Shougo/neosnippet', { 'depends' : [ 'honza/vim-snippets', 'Shougo/neosnippet-snippets' ], 'unite_sources' : [ 'neosnippet/runtime', 'neosnippet/user', 'snippet' ] }
NeoBundleLazy 'Shougo/neosnippet-snippets'
NeoBundleLazy 'Shougo/vimfiler', { 'depends' : 'Shougo/unite.vim', 'function_prefix' : 'vimfiler', 'commands' : { 'name' : ['VimFiler', 'VimFilerTab', 'VimFilerBufferDir', 'VimFilerCreate' ], 'complete' : 'customlist,vimfiler#complete' }, 'explorer' : 1 }
NeoBundleLazy 'Shougo/vinarise', { 'commands' : 'Vinarise' }
NeoBundleLazy 'honza/vim-snippets'
NeoBundleLazy 'idanarye/vim-casetrate', { 'commands' : [ { 'name' : 'Casetrate', 'complete' : 'customlist,casetrate#completeCases' } ] }
NeoBundleLazy 'kana/vim-niceblock', { 'mappings' : [ ['v', 'I', 'A'] ] }
NeoBundleLazy 'kana/vim-smartchr', { 'insert': 1 }
NeoBundleLazy 'kana/vim-smartinput', { 'insert': 1 }
NeoBundleLazy 'kannokanno/previm', { 'commands' : 'PrevimOpen', 'filetypes' : 'markdown' }
NeoBundleLazy 'koron/nyancat-vim', { 'commands' : [ 'Nyancat', 'Nyancat2',] }
NeoBundleLazy 'majutsushi/tagbar', { 'commands' : 'TagbarToggle' }
NeoBundleLazy 'mattn/benchvimrc-vim', { 'commands' : 'BenchVimrc' }
NeoBundleLazy 'mattn/gist-vim', { 'depends' : 'mattn/webapi-vim', 'commands' : 'Gist' }
NeoBundleLazy 'mattn/learn-vimscript'
NeoBundleLazy 'mattn/webapi-vim', { 'function_prefix' : 'webapi' }
NeoBundleLazy 'mopp/DoxyDoc.vim', { 'commands' : [ 'DoxyDoc', 'DoxyDocAuthor' ] }
NeoBundleLazy 'mopp/autodirmake.vim', { 'insert': 1 }
NeoBundleLazy 'mopp/battery.vim', { 'insert': 1 }
NeoBundleLazy 'mopp/layoutplugin.vim', { 'commands' : 'LayoutPlugin' }
NeoBundleLazy 'mopp/makecomp.vim', { 'commands' : [ { 'name' : 'Make', 'complete' : 'customlist,makecomp#get_make_argument' } ] }
NeoBundleLazy 'mopp/marker.vim', { 'mappings' : [ [ 'n', '<Plug>(Marker-auto_mark)' ] ] }
NeoBundleLazy 'mopp/next-alter.vim', { 'commands' : 'OpenNAlter', 'mappings'  : [ ['n', '<Plug>(next-alter-open)'] ] }
NeoBundleLazy 'mopp/openvimrc.vim' , { 'mappings' : [ [ 'n', '<Plug>(openvimrc-open)' ] ] }
NeoBundleLazy 'mopp/tailCleaner.vim', { 'insert': 1 }
NeoBundleLazy 'osyo-manga/vim-anzu', { 'mappings' : [ [ 'n', '<Plug>'] ] }
NeoBundleLazy 'osyo-manga/vim-marching'
NeoBundleLazy 'osyo-manga/vim-stargate', { 'commands' : [ { 'name' : 'StargateInclude', 'complete' : 'customlist,stargate#command_complete' } ] }
NeoBundleLazy 'rhysd/vim-clang-format', { 'commands' : [ 'ClangFormat', 'ClangFormatEchoFormattedCode' ] }
NeoBundleLazy 'scrooloose/nerdcommenter', { 'mappings' : [ [ 'nx', '<Plug>NERDCommenter' ] ] }
NeoBundleLazy 'scrooloose/syntastic', { 'insert': 1 }
NeoBundleLazy 'sk1418/blockit', { 'commands' : 'Block', 'mappings' : [ ['v', '<Plug>BlockitVisual'] ] }
NeoBundleLazy 'taichouchou2/alpaca_english', { 'stay_same' : 1, 'build' : { 'mac' : 'rm Gemfile.lock && bundle', 'linux' : 'rm Gemfile.lock && bundle' }, 'unite_sources' : [ 'english_dictionary', 'english_example', 'english_thesaurus' ] }
NeoBundleLazy 'thinca/vim-ft-help_fold', { 'commands' : 'help' }
NeoBundleLazy 'tyru/open-browser.vim', { 'mappings' : [ [ 'n', '<Plug>(openbrowser-open)' ] ], 'function_prefix' : 'openbrowser' }
NeoBundleLazy 'ujihisa/neco-look'

" NeoBundleLazy 'Nemo157/scala.vim', { 'filetypes' : 'scala' }
" NeoBundleLazy 'adimit/prolog.vim', { 'filetypes' : 'prolog' }
" NeoBundleLazy 'ahayman/vim-nodejs-complete', { 'insert' : 1, 'filetypes' : ['javascript'] }
" NeoBundleLazy 'awk.vim', { 'filetypes' : 'awk' }
" NeoBundleLazy 'elzr/vim-json', { 'filetypes' : 'json' }
" NeoBundleLazy 'gnuplot.vim', { 'filetypes' : 'gnuplot' }
" NeoBundleLazy 'jelera/vim-javascript-syntax', { 'filetypes' : ['javascript'] }
" NeoBundleLazy 'jiangmiao/simple-javascript-indenter', { 'filetypes' : 'javascript' }
" NeoBundleLazy 'mips.vim', { 'filetypes' : 'mips' }
" NeoBundleLazy 'othree/html5.vim', { 'filetypes' : [ 'eruby', 'html' ] }
" NeoBundleLazy 'verilog.vim', { 'filetypes' : 'verilog' }
" NeoBundleLazy 'vim-scripts/Arduino-syntax-file', { 'filetypes' : 'arduino' }
NeoBundleLazy 'mopp/rik_octave.vim', { 'filetypes' : 'octave' }
NeoBundleLazy 'plasticboy/vim-markdown', { 'filetypes' : 'markdown' }
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'filetypes' : 'ruby' }
NeoBundleLazy 'vim-jp/cpp-vim', { 'filetypes' : [ 'c', 'cpp' ] }
NeoBundleLazy 'vim-jp/vimdoc-ja'
NeoBundleLazy 'vim-ruby/vim-ruby', { 'filetypes' : 'ruby' }
NeoBundleLazy 'vim-scripts/sh.vim--Cla', { 'filetypes' : [ 'zsh', 'sh', 'bash'] }
NeoBundleLazy 'rust-lang/rust.vim', { 'filetypes' : 'rust' }

NeoBundleLazy 'bbchung/clighter', { 'filetypes' : [ 'c', 'cpp' ] }
NeoBundleLazy 'yuratomo/java-api-complete', { 'filetypes' : 'java' }

NeoBundleLazy 'rhysd/vim-operator-surround', { 'mappings' : [ [ 'n', '<Plug>' ] ] }
NeoBundleLazy 'kana/vim-operator-replace', { 'mappings' : [ [ 'nv', '<Plug>(operator-replace)' ] ] }
NeoBundleLazy 'kana/vim-operator-user', { 'function_prefix' : 'operator' }

NeoBundleLazy 'kana/vim-textobj-function', { 'mappings' : [ [ 'ov', '<Plug>' ] ] }
NeoBundleLazy 'kana/vim-textobj-indent', { 'mappings' :  [ [ 'ov', 'ai' , 'ii' , 'aI',  'iI' ] ] }
NeoBundleLazy 'kana/vim-textobj-line', { 'mappings' : [ [ 'ov', '<Plug>' ] ] }
NeoBundleLazy 'kana/vim-textobj-user', { 'function_prefix' : 'textobj' }
NeoBundleLazy 'osyo-manga/vim-textobj-multiblock', { 'mappings' : [ [ 'ov', '<Plug>' ] ] }
NeoBundleLazy 'osyo-manga/vim-textobj-multitextobj', { 'mappings' : [ [ 'ov', '<Plug>(textobj-multitextobj-A', '<Plug>(textobj-multitextobj-B', '<Plug>(textobj-multitextobj-C', '<Plug>(textobj-multitextobj-D', '<Plug>(textobj-multitextobj-E' ] ] }
NeoBundleLazy 'rhysd/vim-textobj-wiw', { 'mappings' : [ [ 'ov', '<Plug>' ] ] }
NeoBundleLazy 'rhysd/vim-textobj-word-column', { 'mappings' : [ [ 'ov', 'av', 'iv' ] ] }
NeoBundleLazy 'sgur/vim-textobj-parameter', { 'mappings' : [ [ 'ov', '<Plug>' ] ]}
NeoBundleLazy 'terryma/vim-expand-region', { 'mappings' : [ [ 'ov', '<Plug>' ] ] }

NeoBundleLazy 'Shougo/neomru.vim', { 'unite_sources' : 'file_mru' }
NeoBundleLazy 'Shougo/unite-outline', { 'unite_sources' : 'outline' }
NeoBundleLazy 'Shougo/unite.vim', { 'commands' : [ { 'name' : 'Unite', 'complete' : 'customlist,unite#complete_source'} ], 'function_prefix' : 'unite' }
NeoBundleLazy 'junkblocker/unite-tasklist', { 'unite_sources' : 'tasklist' }
NeoBundleLazy 'kmnk/vim-unite-giti', { 'unite_sources' : [ 'giti', 'giti/branch', 'giti/branch_all', 'giti/config', 'giti/log', 'giti/remote', 'giti/status' ] }
NeoBundleLazy 'lambdalisue/unite-grep-vcs', { 'unite_sources' : ['grep/git', 'grep/hg'] }
NeoBundleLazy 'osyo-manga/unite-quickfix', { 'unite_sources' : 'quickfix' }
NeoBundleLazy 'tsukkee/unite-tag', { 'unite_sources' : [ 'tag', 'tag/file', 'tag/include' ] }

call neobundle#end()

filetype plugin indent on

if !has('vim_starting')
    call neobundle#call_hook('on_source')
endif

" Unite
function! s:unite_smart_grep()
    if unite#sources#grep_git#is_available()
        Unite grep/git:. -buffer-name=search-buffer
    elseif unite#sources#grep_hg#is_available()
        Unite grep/hg:. -buffer-name=search-buffer
    else
        Unite grep:. -buffer-name=search-buffer
    endif
endfunction
nnoremap [Unite] <Nop>
nmap <Leader>f [Unite]
nnoremap <silent> [Unite]re      :<C-u>UniteResume<CR>
nnoremap <silent> [Unite]f       :<C-u>Unite -buffer-name=Files file_rec/async:!<CR>
nnoremap <silent> [Unite]s       :<C-u>Unite -buffer-name=Sources source<CR>
nnoremap <silent> [Unite]gi      :<C-u>Unite -buffer-name=Giti giti<CR>
nnoremap <silent> [Unite]gg      :<C-u>call <SID>unite_smart_grep()<CR>
nnoremap <silent> [Unite]o       :<C-u>Unite -buffer-name=Outlines outline<CR>
nnoremap <silent> [Unite]l       :<C-u>Unite -buffer-name=Lines line<CR>
nnoremap <silent> [Unite]t       :<C-u>Unite -buffer-name=TaskList tasklist<CR>
nnoremap <silent> [Unite]q       :<C-u>Unite -buffer-name=QuickFix quickfix -no-quit -direction=botright<CR>
let g:unite_quickfix_is_multiline = 0
let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
    let g:unite_data_directory = expand('~/.vim/unite')
    let g:unite_source_file_mru_limit = 50
    let g:unite_cursor_line_highlight = 'TabLineSel'
    let g:unite_enable_short_source_names = 1
    let g:unite_source_history_yank_enable = 1
    let g:unite_force_overwrite_statusline = 0
    let g:unite_source_grep_max_candidates = 200
    let g:unite_source_bookmark_directory = expand('~/.vim/bookmark')
    if executable('pt')
        " for the platinum searcher
        let g:unite_source_grep_command = 'pt'
        let g:unite_source_grep_default_opts = '--nogroup --nocolor'
        let g:unite_source_grep_recursive_opt = ''
        let g:unite_source_grep_encoding = 'utf-8'
    elseif executable('ag')
        " for the silver searcher
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts = '-i --line-numbers --nocolor --nogroup --hidden --ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
        let g:unite_source_grep_max_candidates = 200
    endif
endfunction
function! s:on_exe_unite()
    imap <buffer> <TAB> <Plug>(unite_select_next_line)
    imap <buffer> jj <Plug>(unite_insert_leave)
    nmap <buffer> ' <Plug>(unite_quick_match_default_action)
    nmap <buffer> x <Plug>(unite_quick_match_choose_action)
    nmap <buffer> <C-z> <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-z> <Plug>(unite_toggle_transpose_window)
    nmap <buffer> <C-j> <Plug>(unite_toggle_auto_preview)
    nnoremap <buffer><expr> l unite#smart_map('l', unite#do_action('default'))
    nnoremap <buffer><expr> <C-t> unite#do_action('tabopen')
endfunction

function! s:load_complement_sources() abort
    if &filetype =~? 'c\|cpp'
        NeoBundleSource vim-marching
    endif

    if has('ruby')
        let g:alpaca_english_enable = 1
        NeoBundleSource alpaca_english
    else
        NeoBundleSource neco-look
    endif
endfunction

" Deoplete
let s:hooks = neobundle#get_hooks('deoplete.nvim')
function! s:hooks.on_source(bundle)
    let g:deoplete#enable_at_startup            = 1
    let g:deoplete#enable_ignore_case           = 0
    let g:deoplete#enable_smart_case            = 1
    let g:deoplete#auto_completion_start_length = 3
endfunction
function! s:hooks.on_post_source(bundle)
    call s:load_complement_sources()
endfunction

" neocomplete
let s:hooks = neobundle#get_hooks('neocomplete.vim')
function! s:hooks.on_source(bundle)
    let g:neocomplete#enable_at_startup            = 1
    let g:neocomplete#auto_completion_start_length = 3
    let g:neocomplete#min_keyword_length           = 3
    let g:neocomplete#enable_ignore_case           = 0
    let g:neocomplete#enable_smart_case            = 1
    let g:neocomplete#enable_cursor_hold_i         = 1
    let g:neocomplete#enable_insert_char_pre       = 1
    let g:neocomplete#enable_auto_delimiter        = 1
    let g:neocomplete#lock_buffer_name_pattern     = '^zsh.*'
    let g:neocomplete#data_directory               = expand('~/.vim/neocomplete')
    let g:neocomplete#enable_prefetch              = 1

    " 外部オムニ補完関数を直接呼び出す
    let g:neocomplete#force_overwrite_completefunc     = 1
    let g:neocomplete#force_omni_input_patterns        = get(g:, 'neocomplete#force_omni_input_patterns', {})
    let g:neocomplete#force_omni_input_patterns.c      = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#force_omni_input_patterns.cpp    = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#force_omni_input_patterns.objc   = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#force_omni_input_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#force_omni_input_patterns.ruby   = '[^. *\t]\.\w*\|\h\w*::'
    " 数字記号類以外の後に.か->が来た場合に補完実行する

    " 補完時に参照する他のfiletype
    let g:neocomplete#same_filetypes = get(g:, 'neocomplete#same_filetypes', {})
    let g:neocomplete#same_filetypes.c = 'cpp'
    let g:neocomplete#same_filetypes.cpp = 'c'

    " 英単語補完用に以下のfiletypeをtextと同様に扱う
    let g:neocomplete#text_mode_filetypes = get(g:, 'neocomplete#text_mode_filetypes', {})
    let g:neocomplete#text_mode_filetypes.markdown = 1
    let g:neocomplete#text_mode_filetypes.gitcommit = 1
    let g:neocomplete#text_mode_filetypes.text = 1
    let g:neocomplete#text_mode_filetypes.txt = 1

    let g:neocomplete#delimiter_patterns = get(g:, 'neocomplete#delimiter_patterns', {})
    let g:neocomplete#delimiter_patterns.vim = [ '#', '.' ]
    let g:neocomplete#delimiter_patterns.cpp = [ '::' ]
    let g:neocomplete#delimiter_patterns.c = [ '.' ]

    let g:neocomplete#skip_auto_completion_time = ''
    let g:neocomplete#fallback_mappings = ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]

    " neocompleteが呼び出すオムニ補完関数名
    let g:neocomplete#sources#omni#functions = get(g:, 'neocomplete#sources#omni#functions', {})
    let g:neocomplete#sources#omni#functions.java = 'javaapi#complete'
    let g:neocomplete#sources#omni#functions.javascript = 'javascriptcomplete#CompleteJS'

    " オムニ補完関数呼び出し時の条件
    let g:neocomplete#sources#omni#input_patterns = get(g:, 'neocomplete#sources#omni#input_patterns', {})
    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
    let g:neocomplete#sources#omni#input_patterns.java = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.javascript = '[^.[:digit:] *\t]\.'

    " コマンドの引数補完時に呼び出される
    let g:neocomplete#sources#vim#complete_functions = get(g:, 'neocomplete#sources#vim#complete_functions', {})
    let g:neocomplete#sources#vim#complete_functions.Ref = 'ref#complete'
    let g:neocomplete#sources#vim#complete_functions.Unite = 'unite#complete_source'
    let g:neocomplete#sources#vim#complete_functions.VimFiler = 'vimfiler#complete'
    let g:neocomplete#sources#vim#complete_functions.Vinarise = 'vinarise#complete'

    imap <C-g><C-q> <Plug>(neocomplete_start_unite_quick_match)
    imap <C-g><C-u> <Plug>(neocomplete_start_unite_complete)
    inoremap <expr> <C-g><C-c> neocomplete#undo_completion()
    inoremap <expr> <C-l> neocomplete#complete_common_string()
endfunction

function! s:hooks.on_post_source(bundle)
    call s:load_complement_sources()
endfunction

" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
set conceallevel=2 concealcursor=i
let g:neosnippet#snippets_directory = '~/.vim/bundle/neosnippet-snippets/neosnippets/,~/.vim/bundle/vim-snippets/snippets'

function! s:check_clang()
    for t in ['clang-3.5', 'clang-3.4', 'clang']
        if executable(t)
            return t
        endif
    endfor

    echomsg 'Clang is NOT found.'
    return ''
endfunction

" marching
let s:hooks = neobundle#get_hooks('vim-marching')
function! s:hooks.on_source(bundle)
    let clang_exe = s:check_clang()
    if clang_exe == ''
        return
    endif

    " systemの戻り値に注意
    let g:marching_clang_command = substitute(system('where '.clang_exe), '[\r\|\n].*', '', 'g')
    let g:marching_clang_command_option = ''
    let g:marching_enable_neocomplete = 1
    let g:marching_debug = 1
    let g:marching_include_paths = split(&path, ',')
    let g:marching#clang_command#options = { 'cpp' : '-Wall -std=gnu++1y', 'c' : '-Wall -std=c11' }

    set updatetime=500
endfunction

" clang-format
let s:hooks = neobundle#get_hooks('vim-clang-format')
function! s:hooks.on_source(bundle)
    let g:clang_format#auto_format_on_insert_leave = 0
    let g:clang_format#auto_formatexpr = 1
    let g:clang_format#style_options = {
                \ 'AccessModifierOffset'                : -4,
                \ 'AlignTrailingComments'               : 'true',
                \ 'AllowShortFunctionsOnASingleLine'    : 'false',
                \ 'AllowShortIfStatementsOnASingleLine' : 'false',
                \ 'AllowShortLoopsOnASingleLine'        : 'false',
                \ 'AlwaysBreakTemplateDeclarations'     : 'true',
                \ 'BinPackParameters'                   : 'false',
                \ 'BreakBeforeBraces'                   : 'Linux',
                \ 'ColumnLimit'                         : '0',
                \ 'IndentCaseLabels'                    : 'true',
                \ 'MaxEmptyLinesToKeep'                 : '3',
                \ 'PointerBindsToType'                  : 'true',
                \ 'Standard'                            : 'Auto',
                \ 'TabWidth'                            : '4',
                \ 'UseTab'                              : 'Never',
                \ 'IndentWidth'                         : '4',
                \ }

    for t in [ 'clang-format-3.5', 'clang-format-3.4', 'clang-format' ]
        if executable(t)
            let g:clang_format#command = t
            break
        endif
    endfor
endfunction

" easymotion
let g:EasyMotion_leader_key = '<Leader>e'

" NERDCommenter
let g:NERDSpaceDelims = 1
nmap <Leader><Leader> <Plug>NERDCommenterToggle
vmap <Leader><Leader> <Plug>NERDCommenterNested
nmap <Leader>cs <plug>NERDCommenterSexy
let s:hooks = neobundle#get_hooks('nerdcommenter')
function! s:hooks.on_post_source(bundle)
    doautocmd NERDCommenter BufEnter
endfunction

" VimFiler
nnoremap <silent> fvs :VimFilerExplorer<CR>
nnoremap <silent> fvb :VimFilerBufferDir -explorer<CR>
nnoremap <silent> fvo :VimFilerTab<CR>
nnoremap <silent> fvc :VimFilerCreate<CR>
let s:hooks = neobundle#get_hooks('vimfiler')
function! s:hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_data_directory = expand('~/.vim/vimfiler')
    let g:vimfiler_force_overwrite_statusline = 0
    call vimfiler#custom#profile('default', 'context', { 'safe' : 0, })
endfunction
function! s:config_vimfiler()
    unmap <buffer> <Space>
    nmap <buffer> : <Plug>(vimfiler_toggle_mark_current_line)
    nmap <buffer> <C-H> <Plug>(vimfiler_switch_to_parent_directory)
    vmap <buffer> : <Plug>(vimfiler_toggle_mark_selected_lines)
    nnoremap <silent><buffer><expr> <C-t> vimfiler#do_action('tabopen')
    nnoremap <silent><buffer><expr> <C-b> vimfiler#do_action('bookmark')
endfunction

" TagBar
let g:tagbar_width = 35
let g:tagbar_autoshowtag = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
nnoremap <silent> <Leader>tb :<C-U>TagbarToggle<CR>

" Smartinput
let s:hooks = neobundle#get_hooks('vim-smartinput')
function! s:hooks.on_source(bundle)
    call smartinput#map_to_trigger('i', '<Space>', '<Space>', '<Space>')
    call smartinput#define_rule({ 'char' : '<Space>', 'at' : '(\%#)', 'input' : '<Space><Space><Left>'})

    let lst = [   ['<',     "smartchr#loop(' < ', ' << ', '<')" ],
                \ ['>',     "smartchr#loop(' > ', ' >> ', ' >>> ', '>')"],
                \ ['+',     "smartchr#loop(' + ', '++', '+')"],
                \ ['-',     "smartchr#loop(' - ', '--', '-')"],
                \ ['/',     "smartchr#loop(' / ', '//', '/')"],
                \ ['&',     "smartchr#loop(' & ', ' && ', '&')"],
                \ ['%',     "smartchr#loop(' % ', '%')"],
                \ ['*',     "smartchr#loop(' * ', '*')"],
                \ ['<Bar>', "smartchr#loop(' | ', ' || ', '|')"],
                \ [',',     "smartchr#loop(', ', ',')"]]

    for i in lst
        call smartinput#map_to_trigger('i', i[0], i[0], i[0])
        call smartinput#define_rule({ 'char' : i[0], 'at' : '\%#',                                      'input' : '<C-R>=' . i[1] . '<CR>'})
        if i[0] == '%'
            call smartinput#define_rule({'char' : i[0], 'at' : '^\([^"]*"[^"]*"\)*[^"]*"[^"]*\%#',          'input' : i[0]})
        endif
        call smartinput#define_rule({ 'char' : i[0], 'at' : '^\([^'']*''[^'']*''\)*[^'']*''[^'']*\%#',  'input' : i[0] })
    endfor

    call smartinput#define_rule({'char' : '>', 'at' : ' < \%#', 'input' : '<BS><BS><BS><><Left>'})

    call smartinput#map_to_trigger('i', '=', '=', '=')
    call smartinput#define_rule({ 'char' : '=', 'at' : '\%#',                                       'input' : "<C-R>=smartchr#loop(' = ', ' == ', '=')<CR>"})
    call smartinput#define_rule({ 'char' : '=', 'at' : '[&+-/<>|] \%#',                             'input' : '<BS>= '})
    call smartinput#define_rule({ 'char' : '=', 'at' : '!\%#',                                      'input' : '= '})
    " call smartinput#define_rule({ 'char' : '=', 'at' : '^\([^"]*"[^"]*"\)*[^"]*"[^"]*\%#',          'input' : '='})
    call smartinput#define_rule({ 'char' : '=', 'at' : '^\([^'']*''[^'']*''\)*[^'']*''[^'']*\%#',   'input' : '='})

    call smartinput#map_to_trigger('i', '<BS>', '<BS>', '<BS>')
    call smartinput#define_rule({ 'char' : '<BS>' , 'at' : '(\s*)\%#'   , 'input' : '<C-O>dF(<BS>'})
    call smartinput#define_rule({ 'char' : '<BS>' , 'at' : '{\s*}\%#'   , 'input' : '<C-O>dF{<BS>'})
    call smartinput#define_rule({ 'char' : '<BS>' , 'at' : '<\s*>\%#'   , 'input' : '<C-O>dF<<BS>'})
    call smartinput#define_rule({ 'char' : '<BS>' , 'at' : '\[\s*\]\%#' , 'input' : '<C-O>dF[<BS>'})

    for op in ['<', '>', '+', '-', '/', '&', '%', '\*', '|']
        call smartinput#define_rule({ 'char' : '<BS>' , 'at' : ' ' . op . ' \%#' , 'input' : '<BS><BS><BS>'})
    endfor

    call smartinput#map_to_trigger('i', '*', '*', '*')
    call smartinput#define_rule({ 'char' : '*', 'at' : 'defparameter \*\%#', 'input' : '*<Left>', 'filetype' : [ 'lisp' ]})
endfunction

" Smartchr
let s:hooks = neobundle#get_hooks('vim-smartchr')
function! s:hooks.on_source(bundle)
    inoremap <expr> , smartchr#one_of(', ', '->', ' => ')

    if &filetype ==? 'lisp'
        inoremap <expr> ; smartchr#loop('; ', ';')
    endif
endfunction

" FIXME: QuickRun
let g:quickrun_config = {}
let g:quickrun_config._ = { 'outputter' : 'quickfix', 'outputter/buffer/split' : ' :vertical rightbelow', 'runner' : 'vimproc' }
let g:quickrun_config.lisp = { 'command' : 'clisp', 'exec' : '%c < %s:p' }
let g:quickrun_config.make = { 'command' : "make",  'exec' : '%c %o', 'runner' : 'vimproc', "outputter/quickfix/open_cmd" : "", "hook/unite_quickfix/enable_exit" : 1, "hook/unite_quickfix/enable_failure" : 1}

" learn-vimscript
nnoremap <Leader>lv :help learn-vimscript.txt<CR> <C-W>L

" SuddenDeath
map <Leader>x <Plug>(operator-suddendeath)

" Open-Browser
map <Leader>op <Plug>(openbrowser-open)

" operator-replace
map _ <Plug>(operator-replace)

" operator-surround
nmap <silent> zd <Plug>(operator-surround-delete)
nmap <silent> zr <Plug>(operator-surround-replace)
nmap <silent> zs <Plug>(operator-surround-append)
omap <silent> zd <Plug>(operator-surround-delete)
omap <silent> zr <Plug>(operator-surround-replace)
omap <silent> zs <Plug>(operator-surround-append)
nmap <silent> zss <Plug>(operator-surround-append)<Plug>(textobj-block-i)
nmap <silent> zdd <Plug>(operator-surround-delete)<Plug>(textobj-block-a)
nmap <silent> zrr <Plug>(operator-surround-replace)<Plug>(textobj-block-a)

" vim-expand-region
vmap K <Plug>(expand_region_expand)
vmap J <Plug>(expand_region_shrink)

" textobj-line
omap il <Plug>(textobj-line-i)
omap al <Plug>(textobj-line-a)
vmap il <Plug>(textobj-line-i)
vmap al <Plug>(textobj-line-a)

" textobj-multiblock
let g:textobj_multiblock_blocks = [ ['(', ')'], ['[', ']'], ['{', '}'], ['<', '>'], ['"', '"'], ["'", "'"], ['\_^\s*\<function\>.*', '\_^\s*endfunction\_$'], ['\_^\s*\<if\>.*', '\_^\s*\<endif\>\s*\_$'], ]

" textobj-parameter
omap i, <Plug>(textobj-parameter-i)
omap a, <Plug>(textobj-parameter-a)

" textobj-multitextobj
let g:textobj_multitextobj_textobjects_group_i = {
            \   "A" : [
            \       "\<Plug>(textobj-wiw-i)",
            \       "iw",
            \    ],
            \   "B" : [
            \       "it",
            \       "\<Plug>(textobj-multiblock-i)",
            \    ],
            \}
let g:textobj_multitextobj_textobjects_group_a = {
            \   "A" : [
            \       "\<Plug>(textobj-wiw-a)",
            \       "aw",
            \    ],
            \   "B" : [
            \       "at",
            \       "\<Plug>(textobj-multiblock-a)",
            \    ],
            \}
omap <Plug>(textobj-word-i)  <Plug>(textobj-multitextobj-A-i)
omap <Plug>(textobj-word-a)  <Plug>(textobj-multitextobj-A-a)
omap <Plug>(textobj-block-i) <Plug>(textobj-multitextobj-B-i)
omap <Plug>(textobj-block-a) <Plug>(textobj-multitextobj-B-a)
vmap <Plug>(textobj-word-i)  <Plug>(textobj-multitextobj-A-i)
vmap <Plug>(textobj-word-a)  <Plug>(textobj-multitextobj-A-a)
vmap <Plug>(textobj-block-i) <Plug>(textobj-multitextobj-B-i)
vmap <Plug>(textobj-block-a) <Plug>(textobj-multitextobj-B-a)
omap iw <Plug>(textobj-word-i)
omap aw <Plug>(textobj-word-a)
omap ib <Plug>(textobj-block-i)
omap ab <Plug>(textobj-block-a)
vmap iw <Plug>(textobj-word-i)
vmap aw <Plug>(textobj-word-a)
vmap ib <Plug>(textobj-block-i)
vmap ab <Plug>(textobj-block-a)

" Gist
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" syntastic
let s:hooks = neobundle#get_hooks('syntastic')
function! s:hooks.on_source(bundle)
    let g:syntastic_mode_map = { 'mode' : 'passive' }
    let op = '-Wall -Wextra -Wconversion -Wno-unused-parameter -Wno-sign-compare -Wno-pointer-sign -Wcast-qual'
    let t = s:check_clang()
    let g:syntastic_c_compiler           = ((t == '') ? 'gcc' : t)
    let g:syntastic_cpp_compiler         = ((t == '') ? 'g++' : t . '++')
    let g:syntastic_c_compiler_options   = ($USER == 'mopp' ? '-std=c11 ' : '') . op
    let g:syntastic_cpp_compiler_options = ($USER == 'mopp' ? '-std=c++14 ' : '') . op
    let g:syntastic_loc_list_height      = 5
endfunction

" rainbow parenthesis
let g:rainbow_active = 1
let g:rainbow_conf = {
            \   'guifgs' : [ '#666666', '#0087ff', '#ff005f', '#875fd7', '#d78700', '#00af87', ],
            \   'ctermfgs': [ '242', '33', '197', '98', '172', '36', ],
            \   'separately' : { '*': {}, 'vim' : {} },
            \   }

" anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" OpenVimrc
nmap <silent> <Leader>ev <Plug>(openvimrc-open)

" yankround
let g:yankround_dir = '~/.vim/yankround'
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" LayoutPlugin
let g:layoutplugin#is_append_vimrc = 1

" small
map <Leader>sm <Plug>(smalls)

" blockit
vmap <Leader>tt <Plug>BlockitVisual

" lightline
let g:lightline = {
            \ 'enable'      : { 'tabline' : 0 },
            \ 'colorscheme' : 'mopkai',
            \ 'active' : {
            \   'left'  : [ [ 'mode', 'paste' ], [ 'git' ], [ 'filename', 'modified' ], [ 'readonly' ], [ 'buflist' ] ],
            \   'right' : [ [ 'syntastic', 'fileencoding', 'fileformat', 'lineinfo', 'percent' ], [ 'filetype' ], [ 'tagbar' ], [ 'battery' ] ],
            \ },
            \ 'inactive' : {
            \   'left'  : [ [ 'filename' ] ],
            \   'right' : [ [ 'percent' ], [ 'filetype' ] ]
            \ },
            \ 'separator'       : { 'left' : '',  'right' : ''  },
            \ 'subseparator'    : { 'left' : '|', 'right' : '|' },
            \ 'component' : {
            \   'lineinfo'      : "%{ &filetype =~? 'vimfiler\\|tagbar\\|unite' ? '' : printf('%03d:%03d', line('.'), col('.')) }",
            \   'percent'       : "%{ &filetype =~? 'vimfiler\\|tagbar\\|unite' ? '' : printf('%3d%%', float2nr((1.0 * line('.')) / line('$') * 100.0)) }",
            \   'fileformat'    : "%{ &filetype =~? 'vimfiler\\|tagbar\\|unite' || winwidth(0) < 60 ? '' : &fileformat }",
            \   'filetype'      : "%{ &filetype =~? 'vimfiler\\|tagbar\\|unite' || winwidth(0) < 60 ? '' : &filetype }",
            \   'fileencoding'  : "%{ &filetype =~? 'vimfiler\\|tagbar\\|unite' || winwidth(0) < 60 ? '' : (strlen(&fenc) ? &fenc : &enc) }",
            \   'paste'         : "%{ &modifiable && &paste ? 'Paste' : '' }",
            \   'readonly'      : "%{ &readonly ? 'RO' : '' }",
            \   'tagbar'        : "%{ exists('*tagbar#currenttag') ? tagbar#currenttag('%s','', 'f') : '' }",
            \ },
            \ 'component_function' : {
            \   'mode'     : 'Mline_mode',
            \   'modified' : 'Mline_modified',
            \   'filename' : 'Mline_filename',
            \   'git'      : 'Mline_git',
            \   'buflist'  : 'Mline_buflist',
            \   'battery'  : 'Mline_battery',
            \ },
            \ 'component_expand'    : { 'syntastic' : 'SyntasticStatuslineFlag', },
            \ 'component_type'      : { 'syntastic' : 'error', },
            \ }

let s:p = { 'normal': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'inactive': {}, }
let s:cp = {
            \ 'fg':     [ '#9e9e9e', 247 ], 'glay':   [ '#303030', 236 ], 'dark':      [ '#0E1119', 232 ],
            \ 'light':  [ '#e4e4e4', 254 ], 'purple': [ '#875fd7',  98 ], 'blue':      [ '#00afff',  39 ],
            \ 'orange': [ '#d75f00', 166 ], 'red':    [ '#ff0000', 196 ], 'deep_glay': [ '#2e2930', 235 ],
            \ }
let s:pa = { 'base_glay' : [ s:cp.fg, s:cp.glay ], 'base_dark' : [ s:cp.fg, s:cp.dark ], 'base_deep' : [ s:cp.fg, s:cp.deep_glay ], }
let s:p.normal.left     = [ [ s:cp.dark, s:cp.blue ], [ s:cp.orange,  s:cp.deep_glay ], s:pa.base_dark, [ s:cp.red, s:cp.dark ] ]
let s:p.normal.middle   = [ s:pa.base_glay ]
let s:p.normal.right    = [ s:pa.base_deep, [ s:cp.purple, s:cp.dark ], [ s:cp.dark, [ '#201C26', 68 ] ], [s:cp.blue, s:cp.glay ] ]
let s:p.insert.left     = [ [ s:cp.dark, [ '#87ff00', 118 ] ], s:p.normal.left[1], s:p.normal.left[2], s:p.normal.left[3] ]
let s:p.replace.left    = [ [ s:cp.dark, [ '#ff0087', 198 ] ], s:p.normal.left[1], s:p.normal.left[2], s:p.normal.left[3] ]
let s:p.visual.left     = [ [ s:cp.dark, [ '#d7ff5f', 191 ] ], s:p.normal.left[1], s:p.normal.left[2], s:p.normal.left[3] ]
let s:p.inactive.left   = [ [ [ '#4e4e4e', 239 ], s:cp.dark ] ]
let s:p.inactive.middle = [ [ s:cp.fg, [ '#000000',  16 ] ] ]
let s:p.inactive.right  = [ s:pa.base_dark, [ s:cp.purple, s:cp.dark ] ]
let s:p.normal.error    = [ [ s:cp.dark, s:cp.red ] ]
let s:p.normal.warning  = [ [ s:cp.dark, [ '#ffd700', 220 ] ] ]
let g:lightline#colorscheme#mopkai#palette = lightline#colorscheme#flatten(s:p)
unlet s:pa s:cp s:p

function! Mline_mode()
    if &filetype == 'unite'
        return 'Unite'
    elseif &filetype == 'vimfiler'
        return winwidth(0) <= 35 ?  '' : 'VimFiler'
    elseif &filetype == 'tagbar'
        return 'Tagbar'
    else
        return lightline#mode()
    endif
endfunction

function! Mline_modified()
    if &filetype == 'unite' || !&modifiable
        return ''
    endif
    return &modified ? '[+]' : '[-]'
endfunction

function! Mline_filename()
    if &filetype == 'unite'
        return unite#get_status_string()
    elseif &filetype == 'vimfiler'
        if winwidth(0) <= 20
            return ''
        endif
        return vimfiler#get_status_string()
    elseif &filetype == 'tagbar'
        return g:lightline.fname
    endif
    return '' != expand('%:t') ? expand('%:t') : '[No Name]'
endfunction

function! Mline_git()
    if (&modifiable) && (&filetype !~? 'unite\|vimfiler') && (executable('git')) && (finddir('.git', getcwd() . ';') != '')
        let str = substitute(matchstr(system('git branch'), '\*\s.*\n'), '\*\s*\|\s*\n', '', 'g')

        " Not added changes
        call system('git diff --no-ext-diff --quiet --exit-code')
        if v:shell_error == 1
            let str = str . '*'
        endif

        " Not committed changes
        call system('git diff-index --cached --quiet HEAD --')
        if v:shell_error == 1
            let str = str . '+'
        endif

        " Check untracked files
        if system('git ls-files --exclude-standard --others') != ''
            let str = str . '%'
        endif

        return str
    endif
    return ''
endfunction

function! Mline_battery()
    if !exists(':Battery')
        return ''
    endif

    let per = battery#battery('%p')
    if per == 'N/A'
        return ''
    endif

    return 'Battery: ' . per . '%'
endfunction

let g:mopbuf_settings = get(g:, 'mopbuf_settings', {})
let g:mopbuf_settings['auto_open_each_tab'] = 0
let g:mopbuf_settings['sort_order'] = 'mru'
function! Mline_buflist()
    if mopbuf#managed_buffer_num() <= 4 && mopbuf#is_show_display_buffer() == 0
        return mopbuf#get_buffers_str_exclude(bufnr(''))
    endif

    let g:mopbuf_settings.auto_open_each_tab = 1

    return ''
endfunction

function! Tagbar_status_func(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction
let g:tagbar_status_func = 'Tagbar_status_func'

" next-alter
nmap <Leader>an <Plug>(next-alter-open)
let g:next_alter#search_dir = [ './include', '.' , '..', '../include' ]
" let g:next_alter#open_option = 'vertical topleft'

" mopkai
let g:mopkai_is_not_set_normal_ctermbg = or(!has('mac'), ($USER != 'mopp'))

" sudo.vim
command! -nargs=0 Sw :w sudo:%
command! -nargs=0 Swq :wq sudo:%

" easy-align
vmap <Enter>    <Plug>(LiveEasyAlign)
nmap <Leader>aa <Plug>(LiveEasyAlign)

" smartnumber
let g:snumber_enable_startup = 1
nnoremap <silent> <Leader>n :SNumbersToggleRelative<CR>

" marker.vim
nnoremap [Mark] <Nop>
nmap m [Mark]
nmap [Mark]m <Plug>(Marker-auto_mark)
nnoremap [Mark]n ]`
nnoremap [Mark]p [`
nnoremap [Mark]l :<C-u>marks<CR>

" neocomplete-rsense
let g:neocomplete#sources#rsense#home_directory = '/usr/bin/rsense'

" vim-ruby
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_operators = 1
let g:ruby_space_errors = 1

" Clighter
let s:hooks = neobundle#get_hooks('clighter')
function! s:hooks.on_source(bundle)
    let g:clighter_libclang_file = '/usr/local/lib/libclang.so'
    if filereadable(g:clighter_libclang_file) == 0
        let g:clighter_libclang_file = '/usr/lib/libclang.so'
    endif
endfunction
function! s:hooks.on_post_source(bundle)
    let g:clighter_occurrences_mode = 1
    hi m_decl cterm=bold
    hi link clighterMacroInstantiation Define
    hi link clighterTypeRef            Type
    hi link clighterVarDecl            m_decl
    hi link clighterStructDecl         m_decl
    hi link clighterClassDecl          m_decl
    hi link clighterEnumDecl           m_decl
    hi link clighterEnumConstantDecl   Number
    hi link clighterDeclRefExprEnum    Identifier
    hi link clighterCursorSymbolRef    IncSearch
    hi link clighterFunctionDecl       None
    hi link clighterDeclRefExprCall    None
    hi link clighterMemberRefExpr      None
    hi link clighterNamespace          None
endfunction

" Casetrate
let g:casetrate_leader = '<leader>a'

" argwrap
nnoremap <silent> <leader>aw :call argwrap#toggle()<CR>


"-------------------------------------------------------------------------------"
" autocmd for plugin.
"-------------------------------------------------------------------------------"
" for lightline
function! s:update_syntastic()
    if &filetype == 'scala'
        return
    endif

    if !exists(':SyntasticCheck')
        NeoBundleSource syntastic
    endif
    SyntasticCheck
    call lightline#update()
endfunction

" Depend on any plugin.
augroup plugin
    autocmd!

    " VimFiler
    autocmd FileType vimfiler call s:config_vimfiler()

    " Unite
    autocmd FileType unite call s:on_exe_unite()

    " Java
    autocmd CompleteDone *.java call javaapi#showRef()

    " lightline
    autocmd BufWritePost * call s:update_syntastic()
augroup END

syntax enable           " 強調表示有効
colorscheme mopkai      " syntaxコマンドよりもあとにすること
