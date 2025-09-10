" bootstrap vim-plug. from vim-plug documentation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

set nocompatible
filetype plugin on
set hidden
set history=10000 " max value
set synmaxcol=0 " no limit
set undolevels=1000000

" system
set autoread
set noswapfile updatetime=100
set fileformat=unix encoding=utf-8

" terminal
set belloff=all mouse=a mousemodel=extend
let &t_SI = "\e[6 q" " see :h termcap-cursor-shape
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

" reduce clutter
set nonumber signcolumn=yes
set noshowmode noruler showcmd laststatus=0
set winheight=1 winwidth=1 winminheight=0 winminwidth=0
set shortmess-=S " Neovim default
let g:netrw_banner = 0
let g:netrw_cursor = 0 " don't override 'cursorline' please

" text layout
set display=lastline
set scrolloff=12 sidescrolloff=12
set wrap linebreak showbreak=\|\  breakindent breakindentopt=min:20
silent! set smoothscroll " unfortunate this is a buggy afterthought

" typographic characters
set list listchars=tab:>-,trail:#
set iminsert=1 " see :h mapmode-l
lnoremap <c-space> <c-k>NS
lnoremap <c-/> <c-k>-N
lnoremap <c-_> <c-k>-M| " for Vim
lnoremap <c--> <c-k>-M| " for Neovim
lnoremap <c-.> <c-k>,.
lnoremap <c-`> <c-k>'6
lnoremap <c-'> <c-k>'9
lnoremap <c-9> <c-k>"6
lnoremap <c-0> <c-k>"9
autocmd BufEnter * syntax match nonascii /[^\x00-\x7f]/ containedin=ALL
autocmd BufEnter * highlight! nonascii cterm=underline

" some of Neovim's `default-mappings` but less broken
xnoremap * y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
xnoremap # y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
xnoremap gd ym':keepjumps normal! [[/\V<c-v><c-r>=
      \ substitute(escape(@", '/\\'), '\n', '\\n', 'g')<c-v><cr><c-v><cr><cr>zt
xnoremap gD ym':keepjumps normal! go/\V<c-v><c-r>=
      \ substitute(escape(@", '/\\'), '\n', '\\n', 'g')<c-v><cr><c-v><cr><cr>zt
noremap <c-l> <cmd>nohlsearch<bar>normal! <c-l><cr>
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
nnoremap Y y$
silent! iunmap <c-s>| " clashes with vim-surround
for map in ['grn', 'grr', 'gra', 'gri', 'grt', ']d', '[d', ']D', '[D', '<c-w>d']
  silent! execute 'nunmap' map| " how fucking dare you, Neovim?
endfor

" key binding tweaks
set notimeout
set ignorecase infercase
set complete-=i switchbuf=uselast " Neovim default
set backspace=indent,eol,start " Neovim default
set nrformats-=octal nrformats+=unsigned " so <c-a> and <c-x> work on dates
set formatoptions= " no thanks
set matchpairs+=<:>
nnoremap g= g+| " g=g=g= is less awkward than g+g+g+
nnoremap gK @='ddkPJ'<cr>| " join lines but reversed. `@=` so [count] works
xnoremap gK :-global/$/normal! ddpkJ<cr>
nnoremap <s-del> a<del><esc>| " delete character after the cursor
noremap! <s-del> <cmd>let ww=&ww<bar>se ww+=[,]<cr><right><del><left><cmd>let &ww=ww<cr>
silent! set cpoptions-=z " for Vim
silent! set cpoptions-=_ " for Neovim
set nojoinspaces nostartofline " Neovim default
set autoindent expandtab smarttab tabstop=2 shiftwidth=2
autocmd WinNew * wincmd L " split vertically by default

" all things search
set ignorecase smartcase hlsearch incsearch
set wildmenu wildoptions=pum wildignorecase path+=** " :fin as fuzzy finder
for k in 'edyu' " scroll from within command-line mode
  execute 'cnoremap <c-'.k.'> <c-r>=execute("normal! \<lt>c-'.k.'>:redraw\<lt>cr>")<cr>'
endfor

" emulate Neovim's 'Q' binding

function! s:record_macro()
  let s:last_reg = nr2char(getchar())
  " `execute 'normal! q'.s:last_reg` breaks q: and q/
  call feedkeys('q'.s:last_reg, 'n')
endfunction

function! s:exec_last_recorded()
  execute 'normal!' v:count1.'@'.s:last_reg
endfunction

let s:last_reg = ''
noremap <expr> q reg_recording() == '' ? '<cmd>call <sid>record_macro()<cr>' : 'q'
noremap Q <cmd>call <sid>exec_last_recorded()<cr>

" essential plugins

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'
autocmd FileType c set commentstring=//\ %s
let g:c_syntax_for_h = 1 " use above 'commentstring' in header files too
let g:surround_{char2nr('*')} = "**\r**"
let g:surround_{char2nr('~')} = "~~\r~~"
let g:surround_{char2nr('[')} = "[[\r]]"
for c in '*~['
  execute 'nmap ds'.c '<Plug>Dsurround'.c.'<Plug>Dsurround'.c
  execute 'nmap cs'.c '<Plug>Dsurround'.c.'<Plug>Csurround'.c
  execute 'nmap cS'.c '<Plug>Dsurround'.c.'<Plug>CSurround'.c
endfor

" filetypes

" don't overwrite my stuff please
for opt in ['fo', 'mps', 'ts', 'sts', 'sw', 'et', 'ic', 'scs'] " 'tw', 'isk', 'isf', 'kp'
  execute 'autocmd FileType * let &'.opt.' = &g:'.opt
endfor
autocmd User Dummy " dummy event
autocmd BufEnter,FileType * doautocmd User Dummy " re-run modeline. see :h <nomodeline>

Plug 'llathasa-veleth/vim-brainfuck'

Plug 'vim-scripts/bnf.vim'
autocmd BufNewFile,BufRead *.bnf set filetype=bnf

let g:markdown_fenced_languages =
      \ ['rust', 'c', 'python', 'haskell', 'sh', 'vim', 'diff', 'bnf', 'mermaid']
" percent-encoding substitution expression below based on the one from :h substitute()
autocmd FileType markdown setlocal
      \ includeexpr=substitute(v:fname,'%\\(\\x\\x\\)\\\|#.*',{m->nr2char('0x'.m[1])},'g')
autocmd FileType markdown setlocal suffixesadd=.md " [[wikilinks]]
autocmd FileType markdown setlocal comments= " for gd and gD to work in lists
autocmd BufEnter *.md syntax match Todo '#todo\|#xxx\|#note'
autocmd BufEnter *.md syntax match markdownUrl '\[\[[[:fname:]|# ]*\]\]'
autocmd ColorScheme molokai call <sid>markdown_hi()
function! s:markdown_hi()
  highlight! link markdownAutomaticLink htmlLink
  highlight! link markdownUrl htmlLink
  highlight! link markdownCode Comment
endfunction

" colorscheme

Plug 'tomasr/molokai'
let g:rehash256 = 1
set notermguicolors

autocmd ColorScheme molokai call <sid>molokai_hi()
function! s:molokai_hi()
  highlight! Normal       ctermbg=none
  highlight! Folded       ctermbg=none
  highlight! LineNr       ctermbg=none
  highlight! Question     ctermbg=none
  highlight! ErrorMsg     ctermbg=none
  highlight! WarningMsg   ctermbg=none
  highlight! StatusLine   ctermbg=none ctermfg=0
  highlight! StatusLineNC ctermbg=none ctermfg=0
  highlight! VertSplit    ctermbg=none ctermfg=0
  highlight! Visual ctermfg=none " Neovim default
  highlight! link SignColumn Comment
  highlight! link NonText    Comment
  highlight! link Search     Todo
  highlight! link IncSearch  Cursor
  highlight! link Pmenu      Normal
  highlight! link PmenuSel   Cursor
  highlight! link Wildmenu   Cursor
  highlight! link MatchParen Todo
endfunction

" miscellaneous

Plug 'Bricktech2000/jumptree.vim'

Plug 'airblade/vim-gitgutter'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_removed_above_and_below = '^'
let g:gitgutter_sign_modified_removed = '|'
autocmd ColorScheme molokai call <sid>gitgutter_hi()
function! s:gitgutter_hi()
  highlight! link GitGutterAdd    SignColumn
  highlight! link GitGutterChange SignColumn
  highlight! link GitGutterDelete SignColumn
endfunction

call plug#end()

colorscheme molokai
