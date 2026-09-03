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
filetype plugin indent on
set hidden
set encoding=utf-8
set history=10000 " max value
set synmaxcol=0 " no limit
set undolevels=1000000
set chistory=100 lhistory=100 " max values
set maxsearchcount=9999 " max value

" system
set noshelltemp
set noswapfile updatetime=100
set fileformat=unix nofixeol " see |'fileformats'| |file-formats| |eol-and-eof|
set sessionoptions+=unix,slash viewoptions+=unix,slash
set shell=sh " always use the standard shell

" terminal
set title
set belloff=all
set mouse=a mousemodel=extend
set ttimeout ttimeoutlen=10 " make <c-[> instant
let &t_SI = "\e[6 q" " see |termcap-cursor-shape|
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

" screen drawing
set nonumber signcolumn=yes foldcolumn=0 diffopt+=foldcolumn:0
autocmd CmdWinEnter,TerminalWinOpen * setlocal signcolumn=no
set noshowmode noruler showcmd laststatus=0 showtabline=0
set winheight=1 winwidth=1 winminheight=0 winminwidth=0
set shortmess-=S
let g:netrw_banner = 0
let g:netrw_cursor = 0 " don't override 'cursorline' please
set display=lastline
set scrolloff=5 sidescrolloff=10
set smoothscroll " unfortunate this is a buggy afterthought
set listchars=precedes:\|,extends:\|
set wrap nolinebreak showbreak=\|\  breakindent
function! s:nosbr() " 'sbr' breaks gw when window is narrower than 'tw'. fix it
  let w:sbr = &l:sbr | setlocal sbr=NONE
  autocmd ModeChanged *:n{,[^o]*} ++once let &l:sbr = w:sbr
endfunction
nnoremap <expr> gw 'gw'.<sid>nosbr()[-1]
vnoremap <expr> gw 'gw'.<sid>nosbr()[-1]
nnoremap <expr> gq 'gq'.<sid>nosbr()[-1]
vnoremap <expr> gq 'gq'.<sid>nosbr()[-1]
set completeopt-=menu
set diffopt+=inline:char

