local config = function() end
local build = function() end

local opt = vim.opt
local map = vim.keymap.set
local hi = vim.cmd.highlight
local bg_none = 'ctermbg=None'
local fg_black = 'ctermfg=0'
local st_bold = 'cterm=bold'
local fg_white = 'ctermfg=7'
local bg_grey = 'ctermbg=238'

-- system

opt.errorbells = false
opt.swapfile = false
opt.updatetime = 250
opt.autoread = true
opt.fileformat = 'unix'

-- behavior

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.formatoptions = ''

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.backspace = 'indent,eol,start'
vim.g.mapleader = ' '

-- looks

opt.wrap = true
opt.number = false
opt.linebreak = true
opt.showbreak = '| '
opt.breakindent = true
opt.breakindentopt = ''
opt.scrolloff = 12
opt.sidescrolloff = 12
opt.signcolumn = 'yes'
opt.showmode = false
opt.ruler = false
opt.cmdheight = 1
opt.laststatus = 0
opt.shortmess = 's' .. 'W' .. 'F' .. 'l' .. 'I'

-- essentials

map('n', '<esc>', '<cmd>noh|echo<cr><esc>')
map('n', '<leader>w', '<cmd>set wrap!<cr>')
map('n', '<leader>s', '<cmd>silent! w<cr>')
map('n', '<leader>q', '<cmd>q!<cr>')

P[#P + 1] = 'tpope/vim-commentary'
P[#P + 1] = 'tpope/vim-surround'
P[#P + 1] = 'tpope/vim-repeat'

build = function() vim.cmd('Copilot setup') end
vim.g.copilot_filetypes = { markdown = true }
P[#P + 1] = { 'github/copilot.vim', build = build }

-- colors

config = function()
  vim.cmd.colorscheme('molokai')

  hi({ 'Normal', bg_none })
  hi({ 'NonText', bg_none })
  hi({ 'Folded', bg_none })
  hi({ 'LineNr', bg_none })
  hi({ 'SignColumn', bg_none })
  hi({ 'Search', bg_none, fg_white, st_bold })
  hi({ 'Question', bg_none, fg_white, st_bold })            -- same as search
  hi({ 'ErrorMsg', bg_none, fg_white, st_bold })            -- same as search
  hi({ 'Pmenu', bg_none, fg_white })
  hi({ 'PmenuSel', bg_grey, fg_white })                     -- same as visual
  hi({ 'IncSearch', 'ctermfg=16', 'ctermbg=253', st_bold }) -- same as cursor
  hi({ 'MatchParen', bg_none, fg_white, st_bold })          -- same as search
  hi({ 'StatusLine', bg_none, fg_black })
  hi({ 'StatusLineNC', bg_none, fg_black })
  hi({ 'VertSplit', bg_none, fg_black })
  vim.cmd('autocmd BufEnter * syntax match Trailing /\\s\\+$/')
  hi({ 'Trailing', bg_grey, fg_white }) -- same as visual
end

vim.g.rehash256 = 1
P[#P + 1] = { 'tomasr/molokai', config = config, priority = 1 }

config = function()
  require('gitsigns').setup()

  hi({ 'DiffAdd', bg_none, 'ctermfg=34' })
  hi({ 'DiffChange', bg_none, 'ctermfg=20' })
  hi({ 'DiffDelete', bg_none, 'ctermfg=160', st_bold })

  hi({ 'DiffAddBright', bg_none, 'ctermfg=118' })
  hi({ 'DiffChangeBright', bg_none, 'ctermfg=81' })
  hi({ 'DiffDeleteBright', bg_none, 'ctermfg=213', st_bold })
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
    defaults = { layout_config = { width = 100000000000, height = 100000000000 } },
    pickers = {
      find_files = { initial_mode = 'insert' },
      live_grep = { initial_mode = 'insert' },
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
  vim.cmd('autocmd FileType * setlocal ' .. option .. '=' .. opt[option]._value)
end
