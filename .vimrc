" vim: foldmethod=marker
" __   ___                 __           __  __
" \ \ / (_)_ __  _ _ __   / _|___ _ _  |  \/  |___ _ __ _ __
"  \ V /| | '  \| '_/ _| |  _/ _ \ '_| | |\/| / _ \ '_ \ '_ \
"   \_/ |_|_|_|_|_| \__| |_| \___/_|   |_|  |_\___/ .__/ .__/
"                                                 |_|  |_|
set nocompatible

" Encoding. {{{
if has('vim_starting')
    " Changing encoding in Vim at runtime is undefined behavior.
    set encoding=utf-8
    set fileencodings=utf-8,sjis,cp932,euc-jp
    set fileformats=unix,mac,dos
endif

" This command has to be after `set encoding`.
scriptencoding utf-8
" }}}

" Indent. {{{
set autoindent
set backspace=2
set breakindent
set expandtab
set shiftwidth=4
set smartindent
set tabstop=4
" }}}

" Appearance. {{{
set ambiwidth=double
set cmdheight=2
set conceallevel=2
set cursorline
set display=lastline
set laststatus=2
set list
set listchars=tab:>\ ,trail:\ ,extends:<,precedes:<
set noarabicshape
set nowrap
set number
set relativenumber
set scrolloff=3
set showcmd
set showmatch
set showtabline=2
set signcolumn=yes
set statusline=%<%F\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}%=%l/%L,%c%V%8P
set synmaxcol=512
" }}}

" Folding. {{{
set foldenable
set foldcolumn=1
set foldmethod=indent
set foldtext=Mopp_fold_text()
set foldmarker=\ {{{,\ }}}
" }}}

" Safety. {{{
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set swapfile
set writebackup
" }}}

" History {{{
set history=2048
set undodir=~/.vim/undo
set undofile
set viewoptions=cursor,folds
" }}}

" Search. {{{
set hlsearch
set ignorecase
set incsearch
set path=.,/usr/local/include,/usr/include,./include
set smartcase
" }}}

" Others. {{{
set splitright
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
set virtualedit=all

" Turn off default plugins. {{{
let g:loaded_2html_plugin = 1
let g:loaded_gzip = 1
let g:loaded_rrhelper = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_matchparen = 1
" }}}

" Configs for default scripts. {{{
let g:lisp_rainbow = 1
let g:lisp_instring = 1
let g:lispsyntax_clisp = 1
let g:c_syntax_for_h = 1
let g:tex_conceal = ''
let g:tex_flavor = 'latex'
" }}}
" }}}

" Mappings. {{{

"---------------------------------------------------------------------------"
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
"------------------|--------|--------|---------|--------|--------|----------|
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

" Managing tab.
nnoremap <Leader>to :<C-U>tabnew<Space>
nnoremap <Leader>tc :<C-U>tabclose<CR>
nnoremap <Leader>j gT
nnoremap <Leader>k gt

" Spliting window.
nnoremap <Leader>sp  :<C-U>split<Space>
nnoremap <Leader>vsp :<C-U>vsplit<Space>

" Changing window size.
noremap <silent> <S-Left>  :<C-U>wincmd <<CR>
noremap <silent> <S-Right> :<C-U>wincmd ><CR>
noremap <silent> <S-Up>    :<C-U>wincmd -<CR>
noremap <silent> <S-Down>  :<C-U>wincmd +<CR>

" Yank & Paste {{{
function! s:paste_with_register(register, paste_type, paste_cmd) abort " {{{
    let l:reg_type = getregtype(a:register)
    let l:store = getreg(a:register)
    call setreg(a:register, l:store, a:paste_type)
    exe 'normal! "' . a:register . a:paste_cmd
    call setreg(a:register, l:store, l:reg_type)
endfunction " }}}

function! s:copy_to_clipboard() abort " {{{
    let l:store = @@
    silent normal! gvy
    let l:selected = @@
    let @@ = l:store

    let @+ = l:selected
    let @* = l:selected
endfunction " }}}

nnoremap Y y$
nnoremap <silent> <Leader>pp :<C-U>set paste!<CR>
xmap <silent> m <Nop>
nmap <silent> m <Nop>
xnoremap <silent> mY  :<C-U>call <SID>copy_to_clipboard()<CR>
nnoremap <silent> mlp :<C-U>call <SID>paste_with_register('+', 'l', 'p')<CR>
nnoremap <silent> mlP :<C-U>call <SID>paste_with_register('+', 'l', 'P')<CR>
nnoremap <silent> mcp :<C-U>call <SID>paste_with_register('+', 'c', 'p')<CR>
nnoremap <silent> mcP :<C-U>call <SID>paste_with_register('+', 'c', 'P')<CR>
nnoremap <silent> mp  :<C-U>call <SID>paste_with_register('+', 'l', 'p')<CR>
" }}}

" Open help of a word under the cursor.
nnoremap <silent> <Leader>hh  :<C-U>help <C-R><C-W><CR>
nnoremap <silent> <Leader>ht :<C-U>tab help <C-R><C-W><CR>

" Adding blank lines.
nnoremap <silent> <CR>      :<C-U>call append('.', repeat([''], v:count1))<CR>
nnoremap <silent> <Leader>O :<C-U>call append(line('.') - 1, repeat([''], v:count1))<CR>

" Change current directory of current window.
nnoremap <silent> <Leader>cd :<C-U>lcd %:p:h<CR>

" Open list if there are multiple tags.
nmap <silent> <C-]> <Nop>
nnoremap <C-]><C-]> g<C-]>zz

" Tab version `<C-]>`.
nnoremap <C-]><C-T> <C-W><C-]><C-W>T

" Repeat the previous macro.
nnoremap Q @@

" Search something in the current visual range only.
vnoremap <M-/> <Esc>/\%V

" Replace the all selected areas.
vnoremap <C-r> "hy:%s/\V<C-r>h//g<left><left>

" Turn off highlight of the current search words.
nnoremap <silent> <Esc><Esc> :<C-U>nohlsearch<CR>

" Save the current buffer.
nnoremap <silent> <Leader>w :<C-U>write<CR>

