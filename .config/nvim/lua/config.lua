local config = function() end
local build = function() end

local map = vim.keymap.set
local hi = vim.cmd.highlight
local bg_none = 'ctermbg=None'
local fg_black = 'ctermfg=0'
local st_bold = 'cterm=bold'
local fg_white = 'ctermfg=7'
local bg_gray = 'ctermbg=238'
local fg_gray = 'ctermfg=239'

-- system

vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.updatetime = 250
vim.opt.autoread = true
vim.opt.fileformat = 'unix'

-- behavior

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.formatoptions = ''

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wildignorecase = true

vim.opt.backspace = 'indent,eol,start'
vim.g.mapleader = ' '

-- looks

vim.opt.wrap = true
vim.opt.number = false
vim.opt.linebreak = true
vim.opt.showbreak = '| '
vim.opt.breakindent = true
vim.opt.breakindentopt = ''
vim.opt.scrolloff = 12
vim.opt.sidescrolloff = 12
vim.opt.signcolumn = 'yes'
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.cmdheight = 1
vim.opt.laststatus = 0
vim.opt.shortmess = 's' .. 'W' .. 'F' .. 'l' .. 'I'

-- essentials

map('n', '<esc>', '<cmd>noh|echo<cr><esc>')
map('n', '<leader>w', '<cmd>set wrap!<cr>')
map('n', '<leader>s', '<cmd>w<cr>')
map('n', '<leader>q', '<cmd>q!<cr>')
map('v', '*', "y/\\V<c-r>=escape(@\", '\\/')<cr><cr>")
map('v', '#', "y/\\V<c-r>=escape(@\", '\\/')<cr><cr>")

P[#P + 1] = 'tpope/vim-commentary'
P[#P + 1] = 'tpope/vim-surround'
P[#P + 1] = 'tpope/vim-repeat'
vim.g.surround_42 = '**\r**'
vim.g.surround_126 = '~~\r~~'
vim.g.surround_91 = '[[\r]]'

build = function() vim.cmd('Copilot setup') end
vim.g.copilot_filetypes = { markdown = true, [''] = true }
P[#P + 1] = { 'github/copilot.vim', build = build }

-- colors

config = function()
  vim.cmd.colorscheme('molokai')

  hi({ 'Normal', bg_none })
  hi({ 'NonText', bg_none, fg_gray })
  hi({ 'Folded', bg_none })
  hi({ 'LineNr', bg_none })
  hi({ 'SignColumn', bg_none })
  hi({ 'Search', bg_none, fg_white, st_bold })
  hi({ 'Question', bg_none, fg_white, st_bold })            -- same as search
  hi({ 'ErrorMsg', bg_none, fg_white, st_bold })            -- same as search
  hi({ 'WarningMsg', bg_none, fg_white, st_bold })          -- same as search
  hi({ 'Pmenu', bg_none, fg_white })
  hi({ 'PmenuSel', bg_gray, fg_white })                     -- same as visual
  hi({ 'IncSearch', 'ctermfg=16', 'ctermbg=253', st_bold }) -- same as cursor
  hi({ 'MatchParen', bg_none, fg_white, st_bold })          -- same as search
  hi({ 'StatusLine', bg_none, fg_black })
  hi({ 'StatusLineNC', bg_none, fg_black })
  hi({ 'VertSplit', bg_none, fg_black })
  vim.cmd('autocmd BufEnter * syntax match Trailing /\\s\\+$/')
  hi({ 'Trailing', bg_gray, fg_white }) -- same as visual
end

vim.g.rehash256 = 1
P[#P + 1] = { 'tomasr/molokai', config = config, priority = 1 }

config = function()
  require('gitsigns').setup({
    signs = {
      add = { text = '│' }, -- box drawings light vertical
      change = { text = '│' }, -- box drawings light vertical
      delete = { text = '▁' }, -- lower one eighth block
      topdelete = { text = '▔' }, -- upper one eighth block
      changedelete = { text = '─' }, -- box drawings light horizontal
      untracked = { text = '┊' }, -- box drawings light quadruple dash vertical
    },
  })

  hi({ 'DiffAdd', bg_none, fg_gray })    -- same as NonText
  hi({ 'DiffChange', bg_none, fg_gray }) -- same as NonText
  hi({ 'DiffDelete', bg_none, fg_gray }) -- same as NonText
end

P[#P + 1] = { 'lewis6991/gitsigns.nvim', config = config }

-- navigation

config = function()
  local devicons = require('nvim-web-devicons')
  for _, icon in pairs(devicons.get_icons()) do
    devicons.set_icon({ [icon.name] = { name = icon.name, color = 'white' } })
  end
  devicons.set_default_icon('', 'white') -- `exa`'s default icon
end

P[#P + 1] = { 'kyazdani42/nvim-web-devicons', config = config }

config = function()
  require('telescope').setup({
    defaults = { layout_config = { width = 100000000000, height = 100000000000 }, file_ignore_patterns = { '.git/' } },
    pickers = {
      find_files = { initial_mode = 'insert', hidden = true },
      live_grep = { initial_mode = 'insert', additional_args = { '--hidden' } },
      lsp_references = { initial_mode = 'normal' },
      help_tags = { initial_mode = 'insert' },
      resume = { initial_mode = 'normal' },
    },
  })

  hi({ 'TelescopeMatching', bg_none, fg_white, st_bold }) -- same as search

  local builtin = require('telescope.builtin')
  map('n', '<leader>o', builtin.find_files)
  map('n', '<leader>f', builtin.live_grep)
  map('n', '<leader>h', builtin.help_tags)
  map('n', '<leader>n', builtin.resume)
end

P[#P + 1] = 'nvim-lua/plenary.nvim'
P[#P + 1] = { 'nvim-telescope/telescope.nvim', config = config }

-- run telescope.nvim on startup if the current buffer is a directory
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local bufferPath = vim.fn.expand('%:p')
    local builtin = require('telescope.builtin')
    if vim.fn.isdirectory(bufferPath) ~= 0 then
      vim.api.nvim_buf_delete(0, { force = true })
      builtin.find_files({ search_dirs = { bufferPath } })
    end
  end,
})

-- why vim why

for _, mode in ipairs({ 'n', 'v' }) do
  map(mode, '<space>', '<nop>')

  map(mode, '/', '/\\v')
  map(mode, '?', '?\\v')
end

for _, mode in ipairs({ 'n', 'i', 'v' }) do
  map(mode, '<up>', '<nop>')
  map(mode, '<down>', '<nop>')
  map(mode, '<left>', '<nop>')
  map(mode, '<right>', '<nop>')
end

local ftplugin_overrides = { 'formatoptions', 'softtabstop', 'tabstop', 'shiftwidth' }
for _, option in ipairs(ftplugin_overrides) do
  vim.cmd('autocmd FileType * setlocal ' .. option .. '=' .. vim.opt[option]._value)
end
