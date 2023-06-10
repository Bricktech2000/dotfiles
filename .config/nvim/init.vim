set nocompatible
filetype plugin on
syntax on

set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

set relativenumber
set number

set hidden
set noerrorbells
" set nowrap
set noswapfile
set scrolloff=12
set signcolumn=yes
set updatetime=50
set autoread
set fileformat=unix
set noruler
set noshowmode
set cmdheight=1
set laststatus=0
set shortmess+=sWFlS

set ignorecase
set smartcase
set hlsearch
set incsearch
" clear search highlighting on escape
nnoremap <esc> <cmd>noh<cr><esc>

let mapleader=' '
imap <Tab> <C-n>
imap <S-Tab> <C-p>


call plug#begin()

Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>o <cmd>Telescope find_files find_command=rg,--smart-case,--sortr,modified,--multiline,--files<cr>
nnoremap <leader>f <cmd>Telescope live_grep find_command=rg,--smart-case,--sortr,modified,--multiline<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>
nnoremap <leader>s <cmd>silent! w<cr>
nnoremap <leader>q <cmd>q!<cr>
Plug 'nvim-lua/plenary.nvim'

Plug 'tomasr/molokai'
augroup molokai
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=None
  autocmd ColorScheme * highlight NonText ctermbg=None
  autocmd ColorScheme * highlight Folded ctermbg=None
  autocmd ColorScheme * highlight LineNr ctermbg=None
  autocmd ColorScheme * highlight SignColumn ctermbg=None
  autocmd ColorScheme * highlight DiffAdd ctermbg=None ctermfg=22
  autocmd ColorScheme * highlight DiffChange ctermbg=None ctermfg=17
  autocmd ColorScheme * highlight DiffDelete ctermbg=None ctermfg=124 cterm=bold
  autocmd ColorScheme * highlight Search ctermbg=None ctermfg=white cterm=bold
  autocmd ColorScheme * highlight IncSearch ctermbg=253 ctermfg=16 cterm=bold " same as cursor
  autocmd ColorScheme * highlight MatchParen ctermbg=None ctermfg=white cterm=bold " same as search
  autocmd ColorScheme * highlight TelescopeMatching ctermbg=None ctermfg=white cterm=bold " same as search
  autocmd ColorScheme * highlight clear Conceal
augroup END
let g:rehash256=1

Plug 'nvim-lualine/lualine.nvim'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'lewis6991/gitsigns.nvim'

Plug 'github/copilot.vim'

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tomlion/vim-solidity'
Plug 'prisma/vim-prisma'
Plug 'dag/vim-fish'
augroup fmt
  autocmd BufWritePre *.md silent! call CocAction('runCommand', 'prettier.forceFormatDocument')
  autocmd FileType * set formatoptions-=cro
augroup END
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" found with `:verbose set tabstop?`
let g:rust_recommended_style = 0

Plug 'vimwiki/vimwiki'
" prevent vimwiki from remapping <Tab> in normal mode
let g:vimwiki_key_mappings = { 'table_mappings': 0 }
" prevent vtmwiki from constantly breaking tables
let g:vimwiki_table_auto_fmt = 0
" conceal code block markers
" let g:vimwiki_conceal_pre = 1
" disable vimwiki conceal
" let g:vimwiki_conceallevel = 0
" needed for vimwiki update links on rename and backlinks
" unfortunately breaks syntax highlighting
" let g:vimwiki_ext2syntax = { '.md': 'default' }

call plug#end()


autocmd BufEnter * syn match Normal '&nbsp;' conceal cchar= 
autocmd BufEnter * syn match Normal '&emsp;' conceal cchar= 
autocmd BufEnter * syn match Normal '&mdash;' conceal cchar=—
autocmd BufEnter * syn match Normal '&times;' conceal cchar=×
autocmd BufEnter * syn match Normal '&bull;' conceal cchar=•
autocmd BufEnter * syn match Normal '&lambda;' conceal cchar=λ
autocmd BufEnter * syn match Normal '&minus;' conceal cchar=−
autocmd BufEnter * syn match Normal '&equiv;' conceal cchar=≡
autocmd BufEnter * syn match Normal '&uarr;' conceal cchar=↑
autocmd BufEnter * syn match Normal '&darr;' conceal cchar=↓
autocmd BufEnter * syn match Normal '&larr;' conceal cchar=←
autocmd BufEnter * syn match Normal '&rarr;' conceal cchar=→

colorscheme molokai

lua << END
-- require('lualine').setup({
--   options = { theme = 'iceberg_dark' }
-- })

require('gitsigns').setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  }
})
END