" Open vimrc at newtab.
if has('nvim') || has('patch-8.0.1508')
    " `drop` command is available on gvim, neovim or vim 8.0.1508.
    nnoremap <silent> <Leader>ev :<C-U>tab drop $MYVIMRC<CR>
else
    nnoremap <silent> <Leader>ev :<C-U>tabnew $MYVIMRC<CR>
endif

" Tab version `gf`.
nnoremap gtf :<C-U>execute 'tabnew' printf('%s/%s', expand('%:h'), expand('<cfile>'))<CR>

" Keep indent
nnoremap <expr> i empty(getline('.')) ? 'S' : 'i'
" }}}

" Functions {{{
function! Mopp_fold_text() abort " {{{
    let l:head = getline(v:foldstart)
    if &foldmethod !=# 'marker'
        let l:head = '+' . repeat('-', &shiftwidth * v:foldlevel - 2) . ' ' . substitute(l:head, '^\s*', '', '')
    endif

    let l:tail = printf('[ %2d Lines Lv%02d ]', (v:foldend - v:foldstart + 1), v:foldlevel)
    let l:count_columns = &foldcolumn + (&number ? max([&numberwidth, strdisplaywidth(line('$'))]) : 0) + (&signcolumn ==# 'no' ? 0 : 2)
    let l:spaces = repeat(' ', winwidth(0) - l:count_columns - strdisplaywidth(l:head) - strdisplaywidth(l:tail)- 1)
    return l:head . l:spaces . l:tail
endfunction " }}}

function! s:remove_tail_spaces() abort " {{{
    if &filetype !=# 'markdown'
        let l:c = getpos('.')
        keeppatterns %s/\s\+$//ge
        call setpos('.', l:c)
    endif
endfunction " }}}
" }}}

" Commands. {{{
" Reload .vimrc
command! ReloadVimrc :source $MYVIMRC

command! -nargs=1 -complete=buffer TabBuffer :tab sbuffer

command! SpellCheckToggle :setlocal spell!

" Echo highlight name of an object under the cursor.
command! EchoHiID echomsg synIDattr(synID(line('.'), col('.'), 1), 'name')

" Convert number expression. {{{
let s:format = { 2: '0b%b', 8: '0o%o', 10: '%d', 16: '0x%x' }
function! s:eval_as_base_number(base, exp) abort " {{{
    let result = eval(a:exp)

    if type(0) != type(result)
        throw 'The result of the given expression have to be Number'
    endif

    return printf(s:format[a:base], result)
endfunction " }}}

command! -nargs=1 EvalAsBin echomsg <SID>eval_as_base_number(2, <f-args>)
command! -nargs=1 EvalAsOct echomsg <SID>eval_as_base_number(8, <f-args>)
command! -nargs=1 EvalAsDec echomsg <SID>eval_as_base_number(10, <f-args>)
command! -nargs=1 EvalAsHex echomsg <SID>eval_as_base_number(16, <f-args>)
inoremap <silent><expr> <C-G>b <SID>eval_as_base_number(2, input('= '))
inoremap <silent><expr> <C-G>o <SID>eval_as_base_number(8, input('= '))
inoremap <silent><expr> <C-G>d <SID>eval_as_base_number(10, input('= '))
inoremap <silent><expr> <C-G>h <SID>eval_as_base_number(16, input('= '))
imap <silent> <C-G><C-B> <C-G>b
imap <silent> <C-G><C-O> <C-G>o
imap <silent> <C-G><C-D> <C-G>d
imap <silent> <C-G><C-H> <C-G>h
" }}}

" Keep last session. {{{
let s:session_directory = '~/.vim/sessions/'
let s:last_session_filepath = s:session_directory . 'last_session.vim'

function! s:save_session(...) abort
    execute 'mksession!' (a:0 == 0) ? (s:last_session_filepath) : (s:session_directory . a:1)
endfunction

function! s:get_session_list(arguments, cmd_line, cursor_pos) abort
    let l:filepaths = split(glob(s:session_directory . '*.vim'), '\n')
    return map(l:filepaths, {i, v -> fnamemodify(v, ':t')})
endfunction

command! -nargs=0 LoadLastSession execute 'source' s:last_session_filepath
command! -nargs=? -complete=customlist,<SID>get_session_list SaveSession call <SID>save_session(<f-args>)
" }}}

" Create Vim directories if not found. {{{
command! -nargs=0 CreateVimDirectories call s:create_vim_directories()
function! s:create_vim_directories() abort
    let base_dir = fnamemodify($MYVIMRC, ':h') . '/'
    call s:mkdir_if_not_exist(base_dir . 'sessions')
    call s:mkdir_if_not_exist(base_dir . 'undo')
    call s:mkdir_if_not_exist(base_dir . 'backup')
    call s:mkdir_if_not_exist(base_dir . 'swap')
endfunction

function! s:mkdir_if_not_exist(path) abort
    if !isdirectory(a:path)
        call mkdir(a:path)
    endif
endfunction
" }}}

command! -nargs=0 StoreTargetWin let t:target_window = win_getid()
command! -nargs=0 JumpTargetWin call win_gotoid(t:target_window)
nnoremap <expr> <Leader>' :<C-U>JumpTargetWin
" }}}

" GUI. {{{
if has('gui_running')
    let g:no_buffers_menu = 1
    set guioptions-=emTrlL
    set mousehide
    set visualbell
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
" }}}

" Autocommands. {{{
augroup mopp
    autocmd!

    " Save session automatically.
    autocmd VimLeave * execute 'mksession!' s:last_session_filepath

    " Turning off paste when escape insert mode.
    autocmd InsertLeave * setlocal nopaste

    " Store and load view.
    autocmd BufWinLeave * if (bufname('%') != '') | mkview!          | endif
    autocmd BufWinEnter * if (bufname('%') != '') | silent! loadview | endif

    " Remove spaces at tail.
    autocmd BufWritePre * silent call s:remove_tail_spaces()

    " Detecting filetypes.
    autocmd BufWinEnter *.nas                nested setlocal filetype=nasm
    autocmd BufWinEnter *.plt                nested setlocal filetype=gnuplot
    autocmd BufWinEnter *.sh                 nested setlocal filetype=sh
    autocmd BufWinEnter *.toml               nested setlocal filetype=toml
    autocmd BufWinEnter *.{md,mdwn,mkd,mkdn} nested setlocal filetype=markdown
    autocmd BufWinEnter *.{pde,ino}          nested setlocal filetype=arduino

    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set relativenumber   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set norelativenumber | endif

    if executable('fcitx-remote')
        autocmd InsertLeave,CmdLineLeave * call system('fcitx-remote -c')
    endif
augroup END
" }}}

" Neovim. {{{
if has('nvim')
    set inccommand=split

    tnoremap <ESC> <C-\><C-n>
    nnoremap <Leader>tm :terminal<CR>
    nnoremap <Leader>vst :vsplit term://zsh<CR>
    nnoremap <Leader>vtt :tabnew term://zsh<CR>

    autocmd TermOpen * setlocal nonumber norelativenumber nowrap

    if has('mac')
        let g:python_host_prog  = '/usr/local/bin/python2'
        let g:python3_host_prog = '/usr/local/bin/python3'
    endif
endif
" }}}

" Plugins. {{{

" dein.vim {{{
let s:dein_base_path = expand('~/.vim/bundle/')
let s:dein_path = s:dein_base_path . 'repos/github.com/Shougo/dein.vim'
let s:has_dein = isdirectory(s:dein_path)
let &runtimepath .= ',' . s:dein_path

if s:has_dein && dein#load_state(s:dein_base_path) " {{{
    call dein#begin(s:dein_base_path)

    call dein#add('Shougo/dein.vim')
    call dein#add('haya14busa/dein-command.vim')

    " Completions {{{
    call dein#add('Shougo/deoplete.nvim', {'lazy': 1, 'on_event': 'InsertEnter'})
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    let s:lazy_plete = {'lazy': 1, 'on_source': ['deoplete.nvim']}
    call dein#add('Shougo/neco-syntax', s:lazy_plete)
    call dein#add('Shougo/neco-vim', s:lazy_plete)
    call dein#add('Shougo/neoinclude.vim', s:lazy_plete)
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('Shougo/neosnippet.vim', s:lazy_plete)
    call dein#add('carlitux/deoplete-ternjs', s:lazy_plete)
    call dein#add('fishbullet/deoplete-ruby')
    call dein#add('honza/vim-snippets', s:lazy_plete)
    call dein#add('racer-rust/vim-racer')
    call dein#add('sebastianmarkow/deoplete-rust')
    call dein#add('ujihisa/neco-look')
    call dein#add('zchee/deoplete-clang')
    " }}}

    " Denite {{{
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/neomru.vim')
    call dein#add('neoclide/denite-git')
    call dein#add('rafi/vim-denite-session')
    " }}}

    " Operators and textobjs {{{
    call dein#add('haya14busa/vim-operator-flashy', {'lazy': 1, 'on_map': '<Plug>'})
    call dein#add('kana/vim-operator-replace', {'lazy': 1, 'on_map': '<Plug>'})
    call dein#add('kana/vim-operator-user')
    call dein#add('mopp/vim-operator-convert-case', {'lazy': 1, 'on_map': '<Plug>'})

    call dein#add('kana/vim-textobj-indent', {'lazy': 1, 'on_map':  [['ox', 'ai' , 'ii' , 'aI',  'iI']]})
    call dein#add('kana/vim-textobj-line', {'lazy': 1, 'on_map': [['ox', 'al', 'il']]})
    call dein#add('kana/vim-textobj-user')
    call dein#add('rhysd/vim-textobj-word-column', {'lazy': 1, 'on_map': [['ox', 'av', 'iv']]})
    call dein#add('sgur/vim-textobj-parameter', {'lazy': 1, 'on_map': [['ox', 'a,', 'i,', 'i2,']]})

    call dein#add('machakann/vim-sandwich')
    " }}}

    " Utils {{{
    call dein#add('Chiel92/vim-autoformat', {'lazy': 1, 'on_cmd': 'Autoformat'})
    call dein#add('FooSoft/vim-argwrap', {'lazy': 1, 'on_cmd': 'ArgWrap'})
    call dein#add('Konfekt/FastFold')
    call dein#add('LeafCage/yankround.vim', {'lazy': 1, 'on_map': '<Plug>'})
    call dein#add('Shougo/deol.nvim', {'lazy': 1, 'on_cmd': ['Deol', 'DeolCd', 'DeolEdit']})
    call dein#add('Shougo/echodoc.vim', {'lazy': 1, 'on_event': 'InsertEnter'})
    call dein#add('Shougo/junkfile.vim', {'lazy': 1, 'on_cmd': 'JunkfileOpen', 'on_func': 'junkfile'})
    call dein#add('Shougo/vinarise.vim', {'lazy':1, 'on_cmd': 'Vinarise'})
    call dein#add('Yggdroot/indentLine')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('chrisbra/Colorizer', {'lazy': 1, 'on_cmd': 'ColorToggle'})
    call dein#add('cocopon/vaffle.vim', {'lazy': 1, 'on_cmd': 'Vaffle'})
    call dein#add('cohama/agit.vim', {'lazy': 1, 'on_cmd': 'Agit'})
    call dein#add('cohama/lexima.vim',{'lazy': 1, 'on_event': 'InsertEnter', 'hook_post_source': 'call Hook_on_post_source_lexima()'})
    call dein#add('easymotion/vim-easymotion', {'lazy': 1, 'on_map': '<Plug>'})
    call dein#add('editorconfig/editorconfig-vim', {'lazy': 1, 'on_cmd': 'EditorConfigReload'})
    call dein#add('idanarye/vim-casetrate', {'lazy': 1, 'on_cmd': 'Casetrate'})
    call dein#add('inside/vim-search-pulse')
    call dein#add('itchyny/lightline.vim')
    call dein#add('itchyny/vim-parenmatch')
    call dein#add('jsfaint/gen_tags.vim', {'lazy': 1, 'on_cmd': ['GenGTAGS', 'GenCtags']})
    call dein#add('junegunn/vim-easy-align', {'lazy': 1, 'on_cmd': 'EasyAlign', 'on_map': ['<Plug>(LiveEasyAlign)', '<Plug>(EasyAlign)']})
    call dein#add('kana/vim-niceblock', {'lazy': 1, 'on_map': [['x', 'I', 'A']]})
    call dein#add('kana/vim-tabpagecd')
    call dein#add('kannokanno/previm', {'lazy': 1, 'on_cmd': 'PrevimOpen', 'on_ft': 'markdown'})
    call dein#add('lambdalisue/gina.vim', {'lazy': 1, 'on_cmd': 'Gina', 'on_event': 'BufWritePost', 'hook_post_source': 'call Hook_on_post_source_gina()'})
    call dein#add('luochen1990/rainbow')
    call dein#add('majutsushi/tagbar', {'lazy': 1, 'on_cmd': 'TagbarToggle'})
    call dein#add('mattn/gist-vim', {'lazy': 1, 'on_cmd': 'Gist'})
    call dein#add('mattn/learn-vimscript')
    call dein#add('mopp/autodirmake.vim', {'lazy': 1, 'on_event': 'InsertEnter'})
    call dein#add('mopp/layoutplugin.vim', {'lazy': 1, 'on_cmd': 'LayoutPlugin'})
    call dein#add('mopp/mopkai.vim')
    call dein#add('osyo-manga/vim-anzu')
    call dein#add('osyo-manga/vim-stargate', {'lazy': 1, 'on_cmd': 'StargateInclude'})
    call dein#add('prakashdanish/vim-githubinator')
    call dein#add('rhysd/accelerated-jk', {'lazy': 1, 'on_map': '<Plug>'})
    call dein#add('rickhowe/diffchar.vim', {'lazy':  &diff == 0, 'on_if': '&diff'})
    call dein#add('szw/vim-maximizer', {'lazy': 1, 'on_cmd': 'MaximizerToggle'})
    call dein#add('t9md/vim-choosewin', {'lazy': 1, 'on_map': {'n': '<Plug>'}})
    call dein#add('t9md/vim-quickhl', {'lazy': 1, 'on_map' : {'nx': '<Plug>'}})
    call dein#add('thinca/vim-visualstar')
    call dein#add('tpope/vim-repeat')
    call dein#add('tyru/capture.vim', {'lazy': 1, 'on_cmd': 'Capture'})
    call dein#add('tyru/caw.vim', {'lazy': 1, 'on_map': '<Plug>(caw:', 'hook_post_source': 'doautocmd plugin FileType'})
    call dein#add('tyru/open-browser.vim', {'lazy': 1, 'on_map': [['n', '<Plug>(openbrowser-open)']], 'on_func': ['openbrowser#load', 'openbrowser#open']})
    call dein#add('w0rp/ale', {'lazy': 1, 'on_event': 'BufWritePost'})
    " }}}

    " Languages {{{
    call dein#add('Shirk/vim-gas')
    call dein#add('cespare/vim-toml')
    call dein#add('derekwyatt/vim-scala', {'lazy': 1, 'on_ft': 'scala'})
    call dein#add('digitaltoad/vim-pug')
    call dein#add('ekalinin/Dockerfile.vim')
    call dein#add('elzr/vim-json')
    call dein#add('hail2u/vim-css3-syntax')
    call dein#add('leafgarland/typescript-vim')
    call dein#add('othree/html5.vim')
    call dein#add('pangloss/vim-javascript')
    call dein#add('plasticboy/vim-markdown')
    call dein#add('rust-lang/rust.vim', {'lazy': 1, 'on_ft': 'rust'})
    call dein#add('shima-529/C-prototype.vim', {'lazy': 1, 'on_ft': 'c'})
    call dein#add('stephpy/vim-yaml')
    call dein#add('vim-erlang/vim-erlang-omnicomplete', {'lazy': 1, 'on_ft': 'erlang'})
    call dein#add('vim-erlang/vim-erlang-runtime')
    call dein#add('vim-jp/cpp-vim')
    call dein#add('vim-jp/vimdoc-ja')
    call dein#add('vim-ruby/vim-ruby')
    call dein#add('vim-scripts/sh.vim--Cla')
    " }}}

    call dein#end()
    call dein#save_state()
endif " }}}

filetype plugin indent on

" ftplugins are loaded when 'filetype on'.
" The autocmds to override filetype local settings have to be executed after 'filetype on'.
augroup mopp_filetype_overwrite " {{{
    autocmd!
    autocmd FileType git setlocal nofoldenable
    autocmd FileType lisp setlocal nocindent nosmartindent lisp lispwords=define
    autocmd FileType text,man setlocal wrap
    autocmd FileType help setlocal foldcolumn=0
    autocmd FileType ruby,javascript,typescript,html,css setlocal shiftwidth=2
augroup END " }}}

if !s:has_dein " {{{
    " Install all plugins.
    command! SetupPlugins call s:setup_plugins()
    function! s:setup_plugins() abort " {{{
        if !executable('git')
            echoerr 'git is not found.'
            return
        endif

        call s:create_vim_directories()
        execute '!git clone --depth=1 https://github.com/Shougo/dein.vim' s:dein_path
        let &runtimepath .= ',' . s:dein_path
        let g:is_setup = 1
        source $MYVIMRC
        call dein#install()
        unlet g:is_setup
    endfunction " }}}

    " Minimum settings.
    syntax enable
    colorscheme desert
    finish
elseif exists('g:is_setup')
    finish
endif " }}}
" }}}

" Command to stop some features which affect performance.
command! Accelerate call s:accelerate()
function! s:accelerate() abort " {{{
    IndentLinesDisable
    RainbowToggleOff
    ALEDisable
    set nocursorline
endfunction
" }}}

" deoplete.nvim {{{
let g:deoplete#enable_at_startup = 1
" If the default sources are defined, some completions are not work.
" let g:deoplete#sources           = {}
" let g:deoplete#sources._         = ['buffer']
" }}}

" neosnippet.vim {{{
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)
xmap <C-s> <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#scope_aliases = {
            \ 'stylus': 'stylus,css,scss',
            \ 'pug': 'jade',
            \ 'handlebars': 'handlebars,html'
            \ }
