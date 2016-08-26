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
set confirm
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

" Avoiding getting <NUL> from <C-Space>
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
noremap <Leader>to :tabnew<Space>
noremap <Leader>tc :tabclose<CR>
noremap <Leader>j gT
noremap <Leader>k gt

" Spliting window.
noremap <Leader>sp :split<Space>
noremap <Leader>vsp :vsplit<Space>

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
xnoremap <silent> <C-Space>  :<C-U>call <SID>copy_to_clipboard()<CR>
nnoremap <silent> <Leader>lp :<C-U>call <SID>paste_with_register(v:register, 'l', 'p')<CR>
nnoremap <silent> <Leader>lP :<C-U>call <SID>paste_with_register(v:register, 'l', 'P')<CR>
nnoremap <silent> <Leader>cp :<C-U>call <SID>paste_with_register(v:register, 'c', 'p')<CR>
nnoremap <silent> <Leader>cP :<C-U>call <SID>paste_with_register(v:register, 'c', 'P')<CR>
nnoremap <silent> mlp :<C-U>call <SID>paste_with_register('*', 'l', 'p')<CR>
nnoremap <silent> mlP :<C-U>call <SID>paste_with_register('*', 'l', 'P')<CR>
nnoremap <silent> mcp :<C-U>call <SID>paste_with_register('*', 'c', 'p')<CR>
nnoremap <silent> mcP :<C-U>call <SID>paste_with_register('*', 'c', 'P')<CR>
nnoremap <silent> mp  :<C-U>call <SID>paste_with_register('*', 'l', 'p')<CR>

" Open help of a word under the cursor.
nnoremap <silent> <Leader>h :help <C-R><C-W><CR>
nnoremap <silent> <Leader>ht :tab help <C-R><C-W><CR>

" Change current directory of current window.
nnoremap <Leader>cd :lcd %:p:h<CR>

" Turning off highlight of search resutls.
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" Adding blank lines.
nnoremap <silent> <CR>      :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor<CR>
nnoremap <silent> <Leader>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" Open list if there are multiple tags.
nnoremap <C-]> g<C-]>zz

" Repeat the previous macro.
nnoremap Q @@

nnoremap <Leader>w :write<CR>


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

