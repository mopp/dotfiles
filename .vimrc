" __   ___                 __           __  __
" \ \ / (_)_ __  _ _ __   / _|___ _ _  |  \/  |___ _ __ _ __
"  \ V /| | '  \| '_/ _| |  _/ _ \ '_| | |\/| / _ \ '_ \ '_ \
"   \_/ |_|_|_|_|_| \__| |_| \___/_|   |_|  |_\___/ .__/ .__/
"                                                 |_|  |_|

" Indent.
set autoindent
set backspace=2
set breakindent
set expandtab
set shiftwidth=4
set smartindent
set tabstop=4

" Encoding.
if has('vim_starting')
    " Changing encoding in Vim at runtime is undefined behavior.
    set encoding=utf-8
    set fileencodings=utf-8,sjis,cp932,euc-jp
    set fileformats=unix,mac,dos
endif

" Appearance
set ambiwidth=double
set cmdheight=2
set conceallevel=2
set cursorline
set display=lastline
set laststatus=2
set list
set listchars=tab:>\ ,trail:\ ,extends:<,precedes:<
set noarabicshape
set scrolloff=3
set showcmd
set showmatch
set showtabline=2
set statusline=%<%F\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}%=%l/%L,%c%V%8P
set nowrap

" Folding.
set foldenable
set foldcolumn=1
set foldmethod=indent
set foldtext=Mopp_fold()

" Safety.
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set swapfile
set writebackup

" History
set history=2048
set undodir=~/.vim/undo
set undofile
set viewoptions=cursor,folds

" Search.
set hlsearch
set ignorecase
set incsearch
set path=.,/usr/local/include,/usr/include,./include
set smartcase

" Others.
set belloff=all
set completeopt=menu
set confirm
set dictionary=/usr/share/dict/words
set formatoptions+=tjrol
set helplang=ja
set langnoremap
set lazyredraw
set matchpairs+=<:>
set mouse=a
set regexpengine=2
set updatetime=500
set virtualedit=block
set whichwrap=b,s,h,l,<,>,[,]
set wildignorecase
set wildmenu

" Turn off default plugins.
let g:loaded_2html_plugin  = 1
let g:loaded_gzip          = 1
let g:loaded_rrhelper      = 1
let g:loaded_tar           = 1
let g:loaded_tarPlugin     = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip           = 1
let g:loaded_zipPlugin     = 1
let g:loaded_matchparen    = 1

" Configs for default scripts.
let g:lisp_rainbow     = 1
let g:lisp_instring    = 1
let g:lispsyntax_clisp = 1
let g:c_syntax_for_h   = 1
let g:tex_conceal      = ''
let g:tex_flavor       = 'latex'


"-------------------------------------------------------------------------------"
" Functions
"-------------------------------------------------------------------------------"
function! Mopp_fold()
    let head = '+' . join(map(range(&shiftwidth * v:foldlevel - 2), '"-"'), '') . ' ' . substitute(getline(v:foldstart), '^\s*', '', '')
    let tail = printf('[ %2d Lines Lv%02d ]', (v:foldend - v:foldstart + 1), v:foldlevel)
    let space_size = (winwidth(0) - &foldcolumn - strdisplaywidth(head) - strdisplaywidth(tail) - 1) - (&number ? max([&numberwidth, strdisplaywidth(line('$'))]) : 0)
    return printf('%s%' . space_size . 'S%s', head, '', tail)
endfunction

function! Mopp_paste(register, paste_type, paste_cmd)
    let reg_type = getregtype(a:register)
    let store = getreg(a:register)
    call setreg(a:register, store, a:paste_type)
    exe 'normal "' . a:register . a:paste_cmd
    call setreg(a:register, store, reg_type)
endfunction

function! Mopp_copy_to_clipboard()
    let store = @@
    silent normal gvy
    let selected = @@
    let @@ = store

    let @+ = selected
    let @* = selected
endfunction


