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
set backspace=indent,eol,start
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
set foldmethod=indent
set foldtext=MoppFoldText()
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
set smartcase
" }}}

" Others. {{{
set belloff=all
set completeopt=menu
set dictionary=/usr/share/dict/words
set diffopt+=iwhite
set formatoptions+=tjrol
set helplang=ja
set langnoremap
set lazyredraw
set matchpairs+=<:>
set mouse=
set regexpengine=2
set splitright
set updatetime=500
set virtualedit=all
set whichwrap=b,s,h,l,<,>,[,]
set wildignorecase
set wildmenu

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
let g:markdown_folding = 1
" }}}
" }}}

" Mappings. {{{

" :help map-table
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

noremap <silent> j gj
noremap <silent> k gk
noremap ; :
noremap : ;

" Avoiding getting <NUL> from <C-Space>.
map <NUL> <C-Space>
map! <NUL> <C-Space>

" Movings.
noremap! <C-F> <Right>
noremap! <C-B> <Left>
noremap! <C-D> <Del>
cnoremap <C-A> <HOME>
cnoremap <C-E> <END>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
noremap <silent> <C-J> G
noremap <silent> <C-K> gg
noremap <silent> <C-H> ^
noremap <silent> <C-L> $

" Managing tab.
nnoremap <Leader>to :<C-U>tabnew<Space>
nnoremap <silent> <Leader>tc <Cmd>tabclose<CR>
nnoremap <silent> <Leader>j gT
nnoremap <silent> <Leader>k gt

" Spliting window.
nnoremap <Leader>sp  <Cmd>split<Space>
nnoremap <Leader>vsp <Cmd>vsplit<Space>

" Changing window size.
noremap <silent> <S-Left>  <Cmd>wincmd <<CR>
noremap <silent> <S-Right> <Cmd>wincmd ><CR>
noremap <silent> <S-Up>    <Cmd>wincmd -<CR>
noremap <silent> <S-Down>  <Cmd>wincmd +<CR>

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

nnoremap <silent> Y y$
nnoremap <silent> <Leader>gp <Cmd>set paste!<CR>
xmap <silent> m <Nop>
nmap <silent> m <Nop>
xnoremap <silent> mY  :<C-U>call <SID>copy_to_clipboard()<CR>
nnoremap <silent> mlp :<C-U>call <SID>paste_with_register('+', 'l', 'p')<CR>
nnoremap <silent> mlP :<C-U>call <SID>paste_with_register('+', 'l', 'P')<CR>
nnoremap <silent> mcp :<C-U>call <SID>paste_with_register('+', 'c', 'p')<CR>
nnoremap <silent> mcP :<C-U>call <SID>paste_with_register('+', 'c', 'P')<CR>
nnoremap <silent> mp  :<C-U>call <SID>paste_with_register('+', 'l', 'p')<CR>
" }}}

" Overwrite the current line with yanked text.
nnoremap <silent> go  pk"_dd

" Open help of a word under the cursor.
nnoremap <silent> <Leader>hh <Cmd>help <C-R><C-W><CR>
nnoremap <silent> <Leader>ht <Cmd>tab help <C-R><C-W><CR>

" Adding blank lines.
nnoremap <silent><expr> <CR> &buftype ==# 'quickfix' ? '<CR>' : '<Cmd>call append(".", repeat([""], v:count1))<CR>'
nnoremap <silent> <Leader>O <Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>

" Change window local current directory to the directory of the file at the current window.
nnoremap <silent> <Leader>cd <Cmd>lcd %:p:h<CR>

" Open list if there are multiple tags.
nmap <silent> <C-]> <Nop>
nnoremap <silent> <C-]><C-]> g<C-]>zz

" Tab version `<C-]>`.
nnoremap <silent> <C-]><C-T> <C-W><C-]><C-W>T

" Repeat the previous macro.
nnoremap <silent> Q @@

" Search something in the current visual range only.
vnoremap <silent> / <Esc>/\%V

" Replace the all selected areas.
vnoremap <C-R> "hy:%s/\V<C-R>h//g<left><left>

" Assist input normal command on visual mode.
vnoremap n :normal<Space>

" Turn off highlight of the current search words.
nnoremap <silent> <Esc><Esc> <Cmd>nohlsearch<CR>

" Save the current buffer.
nnoremap <silent> <Leader>w <Cmd>write<CR>

" Close the current window.
nnoremap <silent> <Leader>q <Cmd>quit<CR>

" Open vimrc at newtab.
if has('nvim') || has('patch-8.0.1508')
    " `drop` command is available on gvim, neovim or vim 8.0.1508.
    nnoremap <silent> <Leader>ev <Cmd>tab drop $MYVIMRC<CR>
else
    nnoremap <silent> <Leader>ev <Cmd>tabnew $MYVIMRC<CR>
endif

" Tab version `gf`.
nnoremap <silent> gtf <Cmd>execute 'tabnew' printf('%s/%s', getcwd(), expand('<cfile>'))<CR>

" Keep indent
nnoremap <silent><expr> i empty(getline('.')) ? 'S' : 'i'
nnoremap <silent><expr> a empty(getline('.')) ? 'S' : 'a'
" }}}