" if dein#load_state(s:DEIN_BASE_PATH)
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

    call dein#add('Shougo/unite.vim', { 'lazy': 1, 'on_func': 'unite', 'on_cmd': 'Unite', 'hook_post_source': 'call Hook_post_source_unite()'})
    call dein#add('Shougo/unite-outline')
    call dein#add('junkblocker/unite-tasklist')
    call dein#add('kmnk/vim-unite-giti', { 'lazy': 1, 'on_source': 'unite.vim' })
    call dein#add('lambdalisue/unite-grep-vcs')
    call dein#add('osyo-manga/unite-quickfix')
    call dein#add('tsukkee/unite-tag')

    call dein#add('FooSoft/vim-argwrap', { 'lazy': 1, 'on_func': 'argwrap' })
    call dein#add('Konfekt/FastFold')
    call dein#add('LeafCage/yankround.vim')
    call dein#add('Shougo/echodoc.vim', { 'lazy': 1, 'on_event': 'InsertEnter'})
    call dein#add('Shougo/vimfiler.vim', { 'lazy' : 1, 'depends' : 'unite.vim', 'on_func' : 'vimfiler', 'on_cmd' : [ 'VimFiler', 'VimFilerBufferDir'], 'hook_post_source' : 'call Hook_post_source_vimfiler()' })
    call dein#add('Shougo/vimproc.vim', { 'build' : 'make' })
    call dein#add('Shougo/vinarise.vim', { 'on_cmd' : 'Vinarise' })
    call dein#add('Yggdroot/indentLine')
    call dein#add('airblade/vim-gitgutter', { 'lazy' : 1, 'on_event' : 'InsertEnter' })
    call dein#add('bronson/vim-trailing-whitespace')
    " call dein#add('easymotion/vim-easymotion')
    " call dein#add('godlygeek/tabular', { 'lazy' : 1, 'on_cmd' : [ 'Tabularize', 'AddTabularPattern' ] })
    " call dein#add('idanarye/vim-casetrate', { 'lazy' : 1, 'on_cmd' : 'Casetrate' })
    " call dein#add('itchyny/lightline.vim')
    " call dein#add('itchyny/vim-parenmatch')
    " call dein#add('junegunn/vim-easy-align', { 'lazy' : 1, 'on_cmd' : 'EasyAlign', 'on_map' : [ [ 'nv', '<Plug>(LiveEasyAlign)', '<Plug>(EasyAlign)' ] ] })
    " call dein#add('kana/vim-niceblock', { 'lazy' : 1, 'on_map' : [ [ 'x', 'I', 'A' ] ] })
    " call dein#add('kana/vim-smartchr')
    " call dein#add('kana/vim-smartinput', { 'lazy' : 1, 'on_event' : 'InsertEnter', 'hook_post_source' : 'call Hook_on_post_source_smartinput()'})
    " call dein#add('koron/nyancat-vim', { 'lazy''on_cmd' : [ 'Nyancat', 'Nyancat2' ] })
    " call dein#add('luochen1990/rainbow')
    " call dein#add('majutsushi/tagbar', { 'lazy' : 1, 'on_cmd' : 'TagbarToggle' })
    " call dein#add('mattn/benchvimrc-vim', { 'lazy' : 1, 'on_cmd' : 'BenchVimrc' })
    " call dein#add('mattn/gist-vim', { 'lazy' : 1, 'depends' : 'webapi-vim', 'on_cmd' : 'Gist' })
    " call dein#add('mattn/learn-vimscript')
    " call dein#add('mattn/webapi-vim')
    " call dein#add('mopp/DoxyDoc.vim', { 'lazy' : 1, 'on_cmd' : [ 'DoxyDoc', 'DoxyDocAuthor' ] })
    " call dein#add('mopp/autodirmake.vim', { 'lazy' : 1, 'on_event' : 'InsertEnter' })
    " call dein#add('mopp/battery.vim', { 'lazy' : 1, 'on_func' : 'battery', 'on_cmd' : 'Battery' })
    " call dein#add('mopp/layoutplugin.vim', { 'lazy' : 1, 'on_cmd' : 'LayoutPlugin' })
    " call dein#add('mopp/learn-markdown.vim')
    " call dein#add('mopp/makecomp.vim', { 'lazy' : 1, 'on_cmd' : 'Make' })
    " call dein#add('mopp/mopbuf.vim')
    call dein#add('mopp/mopkai.vim')
    " call dein#add('mopp/next-alter.vim', { 'lazy' : 1, 'on_cmd' : 'OpenNAlter', 'on_map'  : [ [ 'n', '<Plug>(next-alter-open)' ] ] })
    " call dein#add('mopp/openvimrc.vim' , { 'lazy' : 1, 'on_map' : [ [ 'n', '<Plug>(openvimrc-open)' ] ] })
    " call dein#add('mopp/smartnumber.vim')
    " call dein#add('osyo-manga/vim-anzu', { 'lazy' : 1, 'on_map' : [ [ 'n', '<Plug>' ] ] })
    " call dein#add('osyo-manga/vim-marching', { 'lazy' : 1, 'on_ft' : [ 'c', 'cpp' ] })
    " call dein#add('osyo-manga/vim-stargate', { 'lazy' : 1, 'on_cmd' : 'StargateInclude' } )
    " call dein#add('rhysd/vim-clang-format', { 'lazy' : 1, 'on_cmd' : [ 'ClangFormat', 'ClangFormatEchoFormattedCode' ] })
    " call dein#add('rickhowe/diffchar.vim')
    " call dein#add('scrooloose/nerdcommenter', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>NERDCommenter' ] ], 'hook_post_source' : 'doautocmd NERDCommenter BufEnter'})
    " call dein#add('scrooloose/syntastic', { 'lazy' : 1, 'on_event' : 'InsertEnter' })
    " call dein#add('set0gut1/previm', { 'lazy' : 1, 'on_cmd' : 'PrevimOpen', 'on_ft' : 'markdown' })
    " call dein#add('sk1418/blockit', { 'lazy' : 1, 'on_cmd' : 'Block', 'on_map' : [ [ 'x', '<Plug>BlockitVisual' ] ] })
    " call dein#add('sudo.vim', { 'lazy' : 1, 'on_cmd' : ['Sw', 'Swq']})
    " call dein#add('thinca/vim-visualstar')
    " call dein#add('tpope/vim-repeat')
    " call dein#add('tyru/open-browser.vim', { 'lazy' : 1, 'on_map' : [ [ 'n', '<Plug>(openbrowser-open)' ] ], 'on_func' : 'openbrowser' })

    " call dein#add('Nemo157/scala.vim', { 'lazy' : 1, 'on_ft' : 'scala' })
    " call dein#add('Shirk/vim-gas')
    " call dein#add('awk.vim')
    " call dein#add('bbchung/clighter', { 'lazy' : 1, 'on_ft' : [ 'c', 'cpp' ], 'hook_post_source' : 'call Hook_on_post_source_clighter()' })
    " call dein#add('cespare/vim-toml')
    " call dein#add('daeyun/vim-matlab')
    " call dein#add('digitaltoad/vim-pug')
    " call dein#add('gnuplot.vim')
    " call dein#add('jelera/vim-javascript-syntax')
    " call dein#add('lervag/vimtex')
    " call dein#add('othree/html5.vim')
    " call dein#add('pangloss/vim-javascript')
    " call dein#add('plasticboy/vim-markdown')
    " call dein#add('rust-lang/rust.vim')
    " call dein#add('shima-529/C-prototype.vim', { 'lazy' : 1, 'on_ft' : 'c' })
    " call dein#add('thinca/vim-ft-help_fold')
    " call dein#add('vim-jp/cpp-vim')
    call dein#add('vim-jp/vimdoc-ja')
    " call dein#add('vim-ruby/vim-ruby')
    " call dein#add('vim-scripts/Arduino-syntax-file')
    " call dein#add('vim-scripts/sh.vim--Cla')
    " call dein#add('wavded/vim-stylus')
    " call dein#add('yuratomo/java-api-complete', { 'lazy' : 1, 'on_ft' : 'java' })

    " call dein#add('haya14busa/vim-operator-flashy', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>' ] ] })
    " call dein#add('kana/vim-operator-replace', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>' ] ] })
    " call dein#add('kana/vim-operator-user')
    " call dein#add('tommcdo/vim-exchange', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>' ] ]})
    " call dein#add('tyru/operator-camelize.vim', { 'lazy' : 1, 'on_map' : [ [ 'nx', '<Plug>' ] ] })

    " call dein#add('kana/vim-textobj-function', { 'lazy' : 1, 'on_map' : [ [ 'ox', 'af', 'if', 'aF', 'iF' ] ] })
    " call dein#add('kana/vim-textobj-indent', { 'lazy' : 1, 'on_map' :  [ [ 'ox', 'ai' , 'ii' , 'aI',  'iI' ] ] })
    " call dein#add('kana/vim-textobj-line', { 'lazy' : 1, 'on_map' : [ [ 'ox', 'al', 'il' ] ] })
    " call dein#add('kana/vim-textobj-user')
    " call dein#add('rhysd/vim-textobj-word-column', { 'lazy' : 1, 'on_map' : [ [ 'ox', 'av', 'iv' ] ] })
    " call dein#add('sgur/vim-textobj-parameter', { 'lazy' : 1, 'on_map' : [ [ 'ox', 'a,', 'i,', 'i2,' ] ] })
    " call dein#add('reedes/vim-textobj-sentence', { 'lazy' : 1 })

    " call dein#add('machakann/vim-sandwich')

    call dein#end()
    call dein#save_state()