"----------------------------------------------------------------------------
" Mappings                                                                  |
"---------------------------------------------------------------------------|
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
"----------------------------------------------------------------------------

let g:mapleader      = ' '
let g:maplocalleader = '\'

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
nnoremap <silent> <CR>      :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor<CR>
nnoremap <silent> <Leader>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor<CR>

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

function! s:remove_tail_space()
    if &filetype == 'markdown'
        return
    endif

    let c = getpos('.')
    g/.*\s$/normal $gelD
    call setpos('.', c)
endfunction


"-------------------------------------------------------------------------------"
" GUI
"-------------------------------------------------------------------------------"
if has('gui_running')
    set guioptions-=emTrlL

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
augroup mopp
    autocmd!

    " .vimrc
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

    " 挿入モード解除時に自動でpasteをoff
    autocmd InsertLeave * setlocal nopaste

    " 状態の保存と復元
    " autocmd BufWinLeave * if (bufname('%') != '') | silent mkview!  | endif
    " autocmd BufWinEnter * if (bufname('%') != '') | silent! loadview | endif

    autocmd BufWritePre * silent call s:remove_tail_space()

    " git
    autocmd FileType git setlocal foldlevel=99

    " nask
    autocmd BufWinEnter *.nas nested setlocal filetype=nasm

    " json
    autocmd BufWinEnter *.json nested setlocal filetype=json

    " Arduino
    autocmd BufWinEnter *.pde,*.ino nested setlocal filetype=arduino

    " markdown
    autocmd BufWinEnter *.{md,mdwn,mkd,mkdn} nested setlocal filetype=markdown

    " gnuplot
    autocmd BufWinEnter *.plt nested setlocal filetype=gnuplot

    " Lisp
    autocmd FileType lisp setlocal nocindent nosmartindent lisp lispwords=define

    " text.
    autocmd BufWinEnter *.txt setlocal wrap

    " Tex
    autocmd BufWinEnter,FilterWritePost *.tex setlocal spell wrap nocursorline

    " sh
    autocmd BufWinEnter *.sh setlocal filetype=sh

    " toml
    autocmd BufWinEnter *.toml setlocal filetype=toml

    autocmd BufWinEnter *.m setlocal foldmethod=indent
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
    nnoremap <Leader>tm :terminal<CR>
    nnoremap <Leader>vst :vsplit term://zsh<CR>
endif


"-------------------------------------------------------------------------------"
" Plugin
"-------------------------------------------------------------------------------"
let s:DEIN_BASE_PATH = '~/.vim/bundle/'
let s:DEIN_PATH      = expand(s:DEIN_BASE_PATH . 'repos/github.com/Shougo/dein.vim')
if !isdirectory(s:DEIN_PATH)
    if !executable('git')
        syntax enable
        colorscheme desert
        finish
    endif

    execute '!git clone --depth=1 https://github.com/Shougo/dein.vim' s:DEIN_PATH
endif

" dein.vim
execute 'set runtimepath^=' . s:DEIN_PATH