" }}}

" neomru.vim
let g:neomru#file_mru_ignore_pattern = '^gina:\/\/.*$'

" denite.nvim
if dein#tap('denite.nvim') " {{{
    nnoremap <silent> <Leader>fb  :<C-U>Denite buffer<CR>
    nnoremap <silent> <Leader>fe  :<C-U>Denite file/rec<CR>
    nnoremap <silent> <Leader>ff  :<C-U>Denite file_mru<CR>
    nnoremap <silent> <Leader>fd  :<C-U>Denite -default-action=tab_open directory_mru<CR>
    nnoremap <silent> <Leader>fgg :<C-U>Denite grep<CR>
    nnoremap <silent> <Leader>fgw :<C-U>DeniteCursorWord grep<CR>
    nnoremap <silent> <Leader>fl  :<C-U>Denite line<CR>
    nnoremap <silent> <Leader>fo  :<C-U>Denite outline<CR>
    nnoremap <silent> <Leader>fre :<C-U>Denite -resume<CR>

    call denite#custom#map('insert', '<C-A>', '<Home>')
    call denite#custom#map('insert', '<C-E>', '<End>')
    call denite#custom#map('insert', '<C-F>', '<Right>')
    call denite#custom#map('insert', '<C-B>', '<Left>')
    call denite#custom#map('insert', '<C-D>', '<Del>')
    call denite#custom#map('insert', '<C-J>', '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<C-K>', '<denite:move_to_previous_line>', 'noremap')
    call denite#custom#map('insert', '<C-P>', '<denite:do_action:preview>', 'noremap')
    call denite#custom#map('insert', '<C-T>', '<denite:do_action:tabopen>', 'noremap')
    call denite#custom#map('insert', '<C-V>', '<denite:do_action:vsplit>', 'noremap')
    call denite#custom#map('insert', '<C-S>', '<denite:do_action:split>', 'noremap')
    call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>', 'noremap')
    call denite#custom#map('normal', 's', '<denite:do_action:split>', 'noremap')
    call denite#custom#option('default', {
                \ 'highlight_matched_char': 'Keyword',
                \ 'highlight_matched_range': 'None',
                \ 'statusline': v:false,
                \ })
    call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'sorter_rank', 'matcher_project_files'])

    if executable('rg') " {{{
        " For ripgrep.
        call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!.git', ''])
        call denite#custom#var('grep', 'command', ['rg'])
        call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])
    endif " }}}
