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

" Appearance.
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
set foldtext=Mopp_gen_fold_text()

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
set dictionary=/usr/share/dict/words
set formatoptions+=tjrol
set helplang=ja
set langnoremap
set lazyredraw
set matchpairs+=<:>
set mouse=
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


"---------------------------------------------------------------------------"
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
"---------------------------------------------------------------------------"

" Set <Leader> and <LocalLeader>.
let g:mapleader      = ' '
let g:maplocalleader = '\'

noremap j gj
noremap k gk
noremap ; :
noremap : ;

" Avoiding getting <NUL> from <C-Space>.
map <NUL> <C-Space>
map! <NUL> <C-Space>

" Movings.
noremap! <C-A> <Home>
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
noremap <BS> ^
noremap <C-L> $

" Switching buffer.
nnoremap <silent> [B :<C-U>bfirst<CR>
nnoremap <silent> ]B :<C-U>blast<CR>
nnoremap <silent> [b :<C-U>bprevious<CR>
nnoremap <silent> ]b :<C-U>bnext<CR>

" Managing location list.
nnoremap <silent> [o :lprevious<CR>
nnoremap <silent> ]o :lnext<CR>
nnoremap <silent> [O :<C-u>lfirst<CR>
nnoremap <silent> ]O :<C-u>llast<CR>

" Managing tab.
nnoremap <Leader>to :tabnew<Space>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>j gT
nnoremap <Leader>k gt

" Spliting window.
nnoremap <Leader>sp :split<Space>
nnoremap <Leader>vsp :vsplit<Space>

" Changing window size.
noremap <silent> <S-Left>  :<C-U>wincmd <<CR>
noremap <silent> <S-Right> :<C-U>wincmd ><CR>
noremap <silent> <S-Up>    :<C-U>wincmd -<CR>
noremap <silent> <S-Down>  :<C-U>wincmd +<CR>

" Yank & Paste
function! s:paste_with_register(register, paste_type, paste_cmd) abort
    let reg_type = getregtype(a:register)
    let store = getreg(a:register)
    call setreg(a:register, store, a:paste_type)
    exe 'normal "' . a:register . a:paste_cmd
    call setreg(a:register, store, reg_type)
endfunction

function! s:copy_to_clipboard() abort
    let store = @@
    silent normal gvy
    let selected = @@
    let @@ = store

    let @+ = selected
    let @* = selected
endfunction

nnoremap Y y$
nnoremap <silent> <Leader>pp :set paste!<CR>
xnoremap <silent> mY  :<C-U>call <SID>copy_to_clipboard()<CR>
nnoremap <silent> mlp :<C-U>call <SID>paste_with_register('+', 'l', 'p')<CR>
nnoremap <silent> mlP :<C-U>call <SID>paste_with_register('+', 'l', 'P')<CR>
nnoremap <silent> mcp :<C-U>call <SID>paste_with_register('+', 'c', 'p')<CR>
nnoremap <silent> mcP :<C-U>call <SID>paste_with_register('+', 'c', 'P')<CR>
nnoremap <silent> mp  :<C-U>call <SID>paste_with_register('+', 'l', 'p')<CR>

" Open help of a word under the cursor.
nnoremap <silent> <Leader>h :help <C-R><C-W><CR>
nnoremap <silent> <Leader>ht :tab help <C-R><C-W><CR>

" Adding blank lines.
nnoremap <silent> <CR>      :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor<CR>
nnoremap <silent> <Leader>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" Change current directory of current window.
nnoremap <silent> <Leader>cd :<C-u>lcd %:p:h<CR>

" Open list if there are multiple tags.
nnoremap <C-]> g<C-]>zz

" Repeat the previous macro.
nnoremap Q @@

" Search something in the current visual range only.
vnoremap <M-/> <Esc>/\%V

" Replace the all selected areas.
vnoremap <C-r> "hy:%s/\V<C-r>h//g<left><left>

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent> <Leader>w :<C-u>write<CR>
if has('nvim')
    nnoremap <silent> <Leader>ev :<C-u>tab drop $MYVIMRC<CR>
else
    nnoremap <silent> <Leader>ev :<C-u>tabnew $MYVIMRC<CR>
endif


"----------------------------------------------------------------------------"
" Functions
"----------------------------------------------------------------------------"
function! Mopp_gen_fold_text() abort
    let head = '+' . repeat('-', &shiftwidth * v:foldlevel - 2) . ' ' . substitute(getline(v:foldstart), '^\s*', '', '')
    let tail = printf('[ %2d Lines Lv%02d ]', (v:foldend - v:foldstart + 1), v:foldlevel)
    let num_spaces = (winwidth(0) - &foldcolumn - strdisplaywidth(head) - strdisplaywidth(tail) - 1) - (&number ? max([&numberwidth, strdisplaywidth(line('$'))]) : 0)
    return join([head, repeat(' ', num_spaces), tail], '')