if dein#load_state(s:DEIN_BASE_PATH)
    call dein#begin(s:DEIN_BASE_PATH)

    call dein#add('Shougo/dein.vim')

    call dein#add('Shougo/deoplete.nvim', { 'lazy' : 1, 'depends' : 'neosnippet', 'on_i' : 1, 'if' : has('nvim') })
    call dein#add('Shougo/neocomplete.vim', { 'lazy' : 1, 'depends' : 'neosnippet', 'on_i' : 1, 'if' : (has('lua') && !has('nvim')) })

    call dein#add('Shougo/neosnippet', { 'lazy' : 1 , 'depends' : 'vim-snippets' })
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('honza/vim-snippets', { 'lazy' : 1 })

    call dein#add('FooSoft/vim-argwrap', { 'lazy' : 1, 'on_func' : 'argwrap' })
    call dein#add('Konfekt/FastFold')
    call dein#add('LeafCage/yankround.vim')
    call dein#add('Lokaltog/vim-easymotion')
    call dein#add('Shougo/vimfiler', { 'lazy' : 1, 'depends' : 'unite.vim', 'on_path' : '.*/', 'on_func' : 'vimfiler', 'on_cmd' : [ 'VimFiler', 'VimFilerBufferDir'], 'hook_post_source' : 'call vimfiler#custom#profile("default", "context", { "safe" : 0 })' })
    call dein#add('Shougo/vimproc.vim', { 'build' : 'make' })
    call dein#add('Shougo/vinarise', { 'on_cmd' : 'Vinarise' })
    call dein#add('Yggdroot/indentLine')
    call dein#add('airblade/vim-gitgutter', { 'lazy' : 1, 'on_i' : 1 })
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('godlygeek/tabular', { 'lazy' : 1, 'on_cmd' : [ 'Tabularize', 'AddTabularPattern' ] })
    call dein#add('idanarye/vim-casetrate', { 'lazy' : 1, 'on_cmd' : 'Casetrate' })
    call dein#add('itchyny/lightline.vim')
    call dein#add('itchyny/vim-parenmatch')
    call dein#add('junegunn/vim-easy-align', { 'lazy' : 1, 'on_cmd' : 'EasyAlign', 'on_map' : [ [ 'nv', '<Plug>(LiveEasyAlign)', '<Plug>(EasyAlign)' ] ] })
    call dein#add('kana/vim-niceblock', { 'lazy' : 1, 'on_map' : [ [ 'x', 'I', 'A' ] ] })
    call dein#add('kana/vim-smartchr')
    call dein#add('kana/vim-smartinput', { 'lazy' : 1, 'on_i' : 1, 'hook_post_source' : 'call Hook_on_post_source_smartinput()'})
    call dein#add('koron/nyancat-vim', { 'lazy''on_cmd' : [ 'Nyancat', 'Nyancat2' ] })
    call dein#add('luochen1990/rainbow')
    call dein#add('majutsushi/tagbar', { 'lazy' : 1, 'on_cmd' : 'TagbarToggle' })
    call dein#add('mattn/benchvimrc-vim', { 'lazy' : 1, 'on_cmd' : 'BenchVimrc' })
    call dein#add('mattn/gist-vim', { 'lazy' : 1, 'depends' : 'webapi-vim', 'on_cmd' : 'Gist' })
    call dein#add('mattn/learn-vimscript')
    call dein#add('mattn/webapi-vim')
    call dein#add('mopp/DoxyDoc.vim', { 'lazy' : 1, 'on_cmd' : [ 'DoxyDoc', 'DoxyDocAuthor' ] })
    call dein#add('mopp/autodirmake.vim', { 'lazy' : 1, 'on_i' : 1 })
    call dein#add('mopp/battery.vim', { 'lazy' : 1, 'on_func' : 'battery', 'on_cmd' : 'Battery' })
    call dein#add('mopp/layoutplugin.vim', { 'lazy' : 1, 'on_cmd' : 'LayoutPlugin' })
    call dein#add('mopp/learn-markdown.vim')
    call dein#add('mopp/makecomp.vim', { 'lazy' : 1, 'on_cmd' : 'Make' })
    call dein#add('mopp/mopbuf.vim')
    call dein#add('mopp/mopkai.vim')
    call dein#add('mopp/next-alter.vim', { 'lazy' : 1, 'on_cmd' : 'OpenNAlter', 'on_map'  : [ [ 'n', '<Plug>(next-alter-open)' ] ] })
    call dein#add('mopp/openvimrc.vim' , { 'lazy' : 1, 'on_map' : [ [ 'n', '<Plug>(openvimrc-open)' ] ] })
    call dein#add('mopp/smartnumber.vim')
    call dein#add('osyo-manga/vim-anzu', { 'lazy' : 1, 'on_map' : [ [ 'n', '<Plug>' ] ] })
    call dein#add('osyo-manga/vim-marching', { 'lazy' : 1, 'on_ft' : [ 'c', 'cpp' ] })
    call dein#add('osyo-manga/vim-stargate', { 'lazy' : 1, 'on_cmd' : 'StargateInclude' } )
    call dein#add('rhysd/vim-clang-format', { 'lazy' : 1, 'on_cmd' : [ 'ClangFormat', 'ClangFormatEchoFormattedCode' ] })
    call dein#add('rickhowe/diffchar.vim')
    call dein#add('scrooloose/nerdcommenter', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>NERDCommenter' ] ], 'hook_post_source' : 'doautocmd NERDCommenter BufEnter'})
    call dein#add('scrooloose/syntastic', { 'lazy' : 1, 'on_i' : 1 })
    call dein#add('set0gut1/previm', { 'lazy' : 1, 'on_cmd' : 'PrevimOpen', 'on_ft' : 'markdown' })
    call dein#add('sk1418/blockit', { 'lazy' : 1, 'on_cmd' : 'Block', 'on_map' : [ [ 'x', '<Plug>BlockitVisual' ] ] })
    call dein#add('sudo.vim', { 'lazy' : 1, 'on_cmd' : ['Sw', 'Swq']})
    call dein#add('thinca/vim-visualstar')
    call dein#add('tpope/vim-repeat')
    call dein#add('tyru/open-browser.vim', { 'lazy' : 1, 'on_map' : [ [ 'n', '<Plug>(openbrowser-open)' ] ], 'on_func' : 'openbrowser' })
    call dein#add('ujihisa/neco-look')

    call dein#add('Nemo157/scala.vim', { 'lazy' : 1, 'on_ft' : 'scala' })
    call dein#add('Shirk/vim-gas')
    call dein#add('awk.vim')
    call dein#add('bbchung/clighter', { 'lazy' : 1, 'on_ft' : [ 'c', 'cpp' ], 'hook_post_source' : 'call Hook_on_post_source_clighter()' })
    call dein#add('cespare/vim-toml')
    call dein#add('daeyun/vim-matlab', {'lazy':1, 'on_ft' : 'matlab'})
    call dein#add('digitaltoad/vim-pug')
    call dein#add('gnuplot.vim', {'lazy':1, 'on_ft' : 'gnuplot'})
    call dein#add('jelera/vim-javascript-syntax')
    call dein#add('lervag/vimtex')
    call dein#add('othree/html5.vim')
    call dein#add('pangloss/vim-javascript', { 'lazy' : 1, 'on_ft' : 'javascript' })
    call dein#add('plasticboy/vim-markdown')
    call dein#add('rust-lang/rust.vim')
    call dein#add('shima-529/C-prototype.vim', { 'lazy' : 1, 'on_ft' : 'c' })
    call dein#add('thinca/vim-ft-help_fold')
    call dein#add('vim-jp/cpp-vim')
    call dein#add('vim-jp/vimdoc-ja')
    call dein#add('vim-ruby/vim-ruby')
    call dein#add('vim-scripts/Arduino-syntax-file')
    call dein#add('vim-scripts/sh.vim--Cla')
    call dein#add('wavded/vim-stylus')
    call dein#add('yuratomo/java-api-complete', { 'lazy' : 1, 'on_ft' : 'java' })

    call dein#add('haya14busa/vim-operator-flashy', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>' ] ] })
    call dein#add('kana/vim-operator-replace', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>' ] ] })
    call dein#add('kana/vim-operator-user')
    call dein#add('tommcdo/vim-exchange', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>' ] ]})
    call dein#add('tyru/operator-camelize.vim', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>' ] ] })

    call dein#add('kana/vim-textobj-function', { 'lazy' : 1, 'on_map' : [ [ 'ox', 'af', 'if', 'aF', 'iF' ] ] })
    call dein#add('kana/vim-textobj-indent', { 'lazy' : 1, 'on_map' :  [ [ 'ox', 'ai' , 'ii' , 'aI',  'iI' ] ] })
    call dein#add('kana/vim-textobj-line', { 'lazy' : 1, 'on_map' : [ [ 'ox', 'al', 'il' ] ] })
    call dein#add('kana/vim-textobj-user')
    call dein#add('rhysd/vim-textobj-word-column', { 'lazy' : 1, 'on_map' : [ [ 'ox', 'av', 'iv' ] ] })
    call dein#add('sgur/vim-textobj-parameter', { 'lazy' : 1, 'on_map' : [ [ 'ox', 'a,', 'i,', 'i2,' ] ] })
    " call dein#add('reedes/vim-textobj-sentence', { 'lazy' : 1, 'on_ft' : [ 'tex', 'markdown', 'txt' ], 'hook_post_source' : 'call textobj#sentence#init()'})
    call dein#add('reedes/vim-textobj-sentence', { 'lazy' : 1 })

    call dein#add('machakann/vim-sandwich')

    call dein#add('Shougo/unite.vim', { 'lazy': 1, 'on_func': 'unite', 'on_cmd': 'Unite', 'depends': [ 'neomru.vim', 'vim-unite-giti' ]})
    call dein#add('Shougo/neomru.vim', { 'lazy': 1 })
    call dein#add('Shougo/unite-outline')
    call dein#add('junkblocker/unite-tasklist')
    call dein#add('kmnk/vim-unite-giti', { 'lazy': 1, })
    call dein#add('lambdalisue/unite-grep-vcs')
    call dein#add('osyo-manga/unite-quickfix')
    call dein#add('tsukkee/unite-tag')

    call dein#end()

    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on