" Functions {{{
function! MoppFoldText() abort " {{{
    let l:head = getline(v:foldstart)
    if &foldmethod !=# 'marker'
        let l:head = '+' . repeat('-', &shiftwidth * v:foldlevel - 2) . ' ' . substitute(l:head, '^\s*', '', '')
    endif

    let l:count_columns = &foldcolumn + (&signcolumn ==# 'no' ? 0 : 2) + ((&number || &relativenumber) ? max([&numberwidth, strdisplaywidth(line('$')) + 1]) : 0)
    let l:tail = printf('[%d Lines Lv%d]', (v:foldend - v:foldstart + 1), v:foldlevel)
    let l:spaces = repeat(' ', winwidth(0) - strdisplaywidth(l:head) - l:count_columns - strdisplaywidth(l:tail) - 1)
    return l:head . l:spaces . l:tail
endfunction " }}}

function! s:remove_tail_spaces() abort " {{{
    if &filetype !=# 'markdown'
        let l:c = getpos('.')
        keeppatterns %s/\s\+$//ge
        call setpos('.', l:c)
    endif
endfunction " }}}

function! s:shrink_window_by_paragraph(direction) abort
    let l:s = &l:scrolloff
    setlocal scrolloff=0

    if a:direction ==? 'upward'
        " Cut off the bottom region.
        normal! LV{H
    else
        " Cut off the top region.
        normal! HV}L
    endif

    execute 'resize -' . (line("'>") - line("'<"))
    normal! M

    let &l:scrolloff = l:s
endfunction
noremap <silent> <S-C-Up> <Cmd>keepjumps call <SID>shrink_window_by_paragraph('upward')<CR>
noremap <silent> <S-C-Down> <Cmd>keepjumps call <SID>shrink_window_by_paragraph('downward')<CR>

function! s:define_quickfix_mappings() abort
    nnoremap <buffer> t <C-W>gF<CR>
    nnoremap <buffer><nowait> s <C-W>F<CR>
    nnoremap <buffer> v <C-W>F<C-W>L<CR>
endfunction
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
function! s:eval_with_radix(base, exp) abort " {{{
    let result = eval(a:exp)

    if type(0) != type(result)
        throw 'The result of the given expression have to be Number'
    endif

    return printf(s:format[a:base], result)
endfunction " }}}

inoremap <silent><expr> <C-G><C-B> <SID>eval_with_radix(2, input('= '))
inoremap <silent><expr> <C-G><C-O> <SID>eval_with_radix(8, input('= '))
inoremap <silent><expr> <C-G><C-D> <SID>eval_with_radix(10, input('= '))
inoremap <silent><expr> <C-G><C-H> <SID>eval_with_radix(16, input('= '))

if has('nvim')
    function! PreviewRadixesInsert() abort
        let l:n = line('.') - 1
        quit
        execute printf('normal! i%s', g:preview_radixes_values[l:n])
    endfunction

    function! PreviewRadixesAppend() abort
        let l:n = line('.') - 1
        quit
        execute printf('normal! a%s', g:preview_radixes_values[l:n])
    endfunction

    function! PreviewRadixesReplace() abort
        let l:n = line('.') - 1
        quit
        execute printf('normal! "_ciw%s', g:preview_radixes_values[l:n])
    endfunction

    function! s:preview_radixes(input) abort " {{{
        let l:integer = str2nr(a:input)
        if string(l:integer) != a:input
            echohl ErrorMsg | echo 'The given value `' . a:input . '` is NOT number.' | echohl None
            return
        endif

        let g:preview_radixes_values = [
                    \ printf('0b%b', l:integer),
                    \ printf('0o%o', l:integer),
                    \ printf('%d', l:integer),
                    \ printf('0x%x', l:integer),
                    \ ]

        let l:content = [
                    \ printf(' Bin: 0b%b ', l:integer),
                    \ printf(' Oct: 0o%o', l:integer),
                    \ printf(' Dec: %d', l:integer),
                    \ printf(' Hex: 0x%x', l:integer),
                    \ ]

        let l:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(l:buf, 0, -1, v:true, l:content)

        let l:opts = {'noremap': v:true, 'nowait': v:true}
        " Exit.
        call nvim_buf_set_keymap(l:buf, 'n', 'q', 'ZQ', l:opts)
        " Copy the number.
        call nvim_buf_set_keymap(l:buf, 'n', '<cr>', '02Wyiw', {})
        " Insert the number.
        call nvim_buf_set_keymap(l:buf, 'n', 'i', '<Cmd>call PreviewRadixesInsert()<CR>', l:opts)
        " Append the number.
        call nvim_buf_set_keymap(l:buf, 'n', 'a', '<Cmd>call PreviewRadixesAppend()<CR>', l:opts)
        " Replace the current cursor word by the number.
        call nvim_buf_set_keymap(l:buf, 'n', 'r', '<Cmd>call PreviewRadixesReplace()<CR>', l:opts)

        let l:opts = {
                    \ 'relative': 'cursor',
                    \ 'height': len(l:content),
                    \ 'width': max(map(l:content, {_, c -> len(c)})),
                    \ 'row': 1,
                    \ 'col': 0,
                    \ 'style': 'minimal'
                    \ }
        call nvim_open_win(l:buf, v:true, l:opts)
    endfunction " }}}

    command! -nargs=0 PreviewRadixes call <SID>preview_radixes(expand('<cword>'))
    command! -nargs=? PreviewRadixesEval call <SID>preview_radixes(eval(len(<q-args>) ? <q-args> : input('= ')))
endif
" }}}

" Convert the given word case.
if has('nvim') " {{{
    function! PreviewWordCasesReplace(n) abort
        if a:n == 0
            let l:n = line('.') - 1
        elseif 4 < a:n
            echoerr 'invalid'
            return
        else
            let l:n = a:n
        endif
        quit
        execute printf('normal! "_ciw%s', g:preview_word_cases_values[l:n])
    endfunction

    function! s:to_lower_snake_case(str) abort
        if empty(a:str) == 1
            return ''
        endif

        if stridx(a:str, '_') == -1
            " UpperCamelCase or lowerCamelCase
            return tolower(a:str[0]) . substitute(a:str[1:-1], '\(\u\)', '\="_" . tolower(submatch(1))', 'g')
        else
            " lower_snake_case or UPPER_SNAKE_CASE
            return tolower(a:str)
        endif
    endfunction

    function! s:to_upper_snake_case(str) abort
        return toupper(s:to_lower_snake_case(a:str))
    endfunction

    function! s:to_lower_camel_case(str) abort
        if empty(a:str) == 1
            return ''
        endif

        if stridx(a:str, '_') == -1
            " UpperCamelCase or lowerCamelCase
            return tolower(a:str[0]) . a:str[1 : -1]
        else
            " lower_snake_case or UPPER_SNAKE_CASE
            return substitute(tolower(a:str), '_\(.\)', '\=toupper(submatch(1))', 'g')
        endif
    endfunction

    function! s:to_upper_camel_case(str) abort
        if empty(a:str) == 1
            return ''
        endif

        let l:str = s:to_lower_camel_case(a:str)
        return toupper(l:str[0]) . l:str[1 : -1]
    endfunction

    function! s:preview_word_cases(word) abort " {{{
        let g:preview_word_cases_values = [
                    \ s:to_lower_snake_case(a:word),
                    \ s:to_upper_snake_case(a:word),
                    \ s:to_lower_camel_case(a:word),
                    \ s:to_upper_camel_case(a:word)
                    \ ]

        let l:content = [
                    \ ' 1: ' . g:preview_word_cases_values[0] . ' ',
                    \ ' 2: ' . g:preview_word_cases_values[1] . ' ',
                    \ ' 3: ' . g:preview_word_cases_values[2] . ' ',
                    \ ' 4: ' . g:preview_word_cases_values[3] . ' '
                    \ ]

        let l:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(l:buf, 0, -1, v:true, l:content)

        let l:opts = {'noremap': v:true, 'nowait': v:true, 'silent': v:true}
        " Exit.
        call nvim_buf_set_keymap(l:buf, 'n', 'q', 'ZQ', l:opts)
        call nvim_buf_set_keymap(l:buf, 'n', '<ESC>', 'ZQ', l:opts)
        " Copy the word.
        call nvim_buf_set_keymap(l:buf, 'n', 'y', '02Wyiw', {})
        " Replace the current cursor word by the selected case.
        call nvim_buf_set_keymap(l:buf, 'n', '<CR>', '<Cmd>call PreviewWordCasesReplace(0)<CR>', l:opts)
        call nvim_buf_set_keymap(l:buf, 'n', '1', '<Cmd>call PreviewWordCasesReplace(1)<CR>', l:opts)
        call nvim_buf_set_keymap(l:buf, 'n', '2', '<Cmd>call PreviewWordCasesReplace(2)<CR>', l:opts)
        call nvim_buf_set_keymap(l:buf, 'n', '3', '<Cmd>call PreviewWordCasesReplace(3)<CR>', l:opts)
        call nvim_buf_set_keymap(l:buf, 'n', '4', '<Cmd>call PreviewWordCasesReplace(4)<CR>', l:opts)

        let l:opts = {
                    \ 'relative': 'cursor',
                    \ 'height': len(l:content),
                    \ 'width': max(map(l:content, {_, c -> len(c)})),
                    \ 'row': 1,
                    \ 'col': 0,
                    \ 'style': 'minimal'
                    \ }
        call nvim_open_win(l:buf, v:true, l:opts)
    endfunction " }}}

    command! -nargs=0 PreviewWordCases call <SID>preview_word_cases(expand('<cword>'))
endif
" }}}

" Keep last session. {{{
let s:session_directory = '~/.vim/sessions/'
let s:last_session_filepath = s:session_directory . 'last_session.vim'

function! s:save_session(...) abort
    execute 'mksession!' (a:0 == 0) ? (s:last_session_filepath) : (s:session_directory . a:1)
endfunction

function! s:get_session_list(arguments, cmd_line, cursor_pos) abort
    let l:filepaths = split(glob(s:session_directory . '*'), '\n')
    return map(l:filepaths, {i, v -> fnamemodify(v, ':t')})
endfunction

nnoremap <silent> <Leader>ls <Cmd>LoadLastSession<CR>
command! -nargs=? -complete=customlist,<SID>get_session_list SaveSession call <SID>save_session(<f-args>)
command! -nargs=1 -complete=customlist,<SID>get_session_list LoadSession execute 'source' s:session_directory . <q-args>
command! -nargs=0 LoadLastSession execute 'source' s:last_session_filepath
" }}}

" Create Vim directories if not found. {{{
command! -nargs=0 CreateVimDirectories call s:create_vim_directories()
function! s:create_vim_directories() abort
    let base_dir = fnamemodify($MYVIMRC, ':h') . '/'
    call mkdir(base_dir . 'sessions', 'p')
    call mkdir(base_dir . 'undo', 'p')
    call mkdir(base_dir . 'backup', 'p')
    call mkdir(base_dir . 'swap', 'p')
    call mkdir(base_dir . 'swap', 'p')
endfunction
" }}}

command! -nargs=0 StoreTargetWin let t:target_window = win_getid()
command! -nargs=0 JumpTargetWin call win_gotoid(t:target_window)
nnoremap <expr> <Leader>' <Cmd>JumpTargetWin

function! s:hide_left_columns() abort " {{{
    setlocal nonumber
    setlocal norelativenumber
    setlocal signcolumn=no
    setlocal foldcolumn=0
endfunction " }}}
command! HideLeftColumns call s:hide_left_columns()

function! s:toggle_relative_number() abort " {{{
    let b:relnum = !get(b:, 'relnum', 1)

    if b:relnum
        setlocal relativenumber
    else
        setlocal norelativenumber
    endif

    setlocal number
endfunction " }}}
command! ToggleRelativeNumber call s:toggle_relative_number()

" Make the current window size adequate.
command! -nargs=0 ReduceVWinSizeAdequately :execute printf('resize %.0f', winheight(0) * 0.65)
command! -nargs=0 ReduceHWinSizeAdequately :execute printf('vertical resize %.0f', winwidth(0) * 0.65)

" jq command wrapper.
function! s:jq(...) abort " {{{
    execute '%! jq ' . (a:0 ? a:1 : '.')
    setlocal filetype=json
endfunction " }}}
command! -nargs=? Jq call s:jq(<f-args>)

" Fit the current window size to the longest line in the window.
" https://stackoverflow.com/questions/9148919
" https://github.com/inkarkat/vim-ingo-library/blob/a4ca05610e14c2bcf715319811d2b7aa20847940/autoload/ingo/window/dimensions.vim#L23-L39
function! s:fit_window_size_to_displayed_content(is_vertical) abort " {{{
    let l:left_column_width = &foldcolumn + (&number ? max([&numberwidth, strdisplaywidth(line('$'))]) : 0) + (&signcolumn ==# 'no' ? 0 : 2)
    if a:is_vertical
        execute 'vertical resize' l:left_column_width + max(map(range(0, line('$')), 'virtcol([v:val, "$"])')) - 1
    else
        let l:cnt = 0
        let l:line = 1
        let l:tail = line('$')
        let l:width = winwidth(0) - l:left_column_width
        while l:line <= l:tail
            let l:end = foldclosedend(l:line)
            if l:end == -1
                if &wrap
                    let l:cnt += virtcol([l:line, '$']) / l:width
                endif
                let l:line += 1
            else
                let l:line = l:end + 1
            endif
            let l:cnt += 1
        endwhile
        execute 'resize' l:cnt
    endif
endfunction " }}}
command! -nargs=0 -bang FitWindowSize call s:fit_window_size_to_displayed_content(expand('<bang>') != '!')

command! -nargs=0 RemoveBlankLines :global/^\s*$/delete

command! -nargs=0 ExecuteCurrentLine :execute getline('.')

let s:gote_dir = $HOME . '/notes'
function! s:gote() abort
    execute 'tcd' s:gote_dir
    FernExplorer
endfunction
command! -nargs=0 GoteOpen call s:gote()

function! s:gote_today() abort
    call s:gote()
    wincmd l

    let l:datestr = strftime('%Y-%m-%d')
    execute 'drop' strftime(s:gote_dir . '/daily/' . l:datestr . '.md')

    let l:text = [
                \'## ' . l:datestr ,
                \'',
                \'### 今日やったこと',
                \'',
                \'### 明日やること',
                \'',
                \'### 雑記',
                \'',
                \]
    call append(0, l:text)

    call cursor(4, 0)
endfunction
command! -nargs=0 GoteToday call s:gote_today()
" }}}

" GUI. {{{
function! s:config_neovide() abort
    set guifont=Cica:h14

    inoremap <silent><D-v> <ESC>l"+Pli
    cnoremap <silent><D-v> <C-R>+
    tnoremap <silent><D-v> <C-R>+

    let g:neovide_cursor_animation_length = 0.0
    let g:neovide_scroll_animation_length = 0.1
    let g:neovide_hide_mouse_when_typing = v:true
    let g:neovide_refresh_rate = 120
endfunction
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

    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && get(b:, 'relnum', 1) | setlocal relativenumber   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu && get(b:, 'relnum', 1) | setlocal norelativenumber | endif

    if executable('fcitx5-remote')
        " Disable IME when back to normal mode.
        autocmd InsertLeave,CmdLineLeave * call system('fcitx5-remote -c')
    endif

    " Turn on/off cursorline automatically.
    " Cheking the number of bytes is to avoid cleaning intro message when vim starts.
    let s:cur_f = 0
    autocmd WinEnter * setlocal cursorline | let s:cur_f = 0
    autocmd WinLeave * setlocal cursorline
    autocmd CursorHold,CursorHoldI * if wordcount()['bytes'] | setlocal cursorline | let s:cur_f = 1 | endif
    autocmd CursorMoved,CursorMovedI * if s:cur_f | setlocal nocursorline | endif

    autocmd FileType qf call s:define_quickfix_mappings()

    if has('nvim')
        " neovim server へ neovide から接続したときに設定を適用するため
        autocmd UIEnter * call s:config_neovide()
    endif
augroup END
" }}}

" Neovim. {{{
if has('nvim')
    set inccommand=split
    set scrollback=5000
    set wildoptions=

    tnoremap <silent> <ESC> <C-\><C-n>
    nnoremap <silent> <Leader>tm :terminal<CR>
    nnoremap <silent> <Leader>vst :vsplit term://zsh<CR>
    nnoremap <silent> <Leader>vtt :tabnew term://zsh<CR>

    autocmd mopp TermOpen * call s:hide_left_columns()
    autocmd mopp TermOpen * nnoremap <silent><buffer> <Enter> A

    if has('mac')
        let g:python3_host_prog = '/opt/homebrew/bin/python3'
    endif
endif
" }}}

" Plugins. {{{

" dein.vim {{{
let s:dein_base_path = expand('~/.vim/bundle/')
let s:dein_path = s:dein_base_path . 'repos/github.com/Shougo/dein.vim'
let s:has_dein = isdirectory(s:dein_path)
let &runtimepath .= ',' . s:dein_path
let g:dein#install_log_filename = '~/.vim/dein.log'

if s:has_dein && dein#load_state(s:dein_base_path) " {{{
    call dein#begin(s:dein_base_path)

    call dein#add('Shougo/dein.vim')
    call dein#add('haya14busa/dein-command.vim')

    " Completions {{{
    call dein#add('Shougo/deoplete.nvim', {'lazy': 1, 'on_event': 'InsertEnter', 'hook_post_source': 'call Hook_on_post_source_denite()'})

    let s:lazy_plete = {'lazy': 1, 'on_source': ['deoplete.nvim']}
    if !has('nvim')
        call dein#add('roxma/nvim-yarp', s:lazy_plete)
        call dein#add('roxma/vim-hug-neovim-rpc', s:lazy_plete)
    endif
    call dein#add('Shougo/neco-syntax', s:lazy_plete)
    call dein#add('Shougo/neco-vim', s:lazy_plete)
    call dein#add('Shougo/neoinclude.vim', s:lazy_plete)
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('Shougo/neosnippet.vim', s:lazy_plete)
    call dein#add('honza/vim-snippets', s:lazy_plete)
    call dein#add('hrsh7th/vim-neco-calc')
    call dein#add('lighttiger2505/deoplete-vim-lsp', s:lazy_plete)
    call dein#add('ujihisa/neco-look')
    " }}}

    " Denite {{{
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/neomru.vim')
    call dein#add('hrsh7th/vim-denite-gitto')
    call dein#add('hrsh7th/vim-gitto')
    call dein#add('neoclide/denite-git')
    call dein#add('notomo/denite-keymap')
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

    " LSP {{{
    call dein#add('liuchengxu/vista.vim', {'lazy': 1, 'on_cmd': 'Vista'})
    call dein#add('prabirshrestha/async.vim')
    call dein#add('prabirshrestha/vim-lsp')
    " }}}

    " git {{{
    call dein#add('airblade/vim-gitgutter', {'lazy': 1, 'on_event': ['BufWritePost', 'CursorMoved']})
    call dein#add('cohama/agit.vim', {'lazy': 1, 'on_cmd': 'Agit'})
    call dein#add('lambdalisue/gina.vim', {'lazy': 1, 'on_cmd': ['Gina', 'GinaAlias'], 'on_event': 'BufWritePost', 'hook_post_source': 'call Hook_on_post_source_gina()'})
    call dein#add('mattn/gist-vim', {'lazy': 1, 'on_cmd': 'Gist'})
    call dein#add('rhysd/committia.vim')
    call dein#add('rhysd/git-messenger.vim', {'lazy' : 1, 'on_cmd' : 'GitMessenger'})
    call dein#add('tyru/open-browser-github.vim', {'lazy': 1, 'on_cmd': ['OpenGithubFile', 'OpenGithubProject', 'OpenGithubPullReq']})
    " }}}

    " Utils {{{
    call dein#add('Chiel92/vim-autoformat', {'lazy': 1, 'on_cmd': 'Autoformat'})
    call dein#add('FooSoft/vim-argwrap', {'lazy': 1, 'on_cmd': 'ArgWrap'})
    call dein#add('Konfekt/FastFold')
    call dein#add('LeafCage/yankround.vim', {'lazy': 1, 'on_map': '<Plug>'})
    call dein#add('Shougo/deol.nvim', {'lazy': 1, 'on_cmd': ['Deol', 'DeolCd', 'DeolEdit']})
    call dein#add('Shougo/echodoc.vim', {'lazy': 1, 'on_event': 'InsertEnter'})
    call dein#add('Shougo/vinarise.vim', {'lazy':1, 'on_cmd': 'Vinarise'})
    call dein#add('Yggdroot/indentLine')
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('chrisbra/Colorizer', {'lazy': 1, 'on_cmd': 'ColorToggle'})
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
    call dein#add('lambdalisue/fern-git-status.vim')
    call dein#add('lambdalisue/fern-hijack.vim')
    call dein#add('lambdalisue/fern.vim')
    call dein#add('luochen1990/rainbow')
    call dein#add('mattn/learn-vimscript')
    call dein#add('mattn/webapi-vim')
    call dein#add('mopp/Arcadia')
    call dein#add('mopp/autodirmake.vim', {'lazy': 1, 'on_event': 'InsertEnter'})
    call dein#add('mopp/layoutplugin.vim', {'lazy': 1, 'on_cmd': 'LayoutPlugin'})
    call dein#add('osyo-manga/vim-anzu')
    call dein#add('osyo-manga/vim-stargate', {'lazy': 1, 'on_cmd': 'StargateInclude'})
    call dein#add('previm/previm', {'lazy': 1, 'on_cmd': 'PrevimOpen', 'on_ft': 'markdown'})
    call dein#add('rickhowe/diffchar.vim', {'lazy':  &diff == 0, 'on_if': '&diff'})
    call dein#add('simeji/winresizer', {'lazy': 1, 'on_cmd': ['WinResizerStartFocus', 'WinResizerStartMove', 'WinResizerStartResize']})
    call dein#add('szw/vim-maximizer', {'lazy': 1, 'on_cmd': 'MaximizerToggle'})
    call dein#add('t9md/vim-choosewin', {'lazy': 1, 'on_map': {'n': '<Plug>'}})
    call dein#add('t9md/vim-quickhl', {'lazy': 1, 'on_map' : {'nx': '<Plug>'}})
    call dein#add('thinca/vim-ambicmd')
    call dein#add('thinca/vim-quickrun', {'lazy': 1, 'on_cmd': 'QuickRun'})
    call dein#add('thinca/vim-visualstar', {'lazy': 1, 'on_map': {'v': ['*', '#']}})
    call dein#add('tpope/vim-repeat')
    call dein#add('tyru/capture.vim', {'lazy': 1, 'on_cmd': 'Capture'})
    call dein#add('tyru/caw.vim', {'lazy': 1, 'on_map': '<Plug>(caw:', 'hook_post_source': 'doautocmd plugin FileType'})
    call dein#add('tyru/open-browser.vim', {'lazy': 1, 'on_map': [['n', '<Plug>(openbrowser-open)']], 'on_func': ['openbrowser#load', 'openbrowser#open'], 'on_source': ['open-browser-github.vim']})
    call dein#add('vim-scripts/copypath.vim', {'lazy': 1, 'on_cmd': ['CopyPath', 'CopyFileName']})
    " }}}

    " Languages {{{
    call dein#add('Shirk/vim-gas')
    call dein#add('aklt/plantuml-syntax')
    call dein#add('cespare/vim-toml')
    call dein#add('ekalinin/Dockerfile.vim')
    call dein#add('elixir-editors/vim-elixir')
    call dein#add('elzr/vim-json')
    call dein#add('fatih/vim-go', {'lazy': 1, 'on_ft': 'go'})
    call dein#add('hashivim/vim-terraform')
    call dein#add('lifepillar/pgsql.vim')
    call dein#add('rust-lang/rust.vim', {'lazy': 1, 'on_ft': 'rust'})
    call dein#add('shima-529/C-prototype.vim', {'lazy': 1, 'on_ft': 'c'})
    call dein#add('stephpy/vim-yaml')
    call dein#add('vim-erlang/vim-erlang-omnicomplete', {'lazy': 1, 'on_ft': 'erlang'})
    call dein#add('vim-erlang/vim-erlang-runtime')
    call dein#add('vim-jp/cpp-vim')
    call dein#add('vim-jp/vimdoc-ja')
    call dein#add('vim-ruby/vim-ruby')
    call dein#add('vim-scripts/sh.vim--Cla')

    call dein#add('leafgarland/typescript-vim')
    call dein#add('peitalin/vim-jsx-typescript')
    call dein#add('hail2u/vim-css3-syntax')
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
    autocmd FileType ruby,javascript,typescript,typescriptreact,html,css,pony,markdown setlocal shiftwidth=2
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
    set nocursorline
endfunction
" }}}

" deoplete.nvim {{{
let g:deoplete#enable_at_startup = 1
function! Hook_on_post_source_denite() abort
    call deoplete#custom#option({
                \ 'max_list': 250,
                \ 'skip_multibyte': v:true,
                \ 'ignore_sources': {'_': ['look']},
                \ })
    call deoplete#custom#source('look', {
                \ 'min_pattern_length': 4,
                \ 'disabled_syntaxes': ['Normal']
                \ })