endfunction

function! s:remove_tail_spaces() abort
    if &filetype == 'markdown'
        return
    endif

    let c = getpos('.')
    g/.*\s$/normal $gelD
    call setpos('.', c)
endfunction


"----------------------------------------------------------------------------"
" Commands
"----------------------------------------------------------------------------"
command! SpellCheckToggle :setlocal spell!

" Echo highlight name of an object under the cursor.
command! EchoHiID echomsg synIDattr(synID(line('.'), col('.'), 1), 'name')

" TODO
let s:dec_hex_map = { '0' : '0000', '1' : '0001', '2' : '0010', '3' : '0011',
            \ '4' : '0100', '5' : '0101', '6' : '0110', '7' : '0111',
            \ '8' : '1000', '9' : '1001', 'a' : '1010', 'b' : '1011',
            \ 'c' : '1100', 'd' : '1101', 'e' : '1110', 'f' : '1111' }
function! s:to_bin(number) abort
    return join(map(split(printf('%x', a:number), '\zs'), 's:dec_hex_map[v:val]'), ' ')
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

function! s:str2number_if_possible(str) abort
    return (match(a:str, '[^0-9]') == -1) ? str2nr(a:str) : a:str
endfunction

function! s:tab_buffer(buf) abort
    let b = s:str2number_if_possible(a:buf)

    if bufexists(b) == 0
        echoerr string(b) . ' NOT exists buffer'
        return
    endif

    silent execute 'tab sbuffer ' . b
endfunction
command! -nargs=1 -complete=buffer TabBuffer :call <SID>tab_buffer(<q-args>)

function! s:drop_buffer(buf) abort
    let b = s:str2number_if_possible(a:buf)

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


"----------------------------------------------------------------------------"
" GUI
"----------------------------------------------------------------------------"
if has('gui_running')
    let no_buffers_menu = 1
    set guioptions-=emTrlL
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


"----------------------------------------------------------------------------"
" autocmd
"----------------------------------------------------------------------------"
augroup mopp
    autocmd!

    " Reload .vimrc
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

    " Turning off paste when escape insert mode.
    autocmd InsertLeave * setlocal nopaste

    " Store and load view.
    autocmd BufWinLeave * if (bufname('%') != '') | mkview!          | endif
    autocmd BufWinEnter * if (bufname('%') != '') | silent! loadview | endif

    " Remove spaces at tail.
    autocmd BufWritePre * silent call s:remove_tail_spaces()

    " Filetype local settings.
    autocmd FileType git  setlocal nofoldenable
    autocmd FileType lisp setlocal nocindent nosmartindent lisp lispwords=define
    autocmd FileType tex  setlocal wrap spell nocursorline
    autocmd FileType text setlocal wrap
    autocmd FileType help setlocal foldcolumn=0

    " Detecting filetypes.
    autocmd BufWinEnter *.nas                nested setlocal filetype=nasm
    autocmd BufWinEnter *.plt                nested setlocal filetype=gnuplot
    autocmd BufWinEnter *.sh                 nested setlocal filetype=sh
    autocmd BufWinEnter *.toml               nested setlocal filetype=toml
    autocmd BufWinEnter *.{md,mdwn,mkd,mkdn} nested setlocal filetype=markdown
    autocmd BufWinEnter *.{pde,ino}          nested setlocal filetype=arduino
augroup END


"----------------------------------------------------------------------------"
" neovim.
"----------------------------------------------------------------------------"
if has('nvim')
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

    command! ToggleTerminaMap call <SID>toggle_terminal_map()

    tnoremap <ESC> <C-\><C-n>
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l
    nnoremap <Leader>tm :terminal<CR>
    nnoremap <Leader>vst :vsplit term://zsh<CR>
endif


"----------------------------------------------------------------------------"
" Plugin
"----------------------------------------------------------------------------"
let s:DEIN_BASE_PATH = '~/.vim/bundle/'
let s:DEIN_PATH      = expand(s:DEIN_BASE_PATH . 'repos/github.com/Shougo/dein.vim')
if !isdirectory(s:DEIN_PATH)
    let answer = confirm('Would you like to download all plugins ?', "&Yes\n&No", 2)
    if (answer == 1) && (executable('git') == 1)
        execute '!git clone --depth=1 https://github.com/Shougo/dein.vim' s:DEIN_PATH
    else
        set number
        syntax enable
        colorscheme desert
        finish
    endif