" Unite
nnoremap [Unite] <Nop>
nmap <Leader>f [Unite]
nnoremap <silent> [Unite]re :<C-u>UniteResume<CR>
nnoremap <silent> [Unite]f  :<C-u>Unite -buffer-name=Files file_rec/async:!<CR>
nnoremap <silent> [Unite]s  :<C-u>Unite -buffer-name=Sources source<CR>
nnoremap <silent> [Unite]gi :<C-u>Unite -buffer-name=Giti giti<CR>
nnoremap <silent> [Unite]gg :<C-u>call <SID>unite_smart_grep()<CR>
nnoremap <silent> [Unite]o  :<C-u>Unite -buffer-name=Outlines outline<CR>
nnoremap <silent> [Unite]l  :<C-u>Unite -buffer-name=Lines line<CR>
nnoremap <silent> [Unite]t  :<C-u>Unite -buffer-name=TaskList tasklist<CR>
nnoremap <silent> [Unite]q  :<C-u>Unite -buffer-name=QuickFix quickfix -no-quit -direction=botright<CR>

function! s:unite_smart_grep()
    if unite#sources#grep_git#is_available()
        Unite grep/git -buffer-name=Search
    elseif unite#sources#grep_hg#is_available()
        Unite grep/hg -buffer-name=Search
    else
        Unite grep -buffer-name=Search
    endif