endfunction
command! DisableNecoLook call deoplete#custom#option('ignore_sources', {'_': ['look']})
command! EnableNecoLook call deoplete#custom#option('ignore_sources', {})
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
    nnoremap <silent> <Leader>n <Cmd>Denite -resume -immediately -cursor-pos=+1 -no-empty<CR>
    nnoremap <silent> <Leader>p <Cmd>Denite -resume -immediately -cursor-pos=-1 -no-empty<CR>
    nnoremap <silent> <Leader>fb  <Cmd>Denite buffer<CR>
    nnoremap <silent> <Leader>fe  <Cmd>Denite file/rec<CR>
    nnoremap <silent> <Leader>ff  <Cmd>Denite file_mru<CR>
    nnoremap <silent> <Leader>fd  <Cmd>Denite -default-action=tab_open directory_mru<CR>
    nnoremap <silent> <Leader>fgg <Cmd>Denite grep/ignore_test<CR>
    nnoremap <silent> <Leader>fgw <Cmd>DeniteCursorWord grep/ignore_test<CR>
    nnoremap <silent> <Leader>fl  <Cmd>Denite line<CR>
    nnoremap <silent> <Leader>fo  <Cmd>Denite outline<CR>
    nnoremap <silent> <Leader>fre <Cmd>Denite -resume<CR>
    nnoremap <silent> <Leader>git <Cmd>DeniteGitto gitto<CR>
    nnoremap <silent> <Leader>gic <Cmd>Denite gitchanged<CR>
    nnoremap <silent> <Leader>gis <Cmd>Denite gitstatus<CR>

    function! s:denite_settings() abort " {{{
        nnoremap <silent><buffer><expr><nowait> <CR> denite#do_map('do_action')
        nnoremap <silent><buffer><expr><nowait> <TAB> denite#do_map('choose_action')
        nnoremap <silent><buffer><expr><nowait> <ESC> denite#do_map('quit')
        nnoremap <silent><buffer><expr><nowait> q denite#do_map('quit')
        nnoremap <silent><buffer><expr><nowait> <Space> denite#do_map('toggle_select').'j'
        nnoremap <silent><buffer><expr><nowait> n denite#do_map('quick_move')
        nnoremap <silent><buffer><expr><nowait> i denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr><nowait> p denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr><nowait> t denite#do_map('do_action', 'tabopen')
        nnoremap <silent><buffer><expr><nowait> v denite#do_map('do_action', 'vsplit')
        nnoremap <silent><buffer><expr><nowait> s denite#do_map('do_action', 'split')
        nnoremap <silent><buffer><expr><nowait> dd denite#do_map('do_action', 'delete')
        nnoremap <silent><buffer><expr><nowait> <C-h> denite#do_map('restore_sources')
    endfunction " }}}

    function! s:denite_filter_settings() abort " {{{
        let b:lexima_disabled = 1
        call deoplete#custom#buffer_option('auto_complete', v:false)
        imap <silent><buffer><nowait> <ESC> <Plug>(denite_filter_quit)
        nmap <silent><buffer><nowait> <ESC> <Plug>(denite_filter_quit)
    endfunction " }}}

    call denite#custom#option('_', {
                \ 'highlight_matched_char': 'Keyword',
                \ 'highlight_matched_range': 'None',
                \ 'auto_resize': v:true,
                \ 'statusline': v:false,
                \ })
    call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'sorter_rank', 'matcher_project_files'])

    if system('git rev-parse --is-inside-work-tree') == "true\n" " {{{
        call denite#custom#var('file/rec', 'command', ['git', 'ls-files', '--cached', '--others', '--exclude-standard'])

        let s:opts = {
                    \ 'command': ['git', '--no-pager', 'grep'],
                    \ 'default_opts': ['--line-number', '--no-color'],
                    \ 'recursive_opts': [],
                    \ 'pattern_opt': ['-e'],
                    \ 'separator': ['--'],
                    \ 'final_opts': [],
                    \ }
        call denite#custom#var('grep', s:opts)

        call denite#custom#alias('source', 'grep/ignore_test', 'grep')
        let s:opts['final_opts'] = [
                    \ ':(exclude)*spec/*',
                    \ ':(exclude)*_spec.rb',
                    \ ':(exclude)*test.*',
                    \ ':(exclude)*__tests__*'
                    \ ]
        call denite#custom#var('grep/ignore_test', s:opts)
    elseif executable('rg')
        call denite#custom#var('file/rec', 'command', ['rg', '--files', '--color', 'never'])

        call denite#custom#var('grep', {
                    \ 'command': ['rg'],
                    \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
                    \ 'recursive_opts': [],
                    \ 'pattern_opt': ['--regexp'],
                    \ 'separator': ['--'],
                    \ 'final_opts': [],
                    \ })
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
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)
nmap <Leader>hp <Plug>(GitGutterPrevHunk)
nmap <Leader>hn <Plug>(GitGutterNextHunk)
" }}}