endif " }}}

" vim-operator-flashy
map y <Plug>(operator-flashy)
map Y <Plug>(operator-flashy)$
let g:operator#flashy#group = 'Error'

" operator-replace
map _ <Plug>(operator-replace)

" operator-convert-case.vim {{{
nmap <Leader>,cl <Plug>(operator-convert-case-lower-camel)
nmap <Leader>,cu <Plug>(operator-convert-case-upper-camel)
nmap <Leader>,sl <Plug>(operator-convert-case-lower-snake)
nmap <Leader>,su <Plug>(operator-convert-case-upper-snake)
nmap <Leader>,tt <Plug>(operator-convert-case-toggle-upper-lower)
nmap <Leader>,ll <Plug>(operator-convert-case-loop)
nmap <Leader>,cc <Plug>(operator-convert-case-convert)
" }}}

" yankround.vim {{{
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
" }}}

" echodoc.vim
let g:echodoc_enable_at_startup = 1

" vim-gitgutter {{{
let g:gitgutter_map_keys = 0
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk
nmap <Leader>hp <Plug>GitGutterPrevHunk
nmap <Leader>hn <Plug>GitGutterNextHunk
" }}}

" vim-trailing-whitespace
let g:extra_whitespace_ignored_filetypes = [ 'denite', 'help', 'vaffle' ]