endfunction

let g:unite_source_file_mru_limit      = 50
let g:unite_cursor_line_highlight      = 'TabLineSel'
let g:unite_enable_short_source_names  = 1
let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
let g:unite_source_grep_max_candidates = 200
let g:unite_quickfix_is_multiline      = 0

if executable('hw')
    " for highway
    let g:unite_source_grep_command       = 'hw'
    let g:unite_source_grep_default_opts  = '--no-group --no-color'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_encoding      = 'utf-8'
elseif executable('pt')
    " for the platinum searcher
    let g:unite_source_grep_command       = 'pt'
    let g:unite_source_grep_default_opts  = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_encoding      = 'utf-8'
endif

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

" Deoplete
if dein#tap('deoplete.nvim') && has('nvim')
    let g:deoplete#enable_at_startup     = 1
    let g:deoplete#enable_ignore_case    = 0
    let g:deoplete#enable_smart_case     = 1
    let g:deoplete#max_list              = 30
    let g:deoplete#omni_patterns         = {}
    let g:deoplete#omni_patterns.c       = '[^. *\t](\.|->)\w*'
    let g:deoplete#omni_patterns.cpp     = '[^. *\t](\.|->|::)\w*'
endif

" neocomplete
if dein#tap('neocomplete.vim') && !has('nvim')
    let g:neocomplete#enable_at_startup            = 1
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#min_keyword_length           = 2
    let g:neocomplete#enable_ignore_case           = 0
    let g:neocomplete#enable_smart_case            = 1
    let g:neocomplete#enable_cursor_hold_i         = 1
    let g:neocomplete#enable_insert_char_pre       = 1
    let g:neocomplete#enable_auto_delimiter        = 1
    let g:neocomplete#lock_buffer_name_pattern     = '^zsh.*'
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
endif

" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" set conceallevel=2 concealcursor=i
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['stylus'] = 'stylus,css,scss'
let g:neosnippet#scope_aliases['pug'] = 'jade'

" marching
let g:marching_enable_neocomplete = 1
let g:marching#clang_command#options = { 'cpp' : '-Wall -std=gnu++1y', 'c' : '-Wall -std=c11' }

" clang-format
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#auto_formatexpr = 1
let flags = [
            \ 'AfterClass: false',
            \ 'AfterControlStatement: false',
            \ 'AfterEnum: false',
            \ 'AfterFunction: true',
            \ 'AfterNamespace: true',
            \ 'AfterObjCDeclaration: true',
            \ 'AfterStruct: false',
            \ 'AfterUnion: false',
            \ 'BeforeCatch: false',
            \ 'BeforeElse: false',
            \ 'IndentBraces: false',
            \ ]
let g:clang_format#style_options = {
            \ 'AccessModifierOffset':                -4,
            \ 'AlignTrailingComments':               'true',
            \ 'AllowShortFunctionsOnASingleLine':    'false',
            \ 'AllowShortIfStatementsOnASingleLine': 'false',
            \ 'AllowShortLoopsOnASingleLine':        'false',
            \ 'AlwaysBreakTemplateDeclarations':     'true',
            \ 'BinPackParameters':                   'false',
            \ 'BreakBeforeBraces':                   'Custom',
            \ 'BraceWrapping':                       '{' . join(flags, ',') . '}',
            \ 'ColumnLimit':                         '0',
            \ 'IndentCaseLabels':                    'true',
            \ 'MaxEmptyLinesToKeep':                 '3',
            \ 'PointerBindsToType':                  'true',
            \ 'Standard':                            'Auto',
            \ 'TabWidth':                            '4',
            \ 'UseTab':                              'Never',
            \ 'IndentWidth':                         '4',
            \ }

" easymotion
let g:EasyMotion_leader_key = '<Leader>e'

" NERDCommenter
let g:NERDSpaceDelims = 1
nmap <Leader><Leader> <Plug>NERDCommenterToggle
vmap <Leader><Leader> <Plug>NERDCommenterNested
nmap <Leader>cs <plug>NERDCommenterSexy

" VimFiler
nnoremap <silent> <Leader>fvs :VimFiler -explorer<CR>
nnoremap <silent> <Leader>fvo :VimFiler -tab<CR>
nnoremap <silent> <Leader>fvb :VimFilerBufferDir -explorer<CR>
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_force_overwrite_statusline = 0
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
function! Hook_on_post_source_smartinput()
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
                \ [',',     "smartchr#loop(', ', '->', ' => ')"]]

    for i in lst
        call smartinput#map_to_trigger('i', i[0], i[0], i[0])
        call smartinput#define_rule({ 'char' : i[0], 'at' : '\%#', 'input' : '<C-R>=' . i[1] . '<CR>'})
        if i[0] == '%'
            call smartinput#define_rule({'char' : i[0], 'at' : '^\([^"]*"[^"]*"\)*[^"]*"[^"]*\%#', 'input' : i[0]})
        endif
        call smartinput#define_rule({ 'char' : i[0], 'at' : '^\([^'']*''[^'']*''\)*[^'']*''[^'']*\%#', 'input' : i[0] })
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