endif

" dein.vim
execute 'set runtimepath+=' . s:DEIN_PATH

if dein#load_state(s:DEIN_BASE_PATH)
    call dein#begin(s:DEIN_BASE_PATH)

    call dein#add('Shougo/dein.vim')
    call dein#add('haya14busa/dein-command.vim')

    call dein#add('Shougo/deoplete.nvim', { 'lazy': 1, 'on_event': 'InsertEnter', 'if': has('nvim') })
    call dein#add('Shougo/neocomplete.vim', { 'lazy': 1, 'on_event': 'InsertEnter', 'if': (has('lua') && !has('nvim')) })

    let common_opt = { 'lazy': 1, 'on_source': [ 'deoplete.nvim', 'neocomplete.vim' ] }
    call dein#add('Shougo/neco-syntax')
    call dein#add('Shougo/neco-vim', common_opt)
    call dein#add('Shougo/neoinclude.vim', common_opt)
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('Shougo/neosnippet.vim', common_opt)
    call dein#add('fishbullet/deoplete-ruby')
    call dein#add('honza/vim-snippets', common_opt)
    call dein#add('zchee/deoplete-jedi')
    call dein#add('ujihisa/neco-look')
    call dein#add('racer-rust/vim-racer')

    call dein#add('Shougo/denite.nvim', { 'lazy': 1, 'on_func': 'denite', 'on_cmd': 'Denite', 'hook_post_source': 'call Hook_post_source_denite()'})
    call dein#add('Shougo/neoyank.vim')
    call dein#add('Shougo/unite-outline')
    call dein#add('Shougo/unite.vim', { 'lazy': 1, 'on_source': 'denite.nvim' })
    call dein#add('Shougo/vimfiler.vim')
    call dein#add('kmnk/vim-unite-giti', { 'lazy': 1, 'on_source': 'unite.vim' })
    call dein#add('lambdalisue/unite-grep-vcs')
    call dein#add('osyo-manga/unite-quickfix')

    call dein#add('haya14busa/vim-operator-flashy', { 'lazy': 1, 'on_map': [ [ 'nx', '<Plug>' ] ] })
    call dein#add('kana/vim-operator-replace', { 'lazy': 1, 'on_map': [ [ 'nx', '<Plug>' ] ] })
    call dein#add('kana/vim-operator-user')
    call dein#add('tommcdo/vim-exchange', { 'lazy': 1, 'on_map': [ [ 'nx', '<Plug>(Exchange)', '<Plug>(ExchangeClear)', '<Plug>(ExchangeLine)' ] ]})
    call dein#add('tyru/operator-camelize.vim', { 'lazy': 1, 'on_map': [ [ 'nx', '<Plug>' ] ] })

    call dein#add('kana/vim-textobj-function', { 'lazy': 1, 'on_map': [ [ 'ox', 'af', 'if', 'aF', 'iF' ] ] })
    call dein#add('kana/vim-textobj-indent', { 'lazy': 1, 'on_map':  [ [ 'ox', 'ai' , 'ii' , 'aI',  'iI' ] ] })
    call dein#add('kana/vim-textobj-line', { 'lazy': 1, 'on_map': [ [ 'ox', 'al', 'il' ] ] })
    call dein#add('kana/vim-textobj-user')
    call dein#add('reedes/vim-textobj-sentence', { 'lazy': 1 })
    call dein#add('rhysd/vim-textobj-word-column', { 'lazy': 1, 'on_map': [ [ 'ox', 'av', 'iv' ] ] })
    call dein#add('sgur/vim-textobj-parameter', { 'lazy': 1, 'on_map': [ [ 'ox', 'a,', 'i,', 'i2,' ] ] })

    call dein#add('machakann/vim-sandwich')

    call dein#add('Chiel92/vim-autoformat', { 'lazy': 1, 'on_cmd': 'Autoformat' })
    call dein#add('FooSoft/vim-argwrap', { 'lazy': 1, 'on_func': 'argwrap' })
    call dein#add('Konfekt/FastFold')
    call dein#add('LeafCage/yankround.vim')
    call dein#add('Shougo/echodoc.vim', { 'lazy': 1, 'on_event': 'InsertEnter'})

    call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
    call dein#add('Shougo/vinarise.vim', { 'on_cmd': 'Vinarise' })
    call dein#add('Yggdroot/indentLine')
    call dein#add('airblade/vim-gitgutter', { 'lazy': 1, 'on_event': 'BufWritePost' })
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('easymotion/vim-easymotion')
    call dein#add('godlygeek/tabular', { 'lazy': 1, 'on_cmd': [ 'Tabularize', 'AddTabularPattern' ] })
    call dein#add('idanarye/vim-casetrate', { 'lazy': 1, 'on_cmd': 'Casetrate' })
    call dein#add('inside/vim-search-pulse')
    call dein#add('itchyny/lightline.vim')
    call dein#add('itchyny/vim-parenmatch')
    call dein#add('junegunn/vim-easy-align', { 'lazy': 1, 'on_cmd': 'EasyAlign', 'on_map': [ [ 'nv', '<Plug>(LiveEasyAlign)', '<Plug>(EasyAlign)' ] ] })
    call dein#add('kana/vim-niceblock', { 'lazy': 1, 'on_map': [ [ 'x', 'I', 'A' ] ] })
    call dein#add('kana/vim-smartchr')
    call dein#add('kana/vim-smartinput', { 'lazy': 1, 'on_event': 'InsertEnter', 'hook_post_source': 'call Hook_on_post_source_smartinput()'})
    call dein#add('kannokanno/previm', { 'lazy': 1, 'on_cmd': 'PrevimOpen', 'on_ft': 'markdown' })
    call dein#add('luochen1990/rainbow')
    call dein#add('majutsushi/tagbar', { 'lazy': 1, 'on_cmd': 'TagbarToggle' })
    call dein#add('mattn/benchvimrc-vim', { 'lazy': 1, 'on_cmd': 'BenchVimrc' })
    call dein#add('mattn/gist-vim', { 'lazy': 1, 'on_cmd': 'Gist' })
    call dein#add('mattn/learn-vimscript')
    call dein#add('mattn/webapi-vim')
    call dein#add('mopp/DoxyDoc.vim', { 'lazy': 1, 'on_cmd': [ 'DoxyDoc', 'DoxyDocAuthor' ] })
    call dein#add('mopp/autodirmake.vim', { 'lazy': 1, 'on_event': 'InsertEnter' })
    call dein#add('mopp/layoutplugin.vim', { 'lazy': 1, 'on_cmd': 'LayoutPlugin' })
    call dein#add('mopp/learn-markdown.vim')
    call dein#add('mopp/mopkai.vim')
    call dein#add('mopp/next-alter.vim', { 'lazy': 1, 'on_cmd': 'OpenNAlter', 'on_map' : [ [ 'n', '<Plug>(next-alter-open)' ] ] })
    call dein#add('mopp/smartnumber.vim')
    call dein#add('osyo-manga/vim-anzu', { 'lazy': 1, 'on_map': [ [ 'n', '<Plug>' ] ] })
    call dein#add('osyo-manga/vim-marching', { 'lazy': 1, 'on_ft': [ 'c', 'cpp' ] })
    call dein#add('osyo-manga/vim-stargate', { 'lazy': 1, 'on_cmd': 'StargateInclude' })
    call dein#add('rickhowe/diffchar.vim', { 'lazy':  &diff == 0, 'on_if': '&diff' })
    call dein#add('scrooloose/nerdcommenter', { 'lazy': 1, 'on_map': [ [ 'nx', '<Plug>NERDCommenter' ] ], 'hook_post_source': 'doautocmd NERDCommenter BufEnter'})
    call dein#add('scrooloose/syntastic', { 'lazy': 1, 'on_event': 'InsertEnter' })
    call dein#add('sk1418/blockit', { 'lazy': 1, 'on_cmd': 'Block', 'on_map': [ [ 'x', '<Plug>BlockitVisual' ] ] })
    call dein#add('thinca/vim-visualstar')
    call dein#add('tpope/vim-repeat')
    call dein#add('tyru/open-browser.vim', { 'lazy': 1, 'on_map': [ [ 'n', '<Plug>(openbrowser-open)' ] ], 'on_func': 'openbrowser' })

    call dein#add('Shirk/vim-gas')
    call dein#add('cespare/vim-toml')
    call dein#add('derekwyatt/vim-scala')
    call dein#add('digitaltoad/vim-pug')
    call dein#add('hail2u/vim-css3-syntax')
    call dein#add('othree/html5.vim')
    call dein#add('pangloss/vim-javascript')
    call dein#add('plasticboy/vim-markdown')
    call dein#add('rust-lang/rust.vim')
    call dein#add('shima-529/C-prototype.vim', { 'lazy': 1, 'on_ft': 'c' })
    call dein#add('thinca/vim-ft-help_fold')
    call dein#add('vim-jp/cpp-vim')
    call dein#add('vim-jp/vimdoc-ja')
    call dein#add('vim-ruby/vim-ruby')
    call dein#add('vim-scripts/sh.vim--Cla')

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on