" vim-easymotion
map <Leader>e <Plug>(easymotion-prefix)

" lightline.vim {{{
let g:lightline = {
            \ 'colorscheme': 'mopkai',
            \ 'active': {
            \   'left': [['mode', 'denite', 'paste'], ['filename', 'modified'], ['readonly', 'spell'], ['git_status'], ['anzu']],
            \   'right': [['fileencoding', 'fileformat', 'lineinfo'], ['filetype'], ['ale_status']],
            \ },
            \ 'inactive': {
            \   'left': [['filename', 'modified']],
            \   'right': [['filetype']]
            \ },
            \ 'tabline': {
            \   'left': [['tabs']],
            \   'right': []
            \ },
            \ 'tab': {
            \   'active':   ['tabnum', 'filename', 'modified'],
            \   'inactive': ['tabnum', 'filename', 'modified']
            \ },
            \ 'tabline_separator': { 'left': '', 'right': '' },
            \ 'tabline_subseparator': { 'left': '', 'right': '' },
            \ 'component': {
            \   'mode':         '%{ get(g:lightline_plugin_modes, &filetype, lightline#mode()) }',
            \   'denite':       "%{ (&filetype !=# 'denite') ? '' : denite#get_status('raw_mode') }",
            \   'modified':     "%{ (LightlineIsVisible() && &modifiable) ? (&modified ? '[+]' : '[-]') : '' }",
            \   'readonly':     "%{ (LightlineIsVisible() && &readonly) ? 'RO' : '' }",
            \   'git_status':   "%{ (LightlineIsVisible() && dein#is_sourced('gina.vim')) ? printf('%s: [%s]', gina#component#repo#branch(), gina#component#status#preset()) : '' }",
            \   'filetype':     "%{ LightlineIsVisible() ? &filetype : '' }",
            \   'fileencoding': "%{ LightlineIsVisible() ? (strlen(&fenc) ? &fenc : &enc) : '' }",
            \   'fileformat':   "%{ LightlineIsVisible() ? &fileformat : '' }",
            \   'lineinfo':     '%03l:%03v:%03p%%',
            \ },
            \ 'component_visible_condition': {
            \   'denite':       "&filetype==# 'denite'",
            \   'modified':     'LightlineIsVisible() && &modifiable',
            \   'fileencoding': 'LightlineIsVisible()',
            \   'fileformat':   'LightlineIsVisible()',
            \ },
            \ 'component_function': {
            \   'filename':   'LightlineFilename',
            \   'anzu':       'anzu#search_status',
            \   'ale_status': 'LightlineAleStatus',
            \ },
            \ }

