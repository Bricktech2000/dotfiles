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

set belloff=all
set noswapfile updatetime=100
set autoread
set fileformat=unix

" behavior

autocmd Filetype * set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype * set formatoptions=
set expandtab smartindent

set ignorecase smartcase hlsearch incsearch
set wildmenu wildoptions=pum wildignorecase path+=** " :fin as fuzzy finder

let g:mapleader = ' '
set mouse=a

" looks

set nonumber signcolumn=yes
set wrap linebreak showbreak=\|\  breakindent breakindentopt=
silent! set smoothscroll
set scrolloff=12 sidescrolloff=12
set noshowmode noruler showcmd shortmess=sWFlI laststatus=0
let g:netrw_banner = 0

let &t_SI = "\<esc>[6 q" " see :h guicursor
let &t_SR = "\<esc>[4 q"
let &t_EI = "\<esc>[2 q"

" essentials

nnoremap <c-l> <cmd>nohlsearch<bar>echo<cr>
nnoremap <leader>w <cmd>set wrap!<cr>
nnoremap <leader>s <cmd>write<cr>
nnoremap <leader>q <cmd>quit!<cr>
vnoremap * y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
vnoremap # y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
let g:surround_{char2nr('*')} = "**\r**"
let g:surround_{char2nr('~')} = "~~\r~~"
let g:surround_{char2nr('[')} = "[[\r]]"
autocmd FileType c set commentstring=//\ %s
autocmd FileType cpp set commentstring=//\ %s " .h files

function! s:record_macro()
  let s:last_reg = nr2char(getchar())
  execute 'normal! q'.s:last_reg
endfunction

function! s:exec_last_recorded()
  execute 'normal! @'.s:last_reg
endfunction

let s:last_reg = '"'
noremap <expr> q reg_recording() == '' ? '<cmd>call <sid>record_macro()<cr>' : 'q'
nnoremap Q <cmd>call <sid>exec_last_recorded()<cr>| " emulates the Neovim binding

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

Plug 'llathasa-veleth/vim-brainfuck'
Plug 'vim-scripts/bnf.vim'
autocmd BufNewFile,BufRead *.bnf set filetype=bnf
Plug 'bhurlow/vim-parinfer'
autocmd BufNewFile,BufRead *.md set suffixesadd=.md " [[wikilinks]]
autocmd BufNewFile,BufRead *.md set includeexpr=substitute(v:fname,'%20','\ ','g')

" colorscheme

Plug 'tomasr/molokai'
let g:rehash256 = 1
set notermguicolors

autocmd ColorScheme * highlight Normal     ctermbg=none
autocmd ColorScheme * highlight NonText    ctermbg=none ctermfg=244 term=bold| " same as Comment
autocmd ColorScheme * highlight Folded     ctermbg=none
autocmd ColorScheme * highlight LineNr     ctermbg=none
autocmd ColorScheme * highlight SignColumn ctermbg=none
autocmd ColorScheme * highlight Visual     ctermbg=238  ctermfg=none
autocmd ColorScheme * highlight Search     ctermbg=none ctermfg=7  cterm=bold
autocmd ColorScheme * highlight IncSearch  ctermbg=253  ctermfg=16 cterm=bold| " same as Cursor
autocmd ColorScheme * highlight Question   ctermbg=none ctermfg=7  cterm=bold| " same as Search
autocmd ColorScheme * highlight ErrorMsg   ctermbg=none ctermfg=7  cterm=bold| " same as Search
autocmd ColorScheme * highlight WarningMsg ctermbg=none ctermfg=7  cterm=bold| " same as Search
autocmd ColorScheme * highlight Pmenu      ctermbg=none ctermfg=7  cterm=none
autocmd ColorScheme * highlight PmenuSel   ctermbg=253  ctermfg=16 cterm=none| " same as Cursor
autocmd ColorScheme * highlight StatusLine ctermbg=0    ctermfg=0  cterm=none
autocmd ColorScheme * highlight StatusLineNC ctermbg=0  ctermfg=0  cterm=none
autocmd ColorScheme * highlight Wildmenu   ctermbg=253  ctermfg=16 cterm=none| " same as Cursor
autocmd ColorScheme * highlight MatchParen ctermbg=none ctermfg=7  cterm=bold| " same as Search
autocmd ColorScheme * highlight VertSplit  ctermbg=none ctermfg=0

" miscellaneous

Plug 'airblade/vim-gitgutter'
autocmd ColorScheme * highlight GitGutterAdd    ctermbg=none ctermfg=244 term=bold| " same as Comment
autocmd ColorScheme * highlight GitGutterChange ctermbg=none ctermfg=244 term=bold| " same as Comment
autocmd ColorScheme * highlight GitGutterDelete ctermbg=none ctermfg=244 term=bold| " same as Comment
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_removed_above_and_below = '|'
let g:gitgutter_sign_modified_removed = '|'

autocmd BufEnter * syntax match Trailing /\s\+$/
autocmd ColorScheme * highlight Trailing ctermbg=238 ctermfg=none| " same as Visual

" why Vim why

for key in ['<up>', '<down>', '<left>', '<right>', '<bs>', '<space>']
  execute 'nnoremap ' . key . ' <nop>'
  execute 'vnoremap ' . key . ' <nop>'
endfor

call plug#end()

colorscheme molokai