" vim-trailing-whitespace
let g:extra_whitespace_ignored_filetypes = ['denite', 'help']

" vim-easymotion
map <Leader>e <Plug>(easymotion-prefix)

" lightline.vim {{{
let g:lightline = {
            \ 'colorscheme': 'arcadia',
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified'], ['readonly', 'spell'], ['git_status'], ['anzu']],
            \   'right': [['fileencoding', 'fileformat'], ['filetype']],
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
            \ 'tab_component_function': {
            \    'filename': 'LightlineTabFilename'
            \  },
            \ 'component': {
            \   'mode':         '%{ get(g:lightline_plugin_modes, &filetype, lightline#mode()) }',
            \   'modified':     "%{ (LightlineIsVisible() && &modifiable) ? (&modified ? '[+]' : '[-]') : '' }",
            \   'readonly':     "%{ (LightlineIsVisible() && &readonly) ? 'RO' : '' }",
            \   'git_status':   "%{ (LightlineIsVisible() && dein#is_sourced('gina.vim')) ? printf('%s: [%s]', gina#component#repo#branch(), gina#component#status#preset()) : '' }",
            \   'filetype':     "%{ LightlineIsVisible() ? &filetype : '' }",
            \   'fileencoding': "%{ LightlineIsVisible() ? (strlen(&fenc) ? &fenc : &enc) : '' }",
            \   'fileformat':   "%{ LightlineIsVisible() ? &fileformat : '' }",
            \ },
            \ 'component_visible_condition': {
            \   'modified':     'LightlineIsVisible() && &modifiable',
            \   'fileencoding': 'LightlineIsVisible()',
            \   'fileformat':   'LightlineIsVisible()',
            \   'anzu':         'LightlineIsVisible()',
            \ },
            \ 'component_function': {
            \   'filename':   'LightlineFilename',
            \   'anzu':       'anzu#search_status',
            \ },
            \ }

