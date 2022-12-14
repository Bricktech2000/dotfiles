set nocompatible
filetype plugin on
syntax on

set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

set relativenumber
set nu

set ignorecase
set smartcase

set nohlsearch
set incsearch

set hidden
set noerrorbells
" set nowrap
set noswapfile
set scrolloff=12
set noshowmode
set signcolumn=yes
set updatetime=50

let mapleader=' '
imap <Tab> <C-n>
imap <S-Tab> <C-p>


call plug#begin()

Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>o <cmd>Telescope find_files<cr>
nnoremap <leader>f <cmd>Telescope live_grep<cr>
nnoremap <leader>s <cmd>w<cr>
nnoremap <leader>q <cmd>q!<cr>
Plug 'nvim-lua/plenary.nvim'

Plug 'tomasr/molokai'
autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight NonText ctermbg=None
autocmd ColorScheme * highlight Folded ctermbg=None
autocmd ColorScheme * highlight LineNr ctermbg=None
autocmd ColorScheme * highlight SignColumn ctermbg=None
let g:rehash256=1

Plug 'nvim-lualine/lualine.nvim'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'github/copilot.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'rust-lang/rust.vim'
let g:pymode_options_max_line_length = 1000
let g:python_recommended_style = 0
let g:pymode_indent = 0
augroup fmt
  autocmd!
  autocmd BufWritePre * CocCommand prettier.forceFormatDocument
  autocmd BufWritePre *.py PymodeLintAuto
  autocmd BufWritePre *.rs RustFmt
augroup END


Plug 'Bricktech2000/vimwiki' " (without overriding Tex parsing)
nnoremap <leader>wb <cmd>VimwikiBacklinks<cr>
" prevent vtmwiki from remapping <Tab> in normal mode
let g:vimwiki_key_mappings = { 'table_mappings': 0 }
" prevent vtmwiki from constantly breaking tables
let g:vimwiki_table_auto_fmt = 0
" needed for vimwiki update links on rename and backlinks
" unfortunately breaks syntax highlighting
" let g:vimwiki_ext2syntax = { '.md': 'default' }

Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
let g:tex_flavor='latex'
let g:tex_conceal='abdgms'
set conceallevel=2

Plug 'drmingdrmer/vim-syntax-markdown'

Plug 'dag/vim-fish'

Plug 'tomlion/vim-solidity'

Plug 'mxw/vim-jsx'

call plug#end()


colorscheme molokai

lua << END
require('lualine').setup({
  options = { theme = 'iceberg_dark' }
})
END

" definitions without {}
autocmd BufEnter * syn match texMathSymbol '\\mathbb A' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb B' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb C' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\mathbb D' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb E' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb F' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb G' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb H' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\mathbb I' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb J' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb K' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb L' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb M' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb N' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\mathbb O' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb P' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\mathbb Q' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\mathbb R' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\mathbb S' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb T' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb U' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb V' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb W' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb X' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb Y' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\mathbb Z' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) A' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) B' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) C' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) D' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) E' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) F' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) G' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) H' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) I' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) J' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) K' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) L' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) M' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) N' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) O' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) P' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) Q' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) R' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) S' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) T' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) U' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) V' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) W' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) X' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) Y' contained conceal cchar=????
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) Z' contained conceal cchar=????

" taken from the internet
autocmd BufEnter * syn match texMathSymbol /\\bra{\%([^}]*}\)\@=/ conceal cchar=???
autocmd BufEnter * syn match texMathSymbol /\%(\\bra{[^}]*\)\@<=}/ conceal cchar=|
autocmd BufEnter * syn match texMathSymbol /\\ket{\%([^}]*}\)\@=/ conceal cchar=|
autocmd BufEnter * syn match texMathSymbol /\%(\\ket{[^}]*\)\@<=}/ conceal cchar=???
autocmd BufEnter * syn match texMathSymbol /\\braket{\%([^}]*}\)\@=/ conceal cchar=???
autocmd BufEnter * syn match texMathSymbol /\%(\\braket{[^}]*\)\@<=}/ conceal cchar=???
autocmd BufEnter * syn match texMathSymbol /\\braket{\\braket{\%([^}]*}}\)\@=/ conceal cchar=???
autocmd BufEnter * syn match texMathSymbol /\%(\\braket{\\braket{[^}]*\)\@<=}}/ conceal cchar=???

" custom definitions
autocmd BufEnter * syn match texMathSymbol /\\\%(dim\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(det\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(lim\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(sin\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(cos\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(tan\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol '\\not *' contained conceal cchar=/
autocmd BufEnter * syn match texMathSymbol ' *: *' contained conceal cchar=:
autocmd BufEnter * syn match texMathSymbol ' *\\cdot *' contained conceal cchar=??
autocmd BufEnter * syn match texMathSymbol '\\varnothing' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\operatorname' contained conceal
autocmd BufEnter * syn match texMathSymbol '\\begin' contained conceal
autocmd BufEnter * syn match texMathSymbol '\\end' contained conceal
autocmd BufEnter * syn match texMathSymbol '\\begin{bmatrix}' contained conceal cchar=[
autocmd BufEnter * syn match texMathSymbol '\\begin{vmatrix}' contained conceal cchar=|
autocmd BufEnter * syn match texMathSymbol '\\end{bmatrix}' contained conceal cchar=]
autocmd BufEnter * syn match texMathSymbol '\\end{vmatrix}' contained conceal cchar=|
autocmd BufEnter * syn match texMathSymbol '\^\\intercal' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\^\\times' contained conceal cchar=??
autocmd BufEnter * syn match texMathSymbol '-' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\dot *' contained conceal cchar=??
autocmd BufEnter * syn match texMathSymbol '\\acute *' contained conceal cchar=??
autocmd BufEnter * syn match texMathSymbol '\\check *' contained conceal cchar=??
autocmd BufEnter * syn match texMathSymbol '\\dots' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol ' *\\cdots *' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\text-' contained conceal cchar=-
autocmd BufEnter * syn match texMathSymbol '\\lbrace' contained conceal cchar={
autocmd BufEnter * syn match texMathSymbol '\\rbrace' contained conceal cchar=}
autocmd BufEnter * syn match texMathSymbol '\\mid' contained conceal cchar=|
autocmd BufEnter * syn match texMathSymbol ' *\\shortmid *' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\lceil *' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol ' *\\rceil' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\lfloor *' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol ' *\\rfloor' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\delta *' contained conceal cchar=??
autocmd BufEnter * syn match texMathSymbol '\\sigma' contained conceal cchar=??
autocmd BufEnter * syn match texMathSymbol ' *\\smash *' contained conceal
autocmd BufEnter * syn match texMathSymbol '\\%' contained conceal cchar=%
autocmd BufEnter * syn match texMathSymbol '\\\*' contained conceal cchar=*
autocmd BufEnter * syn match texMathSymbol '_p' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '_P' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '_k' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '_K' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '_b' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '_B' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '_n' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '_N' contained conceal cchar=???
autocmd BufEnter * syn match texMathSymbol '\\omega' contained conceal cchar=??

" non-math definitions
autocmd BufEnter * syn match Normal '&mdash;' conceal cchar=???

hi clear Conceal
