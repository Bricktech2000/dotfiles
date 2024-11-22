" bootstrap vim-plug. taken verbatim from documentation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

set nocompatible
filetype plugin on
set backspace=indent,eol,start

" system
set noswapfile updatetime=100
set autoread
set fileformat=unix

" terminal
set belloff=all mouse=a
let &t_SI = "\<esc>[6 q" " see :h guicursor
let &t_SR = "\<esc>[4 q"
let &t_EI = "\<esc>[2 q"

" reduce clutter
set nonumber signcolumn=yes
set noshowmode noruler showcmd shortmess=sWFlI laststatus=0
let g:netrw_banner = 0

set scrolloff=12 sidescrolloff=12
set wrap linebreak showbreak=\|\  breakindent breakindentopt=
silent! set smoothscroll " unfortunate this is a buggy afterthought

" typographic characters
set list listchars=tab:>-,trail:#,nbsp:+
set iminsert=1 " see :h mapmode-l
lnoremap <c-space> <c-k>NS
lnoremap <c-/> <c-k>-N
lnoremap <c-_> <c-k>-M| " for Vim
lnoremap <c--> <c-k>-M| " for Neovim
lnoremap <c-'> <c-k>'9

" some of Neovim's `default-mappings`, except less broken
xnoremap * y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
xnoremap # y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
noremap <c-l> <cmd>nohlsearch<bar>normal! <c-l><cr>
nnoremap Y y$

" all things search
set ignorecase smartcase hlsearch incsearch
set wildmenu wildoptions=pum wildignorecase path+=** " :fin as fuzzy finder
noremap / /\v
noremap ? ?\v
cnoremap %s/ %s/\v
xnoremap :s/ :s/\v
cnoremap vim/ vim/\v

" essential plugins
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
let g:surround_{char2nr('*')} = "**\r**"
let g:surround_{char2nr('~')} = "~~\r~~"
let g:surround_{char2nr('[')} = "[[\r]]"
autocmd FileType c set commentstring=//\ %s
autocmd FileType cpp set commentstring=//\ %s " .h files

" emulate Neovim's `Q` binding

function! s:record_macro()
  let s:last_reg = nr2char(getchar())
  execute 'normal! q'.s:last_reg
endfunction

function! s:exec_last_recorded()
  execute 'normal! @'.s:last_reg
endfunction

let s:last_reg = ''
noremap <expr> q reg_recording() == '' ? '<cmd>call <sid>record_macro()<cr>' : 'q'
noremap Q <cmd>call <sid>exec_last_recorded()<cr>

" undo tree plugins have it all backward. the way to make Vim's undo tree nicer
" is to create bindings to jump around it more freely, not to make some ASCII
" art visualization with `hjkl` navigation

function! s:mark_undo_point()
  let b:undo_marks[getchar()] = undotree().seq_cur
endfunction

function! s:undo_to_mark()
  let seq_cur = undotree().seq_cur
  execute 'undo '.get(b:undo_marks, getchar(), seq_cur)
  let b:undo_marks[char2nr("'")] = seq_cur " for g''
endfunction

autocmd BufNewFile,BufRead * let b:undo_marks = {}
nnoremap gm <cmd>call <sid>mark_undo_point()<cr>
nnoremap g' <cmd>call <sid>undo_to_mark()<cr>
nnoremap U <cmd>undo!<cr>| " to keep tree clean
nnoremap g= g+| " g=g=g= less awkward than g+g+g+

" languages

autocmd Filetype * set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype * set formatoptions=
set expandtab smartindent

Plug 'llathasa-veleth/vim-brainfuck'
Plug 'vim-scripts/bnf.vim'
autocmd BufNewFile,BufRead *.bnf set filetype=bnf
autocmd BufNewFile,BufRead *.md set suffixesadd=.md " [[wikilinks]]
autocmd BufNewFile,BufRead *.md set includeexpr=substitute(v:fname,'%20','\ ','g')

" colorscheme

Plug 'tomasr/molokai'
let g:rehash256 = 1
set notermguicolors

autocmd ColorScheme molokai call <sid>molokai_hi()
function! s:molokai_hi()
  highlight Normal     ctermbg=none
  highlight NonText    ctermbg=none ctermfg=244 term=bold| " same as Comment
  highlight Folded     ctermbg=none
  highlight LineNr     ctermbg=none
  highlight SignColumn ctermbg=none
  highlight Visual     ctermbg=238  ctermfg=none
  highlight Search     ctermbg=none ctermfg=7  cterm=bold
  highlight IncSearch  ctermbg=253  ctermfg=16 cterm=bold| " same as Cursor
  highlight Question   ctermbg=none ctermfg=7  cterm=bold| " same as Search
  highlight ErrorMsg   ctermbg=none ctermfg=7  cterm=bold| " same as Search
  highlight WarningMsg ctermbg=none ctermfg=7  cterm=bold| " same as Search
  highlight Pmenu      ctermbg=none ctermfg=7  cterm=none
  highlight PmenuSel   ctermbg=253  ctermfg=16 cterm=none| " same as Cursor
  highlight StatusLine ctermbg=0    ctermfg=0  cterm=none
  highlight StatusLineNC ctermbg=0  ctermfg=0  cterm=none
  highlight Wildmenu   ctermbg=253  ctermfg=16 cterm=none| " same as Cursor
  highlight MatchParen ctermbg=none ctermfg=7  cterm=bold| " same as Search
  highlight VertSplit  ctermbg=none ctermfg=0
endfunction

" miscellaneous

Plug 'airblade/vim-gitgutter'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_removed_above_and_below = '|'
let g:gitgutter_sign_modified_removed = '|'

autocmd ColorScheme molokai call <sid>gitgutter_hi()
function! s:gitgutter_hi()
  highlight GitGutterAdd    ctermbg=none ctermfg=244 term=bold| " same as Comment
  highlight GitGutterChange ctermbg=none ctermfg=244 term=bold| " same as Comment
  highlight GitGutterDelete ctermbg=none ctermfg=244 term=bold| " same as Comment
endfunction

call plug#end()

colorscheme molokai