let g:lightline_plugin_modes = {'denite': 'Denite', 'denite-filter': "Denite", 'fern': 'Fern', 'vista': 'Vista'}

function! LightlineIsVisible() abort
    return (60 <= winwidth(0)) && (&filetype !~? 'fern\|vista\|denite\|help')
endfunction

function! LightlineFilename() abort " {{{
    if &filetype ==# 'denite'
        return denite#get_status('sources')
    elseif &filetype ==# 'denite-filter'
        return ''
    elseif &filetype ==# 'fern'
        return split(expand('%:t'), ';')[0]
    elseif &filetype ==# 'vista'
        return ''
    else
        let l:t = expand('%:t')
        return l:t ==# '' ? '[No Name]' : l:t
    endif
endfunction " }}}

function! LightlineTabFilename(n) abort " {{{
    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
    let l:bufnr = l:buflist[l:winnr - 1]
    let l:filetype = getbufvar(l:bufnr, "&filetype")
    let l:fname = expand('#' . l:bufnr . ':t')

    if l:filetype ==# 'fern'
        return split(fname, ';')[0]
    else
        return l:fname ==# '' ? '[No Name]' : l:fname
    endif
endfunction " }}}
" }}}

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
nnoremap <silent> <Esc><Esc> <Cmd>nohlsearch <bar> :AnzuClearSearchStatus<CR>
" }}}