" learn-vimscript
nnoremap <Leader>lv :help learn-vimscript.txt<CR> <C-W>L

" Open-Browser
map <Leader>op <Plug>(openbrowser-open)

" vim-operator-flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)
let g:operator#flashy#group = 'Error'

" operator-replace
map _ <Plug>(operator-replace)

" operator-camelize
map <Leader>ca <Plug>(operator-camelize-toggle)

" exchange
nmap <Leader>cx <Plug>(Exchange)
xmap <Leader>cx <Plug>(Exchange)
nmap <Leader>cy <Plug>(ExchangeClear)
nmap <Leader>cy <Plug>(ExchangeLine)

" Gist
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" syntastic
let g:syntastic_mode_map = { 'mode' : 'passive' }
let op = '-Wall -Wextra -Wconversion -Wno-unused-parameter -Wno-sign-compare -Wno-pointer-sign -Wcast-qual'
let is_clang = executable('clang')
let g:syntastic_c_compiler           = ((is_clang == 0) ? 'gcc' : 'clang')
let g:syntastic_cpp_compiler         = ((is_clang == 0) ? 'g++' : 'clang++')
let g:syntastic_c_compiler_options   = ($USER == 'mopp' ? '-std=c11 ' : '') . op
let g:syntastic_cpp_compiler_options = ($USER == 'mopp' ? '-std=c++14 ' : '') . op
let g:syntastic_loc_list_height      = 5

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

" blockit
vmap <Leader>tt <Plug>BlockitVisual