let g:lightline_plugin_modes = {'denite': 'Denite', 'vaffle': 'Vaffle', 'tagbar': 'TagBar'}

function! LightlineIsVisible() abort
    return (60 <= winwidth(0)) && (&filetype !~? 'vaffle\|tagbar\|denite\|help')
endfunction

function! LightlineFilename() abort " {{{
    if &filetype ==# 'denite'
        return denite#get_status('sources') . ' [' . denite#get_status('linenr') . ']'
    elseif &filetype ==# 'tagbar'
        return g:lightline.fname
    else
        let l:t = expand('%:t')
        return l:t ==# '' ? '[No Name]' : l:t
    endif
endfunction " }}}

function! LightlineAleStatus() abort " {{{
    if !dein#is_sourced('ale') || !LightlineIsVisible()
        return ''
    endif

    let l:cnt = ale#statusline#Count(bufnr(''))
    return printf('E:%d W:%d I:%d', l:cnt.error + l:cnt.style_error, l:cnt.warning + l:cnt.style_warning, l:cnt.info)
endfunction " }}}

" Colors {{{
let s:cp_fname_modi = ['#ffffff', '#080808', 231, 232]
let s:cp_read_spell = ['#d70000', '#121212', 160, 233]
let s:cp_git_status = ['#87afff', '#1c1c1c', 111, 234]
let s:cp_anzu       = ['#ff87af', '#303030', 211, 236]
let s:cp_middle     = ['#9e9e9e', '#444444', 247, 238]
let s:cp_ale        = ['#ff5f87', '#1c1c1c', 204, 234]
let g:lightline#colorscheme#mopkai#palette = {
            \ 'normal': {
            \   'left':    [['#080808', '#00afff', 232,  39], s:cp_fname_modi, s:cp_read_spell, s:cp_git_status, s:cp_anzu],
            \   'middle':  [s:cp_middle],
            \   'right':   [['#ffffd7', '#1c1c1c', 230, 234], ['#875fd7', '#080808', 98, 232], s:cp_ale],
            \   'warning': [['#9e9e9e', '#ffdf5f', 247, 221]],
            \   'error':   [['#eeeeee', '#d70000', 255, 160]]
            \ },
            \ 'insert': {
            \   'left':   [['#080808', '#87ff00', 232, 118], s:cp_fname_modi, s:cp_read_spell, s:cp_git_status, s:cp_anzu],
            \ },
            \ 'replace': {
            \   'left':   [['#080808', '#ff0087', 232, 198], s:cp_fname_modi, s:cp_read_spell, s:cp_git_status, s:cp_anzu],
            \ },
            \ 'visual': {
            \   'left':   [['#080808', '#d7ff5f', 232, 191], s:cp_fname_modi, s:cp_read_spell, s:cp_git_status, s:cp_anzu],
            \ },
            \ 'inactive': {
            \   'left':   [['#9e9e9e', '#080808', 247, 232]],
            \   'middle': [s:cp_middle],
            \   'right':  [['#875fd7', '#080808',  98, 232]]
            \ },
            \ 'tabline': {
            \   'tabsel': [['#080808', '#ff0087', 232, 198]],
            \   'left':   [['#080808', '#c6c6c6', 232, 251]],
            \   'middle': [['#080808', '#c6c6c6', 232, 251]],
            \   'right':  [['#080808', '#c6c6c6', 232, 251]],
            \ }
            \ }
" }}}
" }}}

" vim-parenmatch
let g:parenmatch_highlight = 0
hi link ParenMatch MatchParen

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" previm
let g:previm_show_header = 0

" rainbow {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
            \   'guifgs' : [ '#666666', '#0087ff', '#ff005f', '#875fd7', '#d78700', '#00af87' ],
            \   'ctermfgs': [ '242', '33', '197', '98', '172', '36' ],
            \   'separately' : {
            \       '*':   {}, 'vim': {},
            \       'css': 0, 'perl': 0, 'html': 0, 'handlebars': 0, 'xml': 0
            \   },
            \   }
" }}}

" tagbar {{{
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
" }}}

" gist-vim
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" layoutplugin.vim
let g:layoutplugin#is_append_vimrc = 1