" open-browser.vim
map <Leader>op <Plug>(openbrowser-open)

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
nnoremap <silent><F3> <Cmd>MaximizerToggle<CR>
vnoremap <silent><F3> <Cmd>MaximizerToggle<CR>gv
inoremap <silent><F3> <C-O><Cmd>MaximizerToggle<CR>
" }}}

" gina.vim {{{
function! Hook_on_post_source_gina() abort
    let l:silent_opt = {'mode': 'n', 'silent': 1}
    let l:cmd_opt = {'mode': 'n', 'noremap': 1, 'silent': 1}
    call gina#custom#mapping#nmap('branch', 'n', '<Plug>(gina-branch-new)', l:silent_opt)
    call gina#custom#mapping#nmap('branch', 'r', '<Plug>(gina-branch-move)', l:silent_opt)
    call gina#custom#mapping#nmap('branch', 'd', '<Plug>(gina-branch-delete)', l:silent_opt)
    call gina#custom#mapping#nmap('status', 'dd', '<Plug>(gina-diff-vsplit)')
    call gina#custom#mapping#nmap('status', '<C-\>', '<Cmd>Gina commit<CR>', l:cmd_opt)
    call gina#custom#mapping#nmap('commit', '<C-\>', '<Cmd>Gina status<CR>', l:cmd_opt)
    call gina#custom#mapping#nmap('/.*', 'q', '<Cmd>quit<CR>', l:cmd_opt)
    call gina#custom#mapping#nmap('/.*', 't', '<Plug>(gina-edit-tab)', l:silent_opt)
    call gina#custom#mapping#nmap('/.*', '<Tab>', '<Plug>(gina-builtin-choice)', l:silent_opt)
    call gina#custom#mapping#nmap('/.*', '<C-t>', '<Plug>(gina-edit-tab)', l:silent_opt)
    call gina#custom#mapping#nmap('/.*', '<C-h>', '<Plug>(gina-edit-left)', l:silent_opt)
    call gina#custom#mapping#nmap('/.*', '<C-j>', '<Plug>(gina-edit-below)', l:silent_opt)
    call gina#custom#mapping#nmap('/.*', '<C-k>', '<Plug>(gina-edit-above)', l:silent_opt)
    call gina#custom#mapping#nmap('/.*', '<C-l>', '<Plug>(gina-edit-right)', l:silent_opt)
    call gina#custom#command#option('/\%(commit\|status\|branch\|changes\|grep\|log\)', '--opener', 'split')
    call gina#custom#command#option('/\%(commit\|status\|branch\|changes\|grep\|log\)', '--group', 'main')