" lightline
let g:lightline = {
            \ 'enable'      : { 'tabline' : 0 },
            \ 'colorscheme' : 'mopkai',
            \ 'active' : {
            \   'left'  : [ [ 'mode', 'paste' ], [ 'filename', 'modified' ], [ 'readonly' ], [ 'buflist' ] ],
            \   'right' : [ [ 'syntastic', 'fileencoding', 'fileformat', 'lineinfo', 'percent' ], [ 'filetype' ], [ 'tagbar' ], ],
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
            \   'readonly'      : "%{ &filetype !~? 'vimfiler\\|tagbar\\|unite' && &readonly ? 'RO' : '' }",
            \   'tagbar'        : "%{ exists('*tagbar#currenttag') ? tagbar#currenttag('%s','', 'f') : '' }",
            \ },
            \ 'component_function' : {
            \   'mode'     : 'Mline_mode',
            \   'modified' : 'Mline_modified',
            \   'filename' : 'Mline_filename',
            \   'buflist'  : 'Mline_buflist',
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
let s:p.normal.left     = [ [ s:cp.dark, s:cp.blue ], s:pa.base_dark, [ s:cp.red, s:cp.dark ] ]
let s:p.normal.middle   = [ s:pa.base_glay ]
let s:p.normal.right    = [ s:pa.base_deep, [ s:cp.purple, s:cp.dark ], [ s:cp.dark, [ '#201C26', 68 ] ] ]
let s:p.insert.left     = [ [ s:cp.dark, [ '#87ff00', 118 ] ], s:p.normal.left[1], s:p.normal.left[2] ]
let s:p.replace.left    = [ [ s:cp.dark, [ '#ff0087', 198 ] ], s:p.normal.left[1], s:p.normal.left[2] ]
let s:p.visual.left     = [ [ s:cp.dark, [ '#d7ff5f', 191 ] ], s:p.normal.left[1], s:p.normal.left[2] ]
let s:p.inactive.left   = [ [ [ '#4e4e4e', 239 ], s:cp.dark ] ]
let s:p.inactive.middle = [ [ s:cp.fg, [ '#000000',  16 ] ] ]
let s:p.inactive.right  = [ s:pa.base_dark, [ s:cp.purple, s:cp.dark ] ]
let s:p.normal.error    = [ [ s:cp.dark, s:cp.red ] ]
let s:p.normal.warning  = [ [ s:cp.dark, [ '#ffd700', 220 ] ] ]
let g:lightline#colorscheme#mopkai#palette = lightline#colorscheme#flatten(s:p)

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
        return vimfiler#get_status_string()
    elseif &filetype == 'tagbar'
        return g:lightline.fname
    endif
    return '' != expand('%:t') ? expand('%:t') : '[No Name]'
endfunction

let g:mopbuf_settings = get(g:, 'mopbuf_settings', {})
let g:mopbuf_settings['auto_open_each_tab'] = 0
let g:mopbuf_settings['sort_order'] = 'mru'
function! Mline_buflist()
    if (&filetype == 'unite') || (&filetype == 'vimfiler') || (&filetype == 'tagbar')
        return ''
    endif

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
vmap <Enter> <Plug>(LiveEasyAlign)

" smartnumber
let g:snumber_enable_startup = 1
nnoremap <silent> <Leader>n :SNumbersToggleRelative<CR>

" vim-ruby
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_operators = 1
let g:ruby_space_errors = 1

" Clighter
function! Hook_on_post_source_clighter()
    hi m_decl cterm=bold
    " hi link clighterMacroInstantiation Define
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

let g:clighter_autostart = 0
let g:clighter_occurrences_mode = 0
let g:clighter_libclang_file = '/usr/local/lib/libclang.so'
if filereadable(g:clighter_libclang_file) == 0
    let g:clighter_libclang_file = '/usr/lib/libclang.so'
endif

" Casetrate
let g:casetrate_leader = '<leader>a'

" argwrap
nnoremap <silent> <leader>aw :call argwrap#toggle()<CR>

" c-prototype
let g:c_prototype_no_default_keymappings = 1
let g:c_prototype_remove_var_name = 1
let g:c_prototype_insert_point = 2

" vim-markdown
let g:vim_markdown_conceal = 0

" previm
let g:previm_show_header = 0

" vim-trailing-whitespace
let g:extra_whitespace_ignored_filetypes = [ 'vimfiler', 'unite', 'help']

" vim-gitgutter
let g:gitgutter_map_keys = 0

" vimtex
let g:vimtex_latexmk_continuous = 0
let g:vimtex_index_split_pos    = 'vertical rightbelow'
let g:vimtex_index_split_width  = 35
" let g:vimtex_fold_enabled = 1
if has('unix')
    let g:vimtex_view_general_viewer = 'evince'
endif

" textobj-sentence
let g:textobj#sentence#select = 'n'

" Parenmatch
let g:parenmatch_highlight = 0
hi link ParenMatch MatchParen


"-------------------------------------------------------------------------------"
" autocmd for plugin.
"-------------------------------------------------------------------------------"
" for lightline
function! s:update_syntastic()
    if &filetype == 'scala'
        return
    endif

    if 0 == dein#is_sourced('syntastic')
        call dein#source('syntastic')
    endif
    SyntasticCheck
    call lightline#update()
endfunction

" Depending on some plugins.
augroup plugin
    autocmd!

    " VimFiler
    autocmd FileType vimfiler call s:config_vimfiler()

    " textobj-sentence
    autocmd FileType txt,markdown,tex call dein#source(['vim-textobj-sentence']) || :call textobj#sentence#init()

    " Unite
    autocmd FileType unite call s:on_exe_unite()

    " Java
    autocmd CompleteDone *.java call javaapi#showRef()

    " lightline
    autocmd BufWritePost * call s:update_syntastic()

    " To avoid mess indent in perl.
    autocmd BufWinEnter *.pl nested :RainbowToggleOff
    autocmd BufWinLeave *.pl nested :RainbowToggleOn
augroup END

syntax enable
colorscheme mopkai  " It should be after entax command.
