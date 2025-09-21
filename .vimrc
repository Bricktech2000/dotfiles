" bootstrap vim-plug. from vim-plug documentation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" ceremony
set nocompatible
syntax on
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
set title
set belloff=all
set mouse=a mousemodel=extend
let &t_SI = "\e[6 q" " see :h termcap-cursor-shape
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

" screen drawing
set nonumber signcolumn=yes
set noshowmode noruler showcmd laststatus=0
set winheight=1 winwidth=1 winminheight=0 winminwidth=0
set shortmess-=S " Neovim default
let g:netrw_banner = 0
let g:netrw_cursor = 0 " don't override 'cursorline' please
set display=lastline
set scrolloff=5 sidescrolloff=10
set wrap linebreak showbreak=\|\  breakindent breakindentopt=min:20
silent! set smoothscroll " unfortunate this is a buggy afterthought

" character input & display
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
autocmd Syntax * syntax match nonascii /[^\x00-\x7f]/ containedin=ALL
autocmd ColorScheme * highlight! link nonascii Underlined

" key binding tweaks
set notimeout
set ignorecase infercase
set complete-=i switchbuf=uselast " Neovim default
set nrformats-=octal nrformats+=unsigned " so <c-a> and <c-x> work on dates
set formatoptions= " no thanks
set matchpairs+=<:>
nnoremap g= g+| " g=g=g= is less awkward than g+g+g+
nnoremap gK @='ddkPJ'<cr>| " join lines but reversed. `@=` so [count] works
xnoremap gK <esc><cmd>keeppatterns '<,'>-global/$/normal! ddpkJ<cr>
nnoremap <s-del> a<del><esc>| " delete character after the cursor
noremap! <s-del> <cmd>let ww=&ww<bar>se ww+=[,]<cr><right><del><left><cmd>let &ww=ww<cr>
silent! set cpoptions-=z " for Vim
silent! set cpoptions-=_ " for Neovim
set nojoinspaces nostartofline " Neovim default
set autoindent expandtab smarttab tabstop=2 shiftwidth=2
autocmd WinNew * wincmd L " split vertically by default
Plug 'Bricktech2000/jumptree.vim'
silent! iunmap <c-s>| " Neovim `default-mapping`. clashes with vim-surround
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'

" all things search
set ignorecase smartcase hlsearch incsearch
set wildmenu wildoptions=pum wildignorecase path+=** " :fin as fuzzy finder
for k in 'edyu' " scroll from within command-line mode
  execute 'cnoremap <c-'.k.'> <c-r>=execute("normal! \<lt>c-'.k.'>:redraw\<lt>cr>")<cr>'
endfor

" Neovim-inspired bindings
xnoremap * y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
xnoremap # y/\V<c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr><cr>
xnoremap <silent> gd ym':keepjumps normal! [[/\V<c-v><c-r>=
      \ substitute(escape(@", '/\\'), '\n', '\\n', 'g')<c-v><cr><c-v><cr><cr>zt
xnoremap <silent> gD ym':keepjumps normal! go/\V<c-v><c-r>=
      \ substitute(escape(@", '/\\'), '\n', '\\n', 'g')<c-v><cr><c-v><cr><cr>zt
noremap <c-l> <cmd>nohlsearch<bar>normal! <c-l><cr>
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
function! s:record_macro()
  let g:reg_recorded = getcharstr()
  call feedkeys('q'.g:reg_recorded, 'ni') " using `execute 'normal!'` breaks q: and q/
endfunction
let g:reg_recorded = '' " same idea as Neovim's reg_recorded()
nnoremap <expr> q reg_recording() == '' ? '<cmd>call <sid>record_macro()<cr>' : 'q'
xnoremap <expr> q reg_recording() == '' ? '<cmd>call <sid>record_macro()<cr>' : 'q'
nnoremap <expr> Q '<cmd>normal! '.v:count1.'@'.g:reg_recorded.'<cr>'
xnoremap <expr> Q "<esc><cmd>'<,'>normal! ".v:count1.'@'.g:reg_recorded.'<cr>'
xnoremap <expr> @ "<esc><cmd>'<,'>normal! ".v:count1.'@'.getcharstr().'<cr>'
xnoremap <expr> . "<esc><cmd>'<,'>normal! ".v:count1.'.<cr>'
" unmap Neovim's backward-incompatible junk
silent! nunmap Y
silent! autocmd LspAttach * silent! nunmap <buffer> K
for map in ['grn', 'grr', 'gra', 'gri', 'grt', ']d', '[d', ']D', '[D', '<c-w>d']
  silent! execute 'nunmap' map| " how fucking dare you
endfor

" integrations
Plug 'airblade/vim-gitgutter'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_removed_above_and_below = '^'
let g:gitgutter_sign_modified_removed = 'L'

" filetypes

" don't overwrite my stuff please
for opt in ['fo', 'mps', 'ts', 'sts', 'sw', 'et', 'ic', 'scs'] " 'tw', 'isk', 'isf', 'kp'
  execute 'autocmd FileType * let &'.opt.' = &g:'.opt
endfor
autocmd User Dummy " dummy event
autocmd BufEnter,FileType * doautocmd User Dummy " re-run modeline. see :h <nomodeline>

autocmd FileType c set commentstring=//\ %s
let g:c_syntax_for_h = 1 " use above 'commentstring' in header files too

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
autocmd Syntax markdown syntax match Todo '#todo\|#xxx\|#note'
autocmd Syntax markdown syntax match markdownUrl '\[\[[[:fname:]|# ]*\]\]'
autocmd ColorScheme * highlight! link markdownCode String
autocmd ColorScheme * highlight! link markdownLinkText NONE
let g:surround_{char2nr('*')} = "**\r**"
let g:surround_{char2nr('~')} = "~~\r~~"
let g:surround_{char2nr('[')} = "[[\r]]"
for c in '*~['
  execute 'nmap ds'.c '<Plug>Dsurround'.c.'<Plug>Dsurround'.c
  execute 'nmap cs'.c '<Plug>Dsurround'.c.'<Plug>Csurround'.c
  execute 'nmap cS'.c '<Plug>Dsurround'.c.'<Plug>CSurround'.c
endfor

" color scheme

set notermguicolors
set background=dark
colorscheme wildcharm

call plug#end()