endfunction
nnoremap <Leader>gb <Cmd>Gina branch<CR>
nnoremap <Leader>gc <Cmd>Gina commit<CR>
nnoremap <Leader>gd <Cmd>Gina diff<CR>
nnoremap <Leader>gs <Cmd>Gina status<CR>
function! s:get_git_aliases(...) abort
    return system('git config --get-regexp alias | sed "s/alias\.\(\w*\)\s.*/\1/g"')
endfunction
command! -nargs=1 -complete=custom,<SID>get_git_aliases GinaAlias :Gina! <f-args>
" }}}

" lexima.vim {{{
imap <C-h> <BS>
cmap <C-h> <BS>
function! Hook_on_post_source_lexima() abort
    let l:rules = []

    for l:char in ['+', '-', '*', '/', '%', '<', '>', '&', '=', '<Bar>']
        call add(l:rules, {'char': l:char, 'at': '\S\+\%#', 'except': '''.*\%#.*''', 'input': ' ' . l:char . ' '})
    endfor
    call add(l:rules, {'char': '<BS>', 'at': '\w\+\s\(+\|-\|\*\|%\|<\|>\|&\|=\||\)\s\%#', 'input': '<BS><BS><BS>'})

    for l:char in ['*', '<', '>', '&', '=', '<Bar>', '/']
        call add(l:rules, {'char': l:char, 'at': l:char . '\s\%#', 'input': '<BS>' . l:char . ' '})
    endfor
    call add(l:rules, {'char': '<BS>', 'at': '\s\(++\|\*\*\|<<\|>>\|&&\|||\)\s\%#', 'input': '<BS><BS><BS><BS>'})

    let l:rules +=
                \ [
                \ {'char': '-', 'at': '< \%#', 'input': '<BS>- ', 'priority': 10},
                \
                \ {'char': '<TAB>', 'at': '([()]*\%#[)]*)', 'input': '<Right>'},
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
                \ {'filetype': ['erlang'], 'char': '`',     'input': '`''<Left>', 'syntax': 'Comment'},
                \
                \ {'filetype': ['elixir'], 'char': '<Bar>', 'at': '^\s\+\%#', 'input': '|> ', 'priority': 10},
                \ {'filetype': ['elixir'], 'char': '>', 'at': '|\%#', 'input': '> ', 'priority': 10},
                \
                \ {'filetype': ['ruby'], 'char': '<Bar>', 'at': '{\%#}', 'input': '||<Left>', 'priority': 10},
                \ {'filetype': ['ruby'], 'char': '{', 'at': '\w\+\%#', 'input': ' {}<Left>', 'priority': 10},
                \
                \ {'filetype': ['go'], 'char': '=', 'at': ':\%#', 'input': '<BS> := '},
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

" vim-unmatchparen
let g:unmatchparen#disable_filetypes = ['vim']

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" fern.vim {{{
command! FernExplorer Fern -drawer -width=40 .
nnoremap <silent> <leader>de <Cmd>FernExplorer<CR>

function! s:init_fern() abort
    nnoremap <silent><buffer> q <Cmd>quit<CR>
    nnoremap <silent><buffer> w <Plug>(fern-action-open:split)
    nnoremap <silent><buffer> e <Plug>(fern-action-open:drop)
    nnoremap <silent><buffer> dd <Plug>(fern-action-remove)
    nnoremap <silent><buffer> J <Plug>(fern-action-new-file)

    " Overwrite search mapping to disable vim-search-pulse on fern buffer.
    " It does not works well.
    nmap <silent><buffer> n <Plug>(anzu-n)
    nmap <silent><buffer> N <Plug>(anzu-N)
    nmap <silent><buffer> * <Plug>(anzu-star)
    nmap <silent><buffer> # <Plug>(anzu-sharp)
endfunction
" }}}

" vim-ambicmd
if dein#tap('vim-ambicmd') " {{{
    cnoremap <expr> <CR> ambicmd#expand('<CR>')
    cnoremap <expr> <Space> ambicmd#expand('<Space>')
endif " }}}

" rhysd/committia.vim
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    setlocal spell
    imap <buffer> <C-K> <Plug>(committia-scroll-diff-up-half)
    imap <buffer> <C-J> <Plug>(committia-scroll-diff-down-half)
    nmap <buffer> <C-K> <Plug>(committia-scroll-diff-up-half)
    nmap <buffer> <C-J> <Plug>(committia-scroll-diff-down-half)
endfunction

" vim-lsp {{{
let g:lsp_auto_enable = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 300
if executable('solargraph')
    autocmd mopp User lsp_setup call lsp#register_server({
                \ 'name': 'solargraph',
                \ 'cmd': {server_info -> [&shell, &shellcmdflag, 'solargraph stdio']},
                \ 'config': {'diagnostics': v:false},
                \ 'allowlist': ['ruby'],
                \ })