" deoplete.nvim
if dein#tap('deoplete.nvim') && has('nvim')
    let g:deoplete#enable_at_startup  = 1
    let g:deoplete#omni_patterns      = {}
    let g:deoplete#omni_patterns.c    = '[^. *\t](\.|->)\w*'
    let g:deoplete#omni_patterns.cpp  = '[^. *\t](\.|->|::)\w*'
endif

" neocomplete.vim
if dein#tap('neocomplete.vim') && !has('nvim')
    let g:neocomplete#enable_at_startup            = 1
    let g:neocomplete#enable_cursor_hold_i         = 1
    let g:neocomplete#enable_insert_char_pre       = 1
    let g:neocomplete#enable_auto_delimiter        = 1
    let g:neocomplete#lock_buffer_name_pattern     = '^zsh.*'
    let g:neocomplete#enable_prefetch              = 1

    " Call omni function directly
    let g:neocomplete#force_overwrite_completefunc     = 1
    let g:neocomplete#force_omni_input_patterns        = get(g:, 'neocomplete#force_omni_input_patterns', {})
    let g:neocomplete#force_omni_input_patterns.c      = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#force_omni_input_patterns.cpp    = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#force_omni_input_patterns.objc   = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#force_omni_input_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#force_omni_input_patterns.ruby   = '[^. *\t]\.\w*\|\h\w*::'

    let g:neocomplete#same_filetypes     = get(g:, 'neocomplete#same_filetypes', {})
    let g:neocomplete#same_filetypes.c   = 'cpp'
    let g:neocomplete#same_filetypes.cpp = 'c'

    let g:neocomplete#text_mode_filetypes           = get(g:, 'neocomplete#text_mode_filetypes', {})
    let g:neocomplete#text_mode_filetypes.markdown  = 1
    let g:neocomplete#text_mode_filetypes.gitcommit = 1
    let g:neocomplete#text_mode_filetypes.text      = 1
    let g:neocomplete#text_mode_filetypes.txt       = 1

    let g:neocomplete#delimiter_patterns     = get(g:, 'neocomplete#delimiter_patterns', {})
    let g:neocomplete#delimiter_patterns.vim = [ '#', '.' ]
    let g:neocomplete#delimiter_patterns.cpp = [ '::' ]
    let g:neocomplete#delimiter_patterns.c   = [ '.' ]

    let g:neocomplete#skip_auto_completion_time = ''
    let g:neocomplete#fallback_mappings = ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]

    let g:neocomplete#sources#vim#complete_functions          = get(g:, 'neocomplete#sources#vim#complete_functions', {})
    let g:neocomplete#sources#vim#complete_functions.Vinarise = 'vinarise#complete'

    inoremap <expr> <C-g><C-c> neocomplete#undo_completion()
    inoremap <expr> <C-l> neocomplete#complete_common_string()
endif

" neosnippet.vim
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)
xmap <C-s> <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['stylus'] = 'stylus,css,scss'
let g:neosnippet#scope_aliases['pug'] = 'jade'

" denite.nvim
nnoremap [Denite] <Nop>
nmap <Leader>f [Denite]
nnoremap <silent> [Denite]re :<C-u>Denite -resume<CR>
nnoremap <silent> [Denite]b  :<C-u>Denite buffer<CR>
nnoremap <silent> [Denite]f  :<C-u>Denite file_rec<CR>
nnoremap <silent> [Denite]gg :<C-u>Denite grep<CR>
nnoremap <silent> [Denite]gw :<C-u>DeniteCursorWord grep<CR>
nnoremap <silent> [Denite]l  :<C-u>Denite line<CR>
nnoremap <silent> [Denite]gi :<C-u>Denite unite:giti<CR>
nnoremap <silent> [Denite]o  :<C-u>Denite unite:outline<CR>
nnoremap <silent> [Denite]q  :<C-u>Denite unite:quickfix -no-quit -direction=botright<CR>
nnoremap <silent> [Denite]s  :<C-u>Denite unite:source<CR>
nnoremap <silent> [Denite]t  :<C-u>Denite unite:tasklist<CR>

function! Hook_post_source_denite() abort
    call denite#custom#option('default', 'statusline', v:false)
    call denite#custom#option('default', 'vertical_preview', v:true)
    call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

    if executable('rg')
        " For ripgrep.
        call denite#custom#var('file_rec', 'command', [ 'rg', '--files', '--glob', '!.git' ])
        call denite#custom#var('grep', 'command', [ 'rg' ])
        call denite#custom#var('grep', 'default_opts', [ '--vimgrep', '--no-heading' ])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])
    elseif executable('hw')
        " For highway.
        call denite#custom#var('grep', 'command', [ 'hw' ])
        call denite#custom#var('grep', 'default_opts', [ '--no-group', '--no-color' ])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'separator', [])
    elseif executable('pt')
        " For the platinum searcher.
        call denite#custom#var('grep', 'command', [ 'pt' ])
        call denite#custom#var('grep', 'default_opts', [ '--nogroup', '--nocolor', '--smart-case', '--hidden' ])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'separator', [])
    endif