" mopkai.vim
let g:mopkai_is_not_set_normal_ctermbg = or(!has('mac'), ($USER !=# 'mopp'))

" vim-search-pulse
let g:vim_search_pulse_disable_auto_mappings = 1

" vim-anzu {{{
nmap n <Plug>(anzu-n)<Plug>Pulse
nmap N <Plug>(anzu-N)<Plug>Pulse
nmap * <Plug>(anzu-star)<Plug>Pulse
nmap # <Plug>(anzu-sharp)<Plug>Pulse
nnoremap <silent> <Esc><Esc> :<C-U>nohlsearch <bar> :AnzuClearSearchStatus<CR>
" }}}

" open-browser.vim
map <Leader>op <Plug>(openbrowser-open)

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

" vim-maximizer {{{
let g:maximizer_restore_on_winleave = 1
nnoremap <silent><F3> :<C-U>MaximizerToggle<CR>
vnoremap <silent><F3> :<C-U>MaximizerToggle<CR>gv
inoremap <silent><F3> <C-O>:<C-U>MaximizerToggle<CR>
" }}}

" accelerated-jk {{{
if dein#tap('accelerated-jk')
    nmap j <Plug>(accelerated_jk_gj)
    nmap k <Plug>(accelerated_jk_gk)
endif
" }}}

" ale {{{
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
function! s:define_erlang_option() abort
    let paths = []
    for p in ['_build/default/lib/*/include', 'apps*/', 'apps*/*/include']
        let paths += glob(p, 0, 1)
    endfor
    let g:ale_erlang_erlc_options = '-o /tmp/ -I src -I include -I _build/default/lib/ ' . join(map(paths, '"-I" . v:val'), ' ')
endfunction
" }}}

" junkfile.vim {{{
command! -nargs=1 JunkfileNote call junkfile#open(strftime('%Y-%m-%d_') . <q-args>, '.md')
command! JunkfileDaily call junkfile#open_immediately(strftime('%Y-%m-%d.md'))
nnoremap <Leader>xx :<C-U>0tabnew +JunkfileDaily<CR>
let g:junkfile#directory = $HOME . '/workspace/notes'
" }}}

" gina.vim {{{
function! Hook_on_post_source_gina() abort
    let l:cmd_opt = {'noremap': 1, 'silent': 1}
    call gina#custom#mapping#nmap('branch', 'n', '<Plug>(gina-branch-new)')
    call gina#custom#mapping#nmap('branch', 'r', '<Plug>(gina-branch-move)')
    call gina#custom#mapping#nmap('status', '<C-]>', ':<C-U>Gina commit<CR>', l:cmd_opt)
    call gina#custom#mapping#nmap('/.*', 'q', ':<C-U>quit<CR>', l:cmd_opt)
    call gina#custom#mapping#nmap('/.*', '<C-t>', '<Plug>(gina-edit-tab)')
    call gina#custom#mapping#nmap('/.*', '<C-h>', ':call gina#action#call(''edit:left'')<CR>', l:cmd_opt)
    call gina#custom#mapping#nmap('/.*', '<C-j>', ':call gina#action#call(''edit:bottom'')<CR>', l:cmd_opt)
    call gina#custom#mapping#nmap('/.*', '<C-k>', ':call gina#action#call(''edit:above'')<CR>', l:cmd_opt)
    call gina#custom#mapping#nmap('/.*', '<C-l>', ':call gina#action#call(''edit:right'')<CR>', l:cmd_opt)
    call gina#custom#command#option('/\%(commit\|status\|branch\|changes\|grep\|log\)', '--opener', 'split')
endfunction
nnoremap <Leader>gis :<C-U>Gina status<CR>
nnoremap <Leader>gic :<C-U>Gina commit<CR>
" }}}

" lexima.vim {{{
imap <C-h> <BS>
cmap <C-h> <BS>
function! Hook_on_post_source_lexima() abort
    let l:rules = []

    for l:char in ['+', '-', '*', '/', '%', '<', '>', '&', '=', '<Bar>']
        let l:rules += [{'char': l:char, 'at': '\S\+\%#', 'except': '''.*\%#.*''', 'input': ' ' . l:char . ' '}]
    endfor
    let l:rules += [{'char': '<BS>', 'at': '\w\+\s\(+\|-\|\*\|%\|<\|>\|&\|=\||\)\s\%#', 'input': '<BS><BS><BS>'}]

    for l:char in ['*', '<', '>', '&', '=', '<Bar>', '/']
        let l:rules += [{'char': l:char, 'at': l:char . '\s\%#', 'input': '<BS>' . l:char . ' '}]
    endfor
    let l:rules += [{'char': '<BS>', 'at': '\s\(++\|\*\*\|<<\|>>\|&&\|||\)\s\%#', 'input': '<BS><BS><BS><BS>'}]

    let l:rules +=
                \ [
                \ {'char': '<TAB>','at': '([()]*\%#[)]*)', 'input': '<Right>'},
                \
                \ {'char': '=',    'at': '!\%#',     'input': '<BS> != ', 'priority': 10},
                \ {'char': '<BS>', 'at': ' != !\%#', 'input': '<BS><BS><BS><BS>'},
                \
                \ {'char': '/', 'at': '^\s*\%#', 'input': '// '},
                \
                \ {'filetype': ['erlang'], 'char': ':',     'at': ':\%#',     'input': '<BS> :: '},
                \ {'filetype': ['erlang'], 'char': '=',     'at': ':\%#',     'input': '<BS> := '},
                \ {'filetype': ['erlang'], 'char': '=',     'at': '= \%#',    'input': '<BS>:= '},
                \ {'filetype': ['erlang'], 'char': '=',     'at': '!\%#',     'input': '<BS> =/= ', 'priority': 20},
                \ {'filetype': ['erlang'], 'char': '<BS>',  'at': '`\%#''',   'input': '<BS><Del>'},
                \ {'filetype': ['erlang'], 'char': '%',     'at': '^\s*%\%#', 'input': '% '},
                \ {'filetype': ['erlang'], 'char': '<Del>', 'at': ':= \%#',   'input': '<BS><BS><BS>'},
                \ {'filetype': ['erlang'], 'char': '`',     'input': '`''<Left>', 'syntax': 'Comment', },
                \
                \ {'char': '<Bar>', 'at': '\s|\s\%#', 'input': '<BS>| '},
                \
                \ {'char': '>',    'at': '<\%#',     'input': '><Left>',              'filetype': ['vim', 'rust']},
                \ {'char': '>',    'at': '\s<\s\%#', 'input': '<BS><BS><BS><><Left>', 'filetype': ['vim', 'rust']},
                \ {'char': '<BS>', 'at': '<\%#>',    'input': '<BS><Del>'},
                \
                \ {'char': '=',     'at': '\(+\|-\|*\|%\|<\|>\) \%#',    'input': '<BS>= '},
                \
                \ {'char': '+',    'at': '\s+\s\%#',      'input': '<BS><BS><BS>++'},
                \ {'char': '-',    'at': '\s-\s\%#',      'input': '<BS><BS><BS>--'},
                \ {'char': '<BS>', 'at': '\(++\|--\)\%#', 'input': '<BS><BS>'},
                \
                \ {'char': ',',       'at': '\%#',              'input': ', '},
                \ {'char': ',',       'at': ',\%#',             'input': '<BS>->'},
                \ {'char': ',',       'at': ',\s\%#',           'input': '<BS><BS>->'},
                \ {'char': '<Space>', 'at': '\S->\%#',          'input': '<BS><BS> -> '},
                \ {'char': ',',       'at': '->\%#',            'input': '<BS><BS>=>'},
                \ {'char': '<Space>', 'at': '\S=>\%#',          'input': '<BS><BS> => '},
                \ {'char': ',',       'at': '\s->\s\%#',        'input': '<BS><BS><BS>=> '},
                \ {'char': ',',       'at': '\s=>\s\%#',        'input': '<BS><BS><BS><BS>, '},
                \ {'char': ',',       'at': '=>\s\%#',          'input': '<BS><BS><BS>, '},
                \ {'char': ',',       'at': '=>\%#',            'input': '<BS><BS>, '},
                \ {'char': '<BS>',    'at': '\(,\s\|->\), \%#', 'input': '<BS><BS>'},
                \ {'char': '<BS>',    'at': '\s\(-\|=\)>\s\%#', 'input': '<BS><BS><BS><BS>'},
                \
                \ {'filetype': ['markdown'], 'char': '/',     'input': '/'},
                \ {'filetype': ['markdown'], 'char': '#',     'at': '^\%#\%(#\)\@!',    'input': '# '},
                \ {'filetype': ['markdown'], 'char': '#',     'at': '#\s\%#',           'input': '<BS># '},
                \ {'filetype': ['markdown'], 'char': '<BS>',  'at': '^#\s\%#',          'input': '<BS><BS>'},
                \ {'filetype': ['markdown'], 'char': '<BS>',  'at': '##\s\%#',          'input': '<BS><BS> '},
                \ {'filetype': ['markdown'], 'char': '+',     'at': '^\s*\%#',          'input': '+ '},
                \ {'filetype': ['markdown'], 'char': '-',     'at': '^\s*\%#',          'input': '- '},
                \ {'filetype': ['markdown'], 'char': '*',     'at': '^\s*\%#',          'input': '* '},
                \ {'filetype': ['markdown'], 'char': '>',     'at': '^\s*\%#',          'input': '> '},
                \ {'filetype': ['markdown'], 'char': '<TAB>', 'at': '^\s*- \%#',        'input': '<Left><Left><Tab><Del>-<Right>'},
                \ {'filetype': ['markdown'], 'char': '<TAB>', 'at': '^\s*+ \%#',        'input': '<Left><Left><Tab><Del>+<Right>'},
                \ {'filetype': ['markdown'], 'char': '<TAB>', 'at': '^\s*\* \%#',       'input': '<Left><Left><Tab><Del>*<Right>'},
                \ {'filetype': ['markdown'], 'char': '<BS>',  'at': '^\s*- \%#',        'input': '<BS><BS><BS>- '},
                \ {'filetype': ['markdown'], 'char': '<BS>',  'at': '^\s*+ \%#',        'input': '<BS><BS><BS>+ '},
                \ {'filetype': ['markdown'], 'char': '<BS>',  'at': '^\s*\* \%#',       'input': '<BS><BS><BS>* '},
                \ {'filetype': ['markdown'], 'char': '<BS>',  'at': '^\(-\|+\|*\) \%#', 'input': '<C-W>'},
                \ ]

    for l:rule in l:rules
        call lexima#add_rule(l:rule)
    endfor
endfunction
" }}}

" vim-denite-session
let g:session_directory = s:session_directory

" vaffle.vim {{{
command! VaffleTab tabnew +Vaffle
command! VaffleSplit split +Vaffle
command! VaffleVsplit vsplit +Vaffle
command! VaffleBottomExpplorer botright split +Vaffle | resize 12 | setlocal winfixheight
command! VaffleExplorer vertical topleft vsplit +Vaffle | vertical resize 35 | setlocal winfixwidth

nnoremap <silent> <Leader>vv :Vaffle<CR>
nnoremap <silent> <Leader>vl :Vaffle<CR>
nnoremap <silent> <Leader>ve :VaffleExplorer<CR>
nnoremap <silent> <Leader>vh :Vaffle %:h<CR>

function! s:on_filetype_vaffle() abort
    nmap <silent><buffer><nowait> , <Plug>(vaffle-toggle-current)
    nmap <silent><buffer><nowait> s <Plug>(vaffle-open-selected-split)
    nmap <silent><buffer><nowait> v <Plug>(vaffle-open-selected-vsplit)
endfunction

function! s:on_load_vaffle(is_directory) abort
    if a:is_directory && !dein#is_sourced('vaffle.vim')
        call dein#source('vaffle.vim')
        call vaffle#event#on_bufenter()
    endif
endfunction
" }}}

" caw.vim
nmap gcg <Plug>(caw:hatpos:toggle:operator)
nmap <Leader><Leader> <Plug>(caw:hatpos:toggle)
vmap <Leader><Leader> <Plug>(caw:hatpos:toggle)

" Capture.vim
command! -nargs=1 -bang GrepBuffer           :execute printf(':Capture! global%s/%s/print', expand('<bang>'), <q-args>)
command! -nargs=0 -bang GrepBufferCursorWord :execute printf(':GrepBuffer%s %s', expand('<bang>'), expand('<cword>'))
command! -nargs=0 -bang GrepBufferYank       :execute printf(':GrepBuffer%s %s', expand('<bang>'), @0)

" vim-quickhl {{{
nmap <Leader>hl <Plug>(quickhl-manual-this)
xmap <Leader>hl <Plug>(quickhl-manual-this)
nmap <Leader>hc <Plug>(quickhl-manual-reset)
xmap <Leader>hc <Plug>(quickhl-manual-reset)
" }}}

" vim-choosewin
nmap <Leader>- <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
let g:choosewin_overlay_clear_multibyte = 1

" deol.nvim
command! DeolTabEdit tabnew +DeolEdit

" vim-sandwich {{{
let g:sandwich#recipes =
            \ g:sandwich#default_recipes +
            \ [
            \ {
            \   '__filetype__': 'erlang',
            \   'buns':     ['#{', '}'],
            \   'input':    ['#'],
            \   'filetype': ['erlang'],
            \ }
            \ ]
" }}}

" vim-json
let g:vim_json_syntax_conceal = 0

" Autocommands for plugins.  {{{
augroup plugin
    autocmd!

    autocmd FileType gina-commit setlocal spell
    autocmd Filetype vaffle call s:on_filetype_vaffle()
    autocmd FileType erlang let b:caw_oneline_comment = '%%'
    autocmd FileType erlang call s:define_erlang_option()
    autocmd BufEnter * call s:on_load_vaffle(isdirectory(expand('<afile>')))
augroup END
" }}}
" }}}

syntax enable
colorscheme mopkai " It should be after syntax command.