endif
if executable('rustup')
    autocmd mopp User lsp_setup call lsp#register_server({
                \ 'name': 'rust-analyzer',
                \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rust-analyzer']},
                \ 'allowlist': ['rust'],
                \ })
endif
if executable('gopls')
    autocmd mopp User lsp_setup call lsp#register_server({
                \ 'name': 'gopls',
                \ 'cmd': {server_info -> ['gopls']},
                \ 'allowlist': ['go'],
                \ })
    autocmd mopp FileType go setlocal omnifunc=lsp#complete
endif
if executable('clangd')
    autocmd mopp User lsp_setup call lsp#register_server({
                \ 'name': 'clangd',
                \ 'cmd': {server_info -> ['clangd', '-background-index']},
                \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
                \ })
endif
if executable('elixir-ls')
    autocmd mopp User lsp_setup call lsp#register_server({
                \ 'name': 'elixir-ls',
                \ 'cmd': {server_info -> ['elixir-ls']},
                \ 'allowlist': ['elixir', 'eelixir'],
                \ })
endif
if executable('typescript-language-server')
    autocmd mopp User lsp_setup call lsp#register_server({
                \ 'name': 'typescript-language-server',
                \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
                \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
                \ 'allowlist': ['typescript', 'typescript.tsx', 'typescriptreact'],
                \ })
endif
augroup mopp_lsp
    autocmd!
    autocmd FileType ruby,rust,go,c,cpp,elixir,typescriptreact,typescript call lsp#enable()
augroup END
nmap <Leader>lc <plug>(lsp-declaration)
nmap <Leader>ld <plug>(lsp-definition)
nmap <Leader>lp <plug>(lsp-peek-definition)
nmap <Leader>lh <plug>(lsp-hover)
nmap <Leader>lr <plug>(lsp-references)
" }}}

" vista.vim
let g:vista_echo_cursor = 0
let g:vista_echo_cursor_strategy = 'floating_win'

" winresizer
let g:winresizer_start_key = '<Nop>'

" indentLine
let g:indentLine_fileTypeExclude = ['fern', 'vista', 'denite', 'help']
let g:indentLine_faster = 1
let g:indentLine_color_term = 248
let g:indentLine_setConceal = 0
let g:indentLine_concealcursor = ''

" pgsql.vim
let g:sql_type_default = 'pgsql'

" typescript-vim
" vim-jsx-typescript
function! s:override_tsx_highlights() abort
    highlight! link tsxAttrib typescriptParens
    highlight! link tsxAttributeBraces typescriptBraces
    highlight! link tsxTagName tsxTypes
    highlight! link tsxCloseTagName tsxTypes
    highlight! link tsxTag typescriptParens
    highlight! link tsxCloseTag typescriptParens
    highlight! link tsxEqual Normal
    highlight! ReactState guifg=#C176A7
    highlight! ReactProps guifg=#D19A66
    highlight! ApolloGraphQL guifg=#CB886B
    highlight! Events ctermfg=204 guifg=#56B6C2
    highlight! ReduxKeywords ctermfg=204 guifg=#C678DD
    highlight! ReduxHooksKeywords ctermfg=204 guifg=#C176A7
    highlight! WebBrowser ctermfg=204 guifg=#56B6C2
    highlight! ReactLifeCycleMethods ctermfg=204 guifg=#D19A66
endfunction

" Autocommands for plugins.  {{{
augroup plugin
    autocmd!

    autocmd FileType gina-commit setlocal spell
    autocmd FileType erlang let b:caw_oneline_comment = '%%'
    autocmd FileType tex if dein#is_sourced('deoplete.nvim') | call deoplete#custom#buffer_option('auto_complete', v:false) | endif
    autocmd FileType fern call s:init_fern()
    autocmd FileType denite call s:denite_settings()
    autocmd FileType denite-filter call s:denite_filter_settings()
    autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
    autocmd FileType typescriptreact call s:override_tsx_highlights()
augroup END
" }}}
" }}}

syntax enable

set termguicolors
colorscheme arcadia