endfunction

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_force_overwrite_statusline = 0
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent> <Leader>fvs :<C-u>VimFiler -explorer -find<CR>
nnoremap <silent> <Leader>fvo :<C-u>VimFiler -tab<CR>
nnoremap <silent> <Leader>fvb :<C-u>VimFilerBufferDir -explorer<CR>
function! s:config_vimfiler()
    nnoremap <silent><buffer><expr> <C-t> vimfiler#do_action('tabopen')
endfunction

" vim-operator-flashy
map y <Plug>(operator-flashy)
map Y <Plug>(operator-flashy)$
let g:operator#flashy#group = 'Error'

" operator-replace
map _ <Plug>(operator-replace)

" vim-exchange
nmap <Leader>cx <Plug>(Exchange)
xmap <Leader>X <Plug>(Exchange)
nmap <Leader>cxc <Plug>(ExchangeClear)
nmap <Leader>cxx <Plug>(ExchangeLine)

" operator-camelize.vim
map <Leader>ca <Plug>(operator-camelize-toggle)

" textobj-sentence
let g:textobj#sentence#select = 'n'

" vim-argwrap
nnoremap <silent> <leader>aw :<C-u>call argwrap#toggle()<CR>

" yankround.vim
let g:yankround_use_region_hl = 1
let g:yankround_region_hl_groupname = 'Error'
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" echodoc.vim
let g:echodoc_enable_at_startup = 1

" vim-gitgutter
let g:gitgutter_map_keys = 0
nmap <Leader>gn <Plug>GitGutterPrevHunk
nmap <Leader>gp <Plug>GitGutterNextHunk
nmap <Leader>gs <Plug>GitGutterStageHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk
nmap <Leader>gv <Plug>GitGutterPreviewHunk

" vim-trailing-whitespace
let g:extra_whitespace_ignored_filetypes = [ 'denite', 'help']

" vim-easymotion
map <Leader>e <Plug>(easymotion-prefix)

" vim-casetrate
let g:casetrate_leader = '<leader>a'

" lightline.vim
let g:lightline = {
            \ 'colorscheme': 'mopkai',
            \ 'active': {
            \   'left': [ [ 'mode', 'denite', 'paste' ], [ 'filename', 'modified' ], [ 'readonly', 'spell' ], ],
            \   'right': [ [ 'syntastic', 'fileencoding', 'fileformat', 'lineinfo', 'percent' ], [ 'filetype' ] ],
            \ },
            \ 'inactive': {
            \   'left': [ [ 'filename', 'modified' ] ],
            \   'right': [ [ 'filetype' ] ]
            \ },
            \ 'tabline': {
            \   'left': [ [ 'tabs' ]  ],
            \   'right': []
            \ },
            \ 'tab': {
            \   'active':   [ 'tabnum', 'filename', 'modified' ],
            \   'inactive': [ 'tabnum', 'filename', 'modified' ]
            \ },
            \ 'tabline_separator': { 'left': '', 'right': '' },
            \ 'tabline_subseparator': { 'left': '', 'right': '' },
            \ 'component': {
            \   'readonly':     "%{ (Lightline_is_visible() && &readonly) ? 'RO' : '' }",
            \   'filetype':     "%{ !Lightline_is_visible() ? '' : &filetype }",
            \   'fileencoding': "%{ !Lightline_is_visible() ? '' : (strlen(&fenc) ? &fenc : &enc) }",
            \   'fileformat':   "%{ !Lightline_is_visible() ? '' : &fileformat }",
            \   'lineinfo':     "%{ !Lightline_is_visible() ? '' : printf('%03d:%03d', line('.'), col('.')) }",
            \   'percent':      "%{ !Lightline_is_visible() ? '' : printf('%3d%%', float2nr((1.0 * line('.')) / line('$') * 100.0)) }",
            \ },
            \ 'component_visible_condition': {
            \   'filetype':     'Lightline_is_visible()',
            \   'fileencoding': 'Lightline_is_visible()',
            \   'fileformat':   'Lightline_is_visible()',
            \   'percent':      'Lightline_is_visible()',
            \ },
            \ 'component_function': {
            \   'mode':     'Lightline_mode',
            \   'denite':   'Lightline_denite',
            \   'modified': 'Lightline_modified',
            \   'filename': 'Lightline_filename',
            \ },
            \ 'component_expand': { 'syntastic' : 'SyntasticStatuslineFlag', },
            \ 'component_type'  : { 'syntastic' : 'error', }
            \ }