" character input & display
set list listchars+=tab:>-,trail:#
set iminsert=1 " see |mapmode-l|
lnoremap <c-space> <c-k> <space>
lnoremap <c-_> <c-k>NY| " for Vim
lnoremap <c--> <c-k>NY| " for Neovim
lnoremap <c-/> <c-k>-N
lnoremap <c-,> <c-k>-M
lnoremap <c-.> <c-k>,.
lnoremap <c-`> <c-k>'6
lnoremap <c-'> <c-k>'9
lnoremap <c-9> <c-k>"6
lnoremap <c-0> <c-k>"9
digraphs NY   8209 " U+2011 NON-BREAKING HYPHEN
digraphs Ke   8490 " U+212A KELVIN SIGN
digraphs \|-  8866 " U+22A2 RIGHT TACK
digraphs -\|  8867 " U+22A3 LEFT TACK
digraphs TO   8868 " U+22A4 DOWN TACK
digraphs BO   8869 " U+22A5 UP TACK
digraphs \|=  8872 " U+22A8 TRUE
digraphs :=   8788 " U+2254 COLON EQUALS
digraphs =:   8789 " U+2255 EQUALS COLON
digraphs \|\| 8739 " U+2223 DIVIDES
digraphs <.   8918 " U+22D6 LESS-THAN WITH DOT
digraphs .>   8919 " U+22D7 GREATER-THAN WITH DOT
digraphs //  10744 " U+29F8 BIG SOLIDUS
digraphs \\  10745 " U+29F9 BIG REVERSE SOLIDUS
digraphs [[  10214 " U+27E6 MATHEMATICAL LEFT WHITE SQUARE BRACKET
digraphs ]]  10215 " U+27E7 MATHEMATICAL RIGHT WHITE SQUARE BRACKET
digraphs {{  10627 " U+2983 LEFT WHITE CURLY BRACKET
digraphs }}  10628 " U+2984 RIGHT WHITE CURLY BRACKET
digraphs ((  10629 " U+2985 LEFT WHITE PARENTHESIS
digraphs ))  10630 " U+2986 RIGHT WHITE PARENTHESIS
" Unicode 'Letterlike Symbols' and 'Mathematical Alphanumeric Symbols'
" https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols
let s:backpatch = {
      \ 0x1d53a: 0x2102, 0x1d4bc: 0x210a, 0x1d4a3: 0x210b, 0x1d50b: 0x210c,
      \ 0x1d53f: 0x210d, 0x1d455: 0x210e, 0x1d4a4: 0x2110, 0x1d50c: 0x2111,
      \ 0x1d4a7: 0x2112, 0x1d545: 0x2115, 0x1d547: 0x2119, 0x1d548: 0x211a,
      \ 0x1d4ad: 0x211b, 0x1d515: 0x211c, 0x1d549: 0x211d, 0x1d551: 0x2124,
      \ 0x1d51d: 0x2128, 0x1d49d: 0x212c, 0x1d506: 0x212d, 0x1d4ba: 0x212f,
      \ 0x1d4a0: 0x2130, 0x1d4a1: 0x2131, 0x1d4a8: 0x2133, 0x1d4c4: 0x2134}
for [k, v] in items({"\<c-b>": 0x1d400, "\<c-i>": 0x1d434, "\<c-s>": 0x1d49c,
                   \ "\<c-l>": 0x1d4d0, "\<c-f>": 0x1d504, "\<c-d>": 0x1d538})
for [i, c] in items('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
call digraph_set(k.c, nr2char(get(s:backpatch, v+i, v+i))) | endfor | endfor
for [k, v] in items({"\<c-b>": 0x1d7ce, "\<c-d>": 0x1d7d8})
for [i, c] in items('0123456789')
call digraph_set(k.c, nr2char(get(s:backpatch, v+i, v+i))) | endfor | endfor
for [k, v] in items({"\<c-b>": 0x1d6a8, "\<c-i>": 0x1d6e2})
for [i, c] in items('ABGDEZYHIKLMNCOPR STUFXQWVabgdezyhiklmncopr stufxqw')
call digraph_set(c.k, nr2char(get(s:backpatch, v+i, v+i))) | endfor | endfor
" Unicode Latin subscripts and superscripts from various blocks
" https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts
for [i, c] in items([0x1d43,0x1d47,0x1d9c,0x1d48,0x1d49,0x1da0,0x1d4d,0x02b0
      \,0x2071,0x02b2,0x1d4f,0x02e1,0x1d50,0x207f,0x1d52,0x1d56,0x107a5,0x02b3
      \,0x02e2,0x1d57,0x1d58,0x1d5b,0x02b7,0x02e3,0x02b8,0x1dbb])
call digraph_set(nr2char(i + 97).'S', nr2char(c)) | endfor
for [i,c] in items([0x1d2c,0x1d2e,0xa7f2,0x1d30,0x1d31,0xa7f3,0x1d33,0x1d34
      \,0x1d35,0x1d36,0x1d37,0x1d38,0x1d39,0x1d3a,0x1d3c,0x1d3e,0xa7f4,0x1d3f
      \,0xa7f1,0x1d40,0x1d41,0x2c7d,0x1d42,0x0000,0x0000,0x0000])
call digraph_set(nr2char(i + 65).'S', nr2char(c)) | endfor
for [i,c] in items([0x2090,0x0000,0x0000,0x0000,0x2091,0x0000,0x0000,0x2095
      \,0x1d62,0x2c7c,0x2096,0x2097,0x2098,0x2099,0x2092,0x209a,0x0000,0x1d63
      \,0x209b,0x209c,0x1d64,0x1d65,0x0000,0x2093,0x0000,0x0000])
call digraph_set(nr2char(i + 97).'s', nr2char(c)) | endfor
" highlight non-ASCII characters and overlong encodings of ASCII characters.
" the latter is an abuse of the regex engine: it turns out that you can search
" for a given overlong encoding by putting the overlong encoding literally in
" the search string, using, for example, `/<c-r><c-r>="\xc1\x81"<cr><cr>` or
" `let @/ = "\xc1\x81"`. this only works on the NFA engine |two-engines|. it
" also turns out that if you search for the two-byte and three-byte overlong
" encodings of an ASCII character, all overlong encodings of that character
" are matched, so that's what we do, for performance. unfortunately, overlong
" NULs terminate the search string, so we can't match them.
let s:overlongs = flatten(map(range(0x01, 0x7f), {_,c -> [
      \ eval(printf('"\x%02x\x%02x"',     0xc0+c/0x40, 0x80+c%0x40)),
      \ eval(printf('"\xe0\x%02x\x%02x"', 0x80+c/0x40, 0x80+c%0x40)),
      \ ]}))
let s:overlongs = '\%#=2\%('.join(s:overlongs,'\|').'\)'
autocmd VimEnter,BufRead * doautocmd Syntax
autocmd BufNew * autocmd BufEnter * ++once doautocmd Syntax
autocmd Syntax * silent! syntax clear nonascii |
      \ syntax match nonascii /[^\x00-\x7f]/ containedin=ALL |
      \ execute 'syntax match nonascii /'.s:overlongs.'/ containedin=ALL'
autocmd ColorScheme * highlight! link nonascii Underlined

" unmap Neovim's backward-incompatible junk
silent! nunmap Y
silent! xunmap @
silent! xunmap Q
silent! iunmap <c-u>
silent! iunmap <c-w>
silent! autocmd LspAttach * silent! nunmap <buffer> K
for map in ['grn', 'grr', 'gra', 'gri', 'grt', ']d', '[d', ']D', '[D', '<c-w>d']
  silent! execute 'nunmap' map| " how fucking dare you
endfor

" key binding tweaks
set notimeout
set ignorecase infercase
set complete-=i switchbuf=uselast " Neovim default
set nrformats-=octal nrformats+=unsigned " so <c-a> and <c-x> work on dates
set formatoptions=q " no smarts please
set matchpairs+=<:>
nnoremap <c-w><c--> <c-w><c-_>| " for Neovim
nnoremap g= g+| " g=g=g= is less awkward than g+g+g+
autocmd FileType help silent! nunmap <buffer> g==| " shadow Neovim's g== mapping
nnoremap gK @='ddkPJ'<cr>| " join lines but reversed. `@=` so [count] works
xnoremap gK <esc><cmd>keeppatterns '<,'>-global/$/normal! ddpkJ<cr>
nnoremap <s-del> a<del><esc>| " delete character after the cursor
noremap! <s-del> <cmd>let ww=&ww<bar>set ww=[,]
      \ <cr><right><del><left><cmd>let &ww=ww<cr>
let g:reg_recorded = '' " same idea as Neovim's reg_recorded()
autocmd KeyInputPre * if v:char ==# 'q' && reg_recording() != '' |
      \ let g:reg_recorded = reg_recording() | endif
nnoremap <expr> Q '@'.g:reg_recorded
xnoremap <expr> Q '@'.g:reg_recorded
" you certainly know the pain of hitting <c-w> to delete the |word| before the
" cursor but you're not in Vim so it closes your tab. well I'm extending the
" favor! now you can know the pain of hitting <c-q> and closing your entire
" application when you only meant to delete the |WORD| before the cursor
noremap! <c-q> <cmd>let isk=&isk<bar>set isk=^32,^9
      \ <cr><c-w><cmd>let &isk=isk<cr>| " delete the |WORD| before the cursor
silent! set cpoptions-=z " for Vim
silent! set cpoptions-=_ " for Neovim
set nojoinspaces nostartofline " Neovim default
set expandtab nosmarttab softtabstop=0 " no smarts please. (to indent use <c-t>)
set autoindent shiftwidth=2
inoremap <s-tab> <cmd>let sts=&sts<bar>let &sts=&ts<cr><bs><cmd>let &sts=sts<cr>
silent! iunmap <c-s>| " Neovim default mapping; clashes with vim-surround
Plug 'Bricktech2000/jumptree.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
let g:unimpaired_colorcolumn = '+0' " color the last column, not the one past it
Plug 'tpope/vim-surround'
for c in ['*', '~', '_', '$', '<bar>', ',', '<tab>', '/'] " md, csv, tsv, re
  execute 'xnoremap i'.c.' <cmd>normal! lT'.c.'ot'.c.'<cr>'
  execute 'xnoremap a'.c.' <cmd>normal! lF'.c.'of'.c.'<cr>'
  execute 'onoremap i'.c.' <cmd>normal vi'.c.'<cr>'
  execute 'onoremap a'.c.' <cmd>normal va'.c.'<cr>'
endfor
set foldopen-=undo " fix bug in vim-repeat where <c-o>u inserts 'zv' into buffer
Plug 'tpope/vim-repeat'
cnoremap <c-r><c-d> <c-r>=strftime('%F')<cr>
cnoremap <c-r><c-t> <c-r>=strftime('%T')<cr>
inoremap <silent> <c-r><c-d> <c-r>=strftime('%F')<cr>
inoremap <silent> <c-r><c-t> <c-r>=strftime('%T')<cr>
" remapping : to a non-shifted key like , increases the entropy of my key
" presses by 0.17 bits (from 2.89 bits to 3.06 bits). I chose , instead of ;
" because I also use ; a lot. and also ;/: fits well with n/N f/F t/T //?
noremap <expr> q reg_recording() != '' ? 'q' :
      \ 'q'.substitute(getcharstr(-1, {'cursor': 'keep'}), ',', ':', '')
noremap , :|noremap : ,|noremap <c-w>, <c-w>:|tnoremap <c-w>, <c-w>:
sunmap q|sunmap ,|sunmap :|sunmap <c-w>,
" make ctrl+scroll move through time instead of space. https://xkcd.com/1806/
nnoremap <c-scrollwheelup>    u
nnoremap <c-scrollwheeldown>  <c-r>
nnoremap <c-scrollwheelleft>  g-
nnoremap <c-scrollwheelright> g+
" like |gF| but the number is a byte offset, 0-based, eg. src/normal.c[1337]
cnoremap <expr> <plug>NGotoFile v:count1.'find '.fnameescape(substitute(
      \ expand('<cfile>'), '\\ ', ' ', 'g')).'<bar>keepjumps goto '.(1 +
      \ matchstr(getline('.'), '\d\+', stridx(getline('.'), expand('<cfile>'),
      \ col('.') - len(expand('<cfile>'))) + len(expand('<cfile>'))))
cnoremap <expr> <plug>VGotoFile v:count1.'find '.fnameescape(substitute(
      \ getline("'>")[col("'<")-1:col("'>")-1], '\\ ', ' ', 'g')).'<bar>
      \ keepjumps goto '.(1 + matchstr(getline("'>"), '\d\+', col("'>")))
nnoremap <silent> g<c-f>      :<c-u><plug>NGotoFile<cr>
vnoremap <silent> g<c-f>      <esc>:<plug>VGotoFile<cr>
nnoremap <silent> <c-w><c-f>  :<c-u>split<bar><plug>NGotoFile<cr>
vnoremap <silent> <c-w><c-f>  <esc>:split<bar><plug>VGotoFile<cr>
nnoremap <silent> <c-w>g<c-f> :<c-u>tab split<bar><plug>NGotoFile<cr>
vnoremap <silent> <c-w>g<c-f> <esc>:tab split<bar><plug>VGotoFile<cr>
nmap <silent> <c-w><c-g><c-f> <c-w>g<c-f>
vmap <silent> <c-w><c-g><c-f> <c-w>g<c-f>

" all things search
set ignorecase smartcase hlsearch incsearch
set wildmenu wildoptions=pum wildignorecase path+=** " :fin as fuzzy finder
set grepprg=ltrep\ -Hnk    " verbatim from LTRE/ltrep/grepprg.vim
set grepformat=%f:%l:%c:%m " this too
noremap <c-l> <cmd>nohlsearch<bar>normal! <c-l><cr>
Plug 'Bricktech2000/c_CTRL-O.vim'
cnoremap <plug>Pat <c-r>=substitute(escape(@", '/\\'), '\n', '\\n', 'g')<cr>
nnoremap  <c-8> :lvimgrep/\V\<<c-r><c-w>\>/g**
nnoremap g<c-8> :lvimgrep/\V\(<c-r><c-w>\)/g**| " need parens |c_CTRL-R_CTRL-W|
xnoremap  <c-8> y:lvimgrep/\V\<<plug>Pat\>/g**
xnoremap g<c-8> y:lvimgrep/\V\(<plug>Pat\)/g**
xnoremap <silent>  * y/\V\<<plug>Pat\><cr>
xnoremap <silent> g* y/\V\(<plug>Pat\)<cr>
xnoremap <silent>  # y?\V\<<plug>Pat\><cr>
xnoremap <silent> g# y?\V\(<plug>Pat\)<cr>
xnoremap <silent> gd ym':keepjumps normal! [[/\V\(<plug>Pat\)<c-v><cr><cr>zz
xnoremap <silent> gD ym':keepjumps normal! go/\V\(<plug>Pat\)<c-v><cr><cr>zz

" integrations

Plug 'airblade/vim-gitgutter'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_removed_above_and_below = '^'
let g:gitgutter_sign_modified_removed = 'L'

let g:keycap = ''
nnoremap <c-k> <cmd>let g:keycap = empty(g:keycap) ? repeat(' ', 999) : ''<cr>
autocmd KeyInputPre * if !empty(g:keycap) |
      \ let s:keycap_map = {"\<cursorhold>": "", "\<ignore>": "",
      \     "\x80\xfdT": "<C-F>", " ": " "} |
      \ let g:keycap .= get(s:keycap_map, v:char, keytrans(v:char)) | endif
" autocmd KeyInputPre [^cr]* if !empty(g:keycap) |
      \ echo g:keycap[-v:echospace:] | endif
autocmd KeyInputPre [^r]* if !empty(g:keycap) | call timer_start(0, {->execute('
      \ echo g:keycap[-v:echospace:]', '')}) | endif

" filetypes

" don't overwrite my stuff please
autocmd FileType * setlocal fo< mps< ts< sts< sw< et< " tw< isk< isf< kp<
autocmd User Dummy " dummy event to re-run modeline. see |<nomodeline>|
autocmd FileType * doautocmd User Dummy

autocmd FileType c set commentstring=//\ %s
let g:c_syntax_for_h = 1 " use above 'commentstring' in header files too

Plug 'llathasa-veleth/vim-brainfuck'

Plug 'vim-scripts/bnf.vim'
autocmd Syntax bnf syntax match bnfComment ';.*$' contained " default is '#.*$'
autocmd BufNewFile,BufRead *.bnf set filetype=bnf

let g:markdown_fenced_languages = ['mermaid', 'rust', 'c', 'python', 'haskell',
      \ 'sh', 'vim', 'diff', 'bnf']
" percent-encoding substitution below is based on the one from |substitute()|
autocmd FileType markdown setlocal includeexpr
      \=substitute(v:fname,'%\\(\\x\\x\\)\\\|#.*',{m->nr2char('0x'.m[1])},'g')
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
  execute 'nnoremap ds'.c '<Plug>Dsurround'.c.'<Plug>Dsurround'.c
  execute 'nnoremap cs'.c '<Plug>Dsurround'.c.'<Plug>Csurround'.c
  execute 'nnoremap cS'.c '<Plug>Dsurround'.c.'<Plug>CSurround'.c
endfor

" color scheme

set notermguicolors
set background=dark
colorscheme wildcharm

call plug#end()

" vim:tw=80:
