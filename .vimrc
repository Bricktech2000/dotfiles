" bootstrap vim-plug. from vim-plug documentation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

set nocompatible
filetype plugin on
set hidden
set history=10000

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
let g:netrw_cursor = 0 " don't override 'cursorline' please

" text layout
set display=lastline
set scrolloff=12 sidescrolloff=12
set wrap linebreak showbreak=\|\  breakindent breakindentopt=
silent! set smoothscroll " unfortunate this is a buggy afterthought

" typographic characters
set list listchars=tab:>-,trail:#
set iminsert=1 " see :h mapmode-l
lnoremap <c-space> <c-k>NS
lnoremap <c-/> <c-k>-N
lnoremap <c-_> <c-k>-M| " for Vim
lnoremap <c--> <c-k>-M| " for Neovim
lnoremap <c-'> <c-k>'9
autocmd BufEnter * syntax match nonascii /[^\x00-\x7f]/ containedin=ALL
autocmd BufEnter * highlight nonascii cterm=underline

" some of Neovim's `default-mappings`, except less broken
xnoremap * y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
xnoremap # y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
noremap <c-l> <cmd>nohlsearch<bar>normal! <c-l><cr>
nnoremap Y y$

" key binding tweaks
set notimeout
set backspace=indent,eol,start whichwrap=b,s,h,l " remember, 'X' is 'dh'
set nrformats=hex,bin,unsigned " `unsigned` so <c-a> and <c-x> work on dates
nnoremap gK @='ddpkJ'<cr>| " join lines but reversed. `@=` so [count] works
set nojoinspaces nostartofline " only needed for Vim
set expandtab smarttab

" all things search
set ignorecase smartcase hlsearch incsearch
set wildmenu wildoptions=pum wildignorecase path+=** " :fin as fuzzy finder
noremap / /\v
noremap ? ?\v
cnoremap %s/ %s/\v
xnoremap :s/ :s/\v
cnoremap vim/ vim/\v

" essential plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
autocmd FileType c set commentstring=//\ %s
let g:c_syntax_for_h = 1 " use above 'commentstring' in header files too
let g:surround_{char2nr('*')} = "**\r**"
let g:surround_{char2nr('~')} = "~~\r~~"
let g:surround_{char2nr('[')} = "[[\r]]"
for c in '*~['
  execute 'nmap ds'.c.' <plug>Dsurround'.c.'<plug>Dsurround'.c
  execute 'nmap cs'.c.' <plug>Dsurround'.c.'<plug>Csurround'.c
  execute 'nmap cS'.c.' <plug>Dsurround'.c.'<plug>CSurround'.c
endfor

" emulate Neovim's 'Q' binding

function! s:record_macro()
  let s:last_reg = nr2char(getchar())
  execute 'normal! q'.s:last_reg
endfunction

function! s:exec_last_recorded()
  execute 'normal! '.v:count1.'@'.s:last_reg
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
nnoremap g= g+| " g=g=g= less awkward than g+g+g+

" languages

set formatoptions=
set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType * set formatoptions=
autocmd FileType * set tabstop=2 softtabstop=2 shiftwidth=2

Plug 'llathasa-veleth/vim-brainfuck'
Plug 'vim-scripts/bnf.vim'
autocmd BufNewFile,BufRead *.bnf set filetype=bnf
set suffixesadd=.md " [[wikilinks]]
" percent-encoding substitution expression below taken from :h substitute()
set includeexpr=substitute(v:fname,'%\\(\\x\\x\\)','\\=nr2char(\"0x\"..submatch(1))','g')
let g:markdown_fenced_languages = ['rust', 'c', 'python', 'haskell', 'sh', 'bnf', 'mermaid']
autocmd BufEnter *.md syntax match Todo '#todo\|#xxx\|#note'
autocmd BufEnter *.md syntax match markdownUrl '\[\[[[:fname:] ]*\]\]'
autocmd ColorScheme molokai call <sid>markdown_hi()
function! s:markdown_hi()
  highlight link markdownAutomaticLink htmlLink
  highlight link markdownUrl htmlLink
  highlight markdownCode ctermbg=none ctermfg=244 term=bold| " same as Comment
endfunction

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