" endif

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
    let g:neocomplete#sources#vim#complete_functions.Unite    = 'unite#complete_source'
    let g:neocomplete#sources#vim#complete_functions.VimFiler = 'vimfiler#complete'
    let g:neocomplete#sources#vim#complete_functions.Vinarise = 'vinarise#complete'

    imap <C-g><C-q> <Plug>(neocomplete_start_unite_quick_match)
    imap <C-g><C-u> <Plug>(neocomplete_start_unite_complete)
    inoremap <expr> <C-g><C-c> neocomplete#undo_completion()
    inoremap <expr> <C-l> neocomplete#complete_common_string()
endif

" neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['stylus'] = 'stylus,css,scss'
let g:neosnippet#scope_aliases['pug'] = 'jade'

" unite.vim
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

function! s:unite_smart_grep() abort
    if unite#sources#grep_git#is_available()
        Unite grep/git -buffer-name=Search
    elseif unite#sources#grep_hg#is_available()
        Unite grep/hg -buffer-name=Search
    else
        Unite grep -buffer-name=Search
    endif
endfunction

if executable('hw')
    " For highway.
    let g:unite_source_grep_command      = 'hw'
    let g:unite_source_grep_default_opts = '--no-group --no-color'
elseif executable('pt')
    " For the platinum searcher.
    let g:unite_source_grep_command      = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