let g:lightline_invisible_filetype_pattern = 'vimfiler\|tagbar\|denite\|help'

function! Lightline_is_visible() abort
    return (&filetype !~? g:lightline_invisible_filetype_pattern) && (60 <= winwidth(0))
endfunction

function! Lightline_mode() abort
    if &filetype == 'denite'
        return 'Denite'
    elseif &filetype == 'vimfiler'
        return winwidth(0) <= 35 ?  '' : 'VimFiler'
    elseif &filetype == 'tagbar'
        return 'Tagbar'
    endif

    return lightline#mode()
endfunction

function! Lightline_modified() abort
    return ((&filetype =~? g:lightline_invisible_filetype_pattern) || (&modifiable == 0)) ? ('') : (&modified ? '[+]' : '[-]')
endfunction

function! Lightline_denite() abort
    return (&filetype != 'denite') ? '' : (substitute(denite#get_status_mode(), '[- ]', '', 'g'))
endfunction

function! Lightline_filename() abort
    if &filetype == 'denite'
        return denite#get_status_sources() . denite#get_status_path() . denite#get_status_linenr()
    elseif &filetype == 'tagbar'
        return g:lightline.fname
    endif

    return '' != expand('%:t') ? expand('%:t') : '[No Name]'
endfunction

let s:p = {
            \ 'normal': {
            \   'left':    [ [ '#080808', '#00afff', 232,  39 ], [ '#9e9e9e', '#080808', 247, 232 ], [ '#d70000', '#080808', 160, 232 ] ],
            \   'middle':  [ [ '#9e9e9e', '#303030', 247, 236 ] ],
            \   'right':   [ [ '#9e9e9e', '#080808', 247, 237 ], [ '#875fd7', '#080808',  98, 232 ] ],
            \   'warning': [ [ '#9e9e9e', '#ffdf5f', 247, 221 ] ],
            \   'error':   [ [ '#eeeeee', '#d70000', 255, 160 ] ]
            \ },
            \ 'insert': {
            \   'left':   [ [ '#080808', '#87ff00', 232, 118 ], [ '#9e9e9e', '#080808', 247, 232 ], [ '#d70000', '#080808', 160, 232 ] ],
            \ },
            \ 'replace': {
            \   'left':   [ [ '#080808', '#ff0087', 232, 198 ], [ '#9e9e9e', '#080808', 247, 232 ], [ '#d70000', '#080808', 160, 232 ] ],
            \ },
            \ 'visual': {
            \   'left':   [ [ '#080808', '#d7ff5f', 232, 191 ], [ '#9e9e9e', '#080808', 247, 232 ], [ '#d70000', '#080808', 160, 232 ] ],
            \ },
            \ 'inactive': {
            \   'left':   [ [ '#9e9e9e', '#080808', 247, 232 ] ],
            \   'middle': [ [ '#9e9e9e', '#303030', 247, 236 ] ],
            \   'right':  [ [ '#875fd7', '#080808',  98, 232 ] ]
            \ },
            \ 'tabline': {
            \   'tabsel': [ [ '#080808', '#ff0087', 232, 198 ] ],
            \   'left':   [ [ '#080808', '#c6c6c6', 232, 251 ] ],
            \   'middle': [ [ '#080808', '#c6c6c6', 232, 251 ] ],
            \   'right':  [ [ '#080808', '#c6c6c6', 232, 251 ] ],
            \ }
            \ }
let g:lightline#colorscheme#mopkai#palette = s:p

" vim-parenmatch
let g:parenmatch_highlight = 0
hi link ParenMatch MatchParen

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-smartinput
function! Hook_on_post_source_smartinput() abort
    call smartinput#map_to_trigger('i', '<Space>', '<Space>', '<Space>')
    call smartinput#define_rule({ 'char' : '<Space>', 'at' : '(\%#)', 'input' : '<Space><Space><Left>'})

    let lst = [
                \ ['<',     "smartchr#loop(' < ', ' << ', '<')" ],
                \ ['>',     "smartchr#loop(' > ', ' >> ', ' >>> ', '>')"],
                \ ['+',     "smartchr#loop(' + ', '++', '+')"],
                \ ['-',     "smartchr#loop(' - ', '--', '-')"],
                \ ['/',     "smartchr#loop(' / ', '//', '/')"],
                \ ['&',     "smartchr#loop(' & ', ' && ', '&')"],
                \ ['%',     "smartchr#loop(' % ', '%')"],
                \ ['*',     "smartchr#loop(' * ', '*')"],
                \ ['<Bar>', "smartchr#loop(' | ', ' || ', '|')"],
                \ [',',     "smartchr#loop(', ', '->', ' => ')"]
                \ ]

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

" previm
let g:previm_show_header = 0

" rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
            \   'guifgs' : [ '#666666', '#0087ff', '#ff005f', '#875fd7', '#d78700', '#00af87' ],
            \   'ctermfgs': [ '242', '33', '197', '98', '172', '36' ],
            \   'separately' : {
            \       '*':   {},
            \       'vim': {},
            \       'css': 0,
            \       'perl': 0,
            \   },
            \   }

" tagBar
let g:tagbar_autoshowtag = 1
let g:tagbar_autofocus   = 1
let g:tagbar_sort        = 0
let g:tagbar_compact     = 1
nnoremap <silent> <Leader>tb :<C-U>TagbarToggle<CR>

function! Tagbar_status_func(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction
let g:tagbar_status_func = 'Tagbar_status_func'

" gist-vim
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" layoutplugin.vim
let g:layoutplugin#is_append_vimrc = 1

" next-alter.vim
nmap <Leader>an <Plug>(next-alter-open)
let g:next_alter#search_dir = [ './include', '.' , '..', '../include' ]

" smartnumber.vim
let g:snumber_enable_startup = 1
nnoremap <silent> <Leader>n :SNumbersToggleRelative<CR>

" mopkai.vim
let g:mopkai_is_not_set_normal_ctermbg = or(!has('mac'), ($USER != 'mopp'))

" vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" vim-marching
let g:marching_enable_neocomplete = 1

" NERDCommenter
let g:NERDSpaceDelims = 1
nmap <Leader><Leader> <Plug>NERDCommenterToggle
xmap <Leader><Leader> <Plug>NERDCommenterToggle
vmap <Leader>cb <Plug>NERDCommenterNested
nmap <Leader>cs <plug>NERDCommenterSexy
vmap <Leader>cs <plug>NERDCommenterSexy

" syntastic
let g:syntastic_mode_map = { 'mode' : 'passive' }
let op = '-Wall -Wextra -Wconversion -Wno-unused-parameter -Wno-sign-compare -Wno-pointer-sign -Wcast-qual'
let is_clang = executable('clang')
let g:syntastic_c_compiler           = ((is_clang == 0) ? 'gcc' : 'clang')
let g:syntastic_cpp_compiler         = ((is_clang == 0) ? 'g++' : 'clang++')
let g:syntastic_c_compiler_options   = ($USER == 'mopp' ? '-std=c11 ' : '') . op
let g:syntastic_cpp_compiler_options = ($USER == 'mopp' ? '-std=c++14 ' : '') . op
let g:syntastic_loc_list_height      = 5

" blockit
vmap <Leader>tt <Plug>BlockitVisual

" open-browser.vim
map <Leader>op <Plug>(openbrowser-open)

" vim-matlab
let g:matlab_auto_mappings = 0

" vim-markdown
let g:vim_markdown_conceal = 0

" c-prototype
let g:c_prototype_no_default_keymappings = 1
let g:c_prototype_remove_var_name = 1
let g:c_prototype_insert_point = 2

" vim-ruby
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_operators = 1
let g:ruby_space_errors = 1

" vim-autoformat
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']
let g:formatdef_scalafmt = '"scalafmt"'
let g:formatters_scala = ['scalafmt']

"----------------------------------------------------------------------------"
" autocmd for plugin
"----------------------------------------------------------------------------"
function! s:update_syntastic() abort
    if &filetype == 'scala'
        return
    endif

    if dein#is_sourced('syntastic') == 0
        call dein#source('syntastic')
    endif
    SyntasticCheck
    call lightline#update()
endfunction

augroup plugin
    autocmd!

    autocmd VimEnter * call dein#call_hook('post_source')
    autocmd FileType txt,markdown,tex call dein#source(['vim-textobj-sentence']) || :call textobj#sentence#init()
    autocmd BufWritePost * call s:update_syntastic()
    autocmd FileType vimfiler call s:config_vimfiler()
augroup END

syntax enable
colorscheme mopkai  " It should be after entax command.