endif
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_encoding      = 'utf-8'

function! s:on_filetype_unite() abort
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

function! Hook_post_source_unite() abort
    call unite#custom#profile('default', 'context', { 'start_insert': 1, 'prompt': '>' })
endfunction

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

" vimfiler
nnoremap <silent> <Leader>fvs :VimFiler -explorer<CR>
nnoremap <silent> <Leader>fvo :VimFiler -tab<CR>
nnoremap <silent> <Leader>fvb :VimFilerBufferDir -explorer<CR>
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_force_overwrite_statusline = 0
function! s:on_filetype_vimfiler() abort
    unmap <buffer> <Space>
    nmap <buffer> : <Plug>(vimfiler_toggle_mark_current_line)
    nmap <buffer> <C-H> <Plug>(vimfiler_switch_to_parent_directory)
    vmap <buffer> : <Plug>(vimfiler_toggle_mark_selected_lines)
    nnoremap <silent><buffer><expr> <C-t> vimfiler#do_action('tabopen')
    nnoremap <silent><buffer><expr> <C-b> vimfiler#do_action('bookmark')
endfunction

function! Hook_post_source_vimfiler() abort
    call vimfiler#custom#profile('default', 'context', { 'safe': 0, 'edit_action': 'tabopen' })
endfunction

" vim-gitgutter
let g:gitgutter_map_keys = 0

" vim-trailing-whitespace
let g:extra_whitespace_ignored_filetypes = [ 'vimfiler', 'unite', 'help']


"----------------------------------------------------------------------------"
" autocmd for plugin
"----------------------------------------------------------------------------"
augroup plugin
    autocmd!

    autocmd VimEnter * call dein#call_hook('post_source')
    autocmd FileType unite call s:on_filetype_unite()
    autocmd FileType vimfiler call s:on_filetype_vimfiler()
augroup END

syntax enable
colorscheme mopkai  " It should be after entax command.









finish


" vim-easymotion
let g:EasyMotion_leader_key = '<Leader>e'


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

" NERDCommenter
let g:NERDSpaceDelims = 1
nmap <Leader><Leader> <Plug>NERDCommenterToggle
vmap <Leader><Leader> <Plug>NERDCommenterNested
nmap <Leader>cs <plug>NERDCommenterSexy

" TagBar
let g:tagbar_width = 35
let g:tagbar_autoshowtag = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
nnoremap <silent> <Leader>tb :<C-U>TagbarToggle<CR>

" Smartinput
function! Hook_on_post_source_smartinput() abort
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

function! Mline_mode() abort
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

function! Mline_modified() abort
    if &filetype == 'unite' || !&modifiable
        return ''
    endif
    return &modified ? '[+]' : '[-]'
endfunction

function! Mline_filename() abort
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
function! Mline_buflist() abort
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
function! Hook_on_post_source_clighter() abort
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


"----------------------------------------------------------------------------"
" autocmd for plugin.
"----------------------------------------------------------------------------"
" for lightline
function! s:update_syntastic() abort
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

    autocmd VimEnter * call dein#call_hook('post_source')
    autocmd FileType help setlocal foldcolumn=0
    autocmd FileType txt,markdown,tex call dein#source(['vim-textobj-sentence']) || :call textobj#sentence#init()
    autocmd FileType unite call s:on_exe_unite()
    autocmd CompleteDone *.java call javaapi#showRef()
    autocmd BufWritePost * call s:update_syntastic()

    " To avoid mess indent in perl.
    autocmd BufWinEnter *.pl nested :RainbowToggleOff
    autocmd BufWinLeave *.pl nested :RainbowToggleOn
augroup END

syntax enable
colorscheme mopkai  " It should be after entax command.
