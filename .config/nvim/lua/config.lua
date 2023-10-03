local config = function() end
local build = function() end

local opt = vim.opt
local map = vim.keymap.set
local hi = vim.cmd.highlight
local bg_none = 'ctermbg=None'
local fg_black = 'ctermfg=0'
local st_bold = 'cterm=bold'
local fg_white = 'ctermfg=7'

-- core

opt.errorbells = false
opt.swapfile = false
opt.updatetime = 50
opt.autoread = true
opt.fileformat = 'unix'

-- general

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.backspace = 'indent,eol,start'
vim.g.mapleader = ' '

-- looks

opt.wrap = true
opt.linebreak = true
opt.number = false
opt.scrolloff = 12
opt.signcolumn = 'yes'
opt.showmode = false
opt.ruler = false
opt.cmdheight = 1
opt.laststatus = 0
opt.shortmess = 's' .. 'W' .. 'F' .. 'l' .. 'I'

map('n', '<esc>', '<cmd>noh|echo<cr><esc>')

P[#P + 1] = 'kyazdani42/nvim-web-devicons'

config = function()
  vim.cmd.colorscheme('molokai')

  hi({ 'Normal', bg_none })
  hi({ 'NonText', bg_none })
  hi({ 'Folded', bg_none })
  hi({ 'LineNr', bg_none })
  hi({ 'SignColumn', bg_none })
  hi({ 'Search', bg_none, fg_white, st_bold })
  hi({ 'IncSearch', 'ctermfg=16', 'ctermbg=253', st_bold }) -- same as cursor
  hi({ 'MatchParen', bg_none, fg_white, st_bold }) -- same as search
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

config = function()
  hi({ 'StatusLine', bg_none, fg_black })
  hi({ 'StatusLineNC', bg_none, fg_black })
  hi({ 'VertSplit', bg_none, fg_black })
end

vim.g.minimap_auto_start = 1
vim.g.minimap_width = 16
vim.g.minimap_window_width_override_for_scaling = 200
-- somewhat of a performance hit when opening files
-- vim.g.minimap_git_colors = 1

vim.g.minimap_base_highlight = 'Comment'
vim.g.minimap_cursor_color = 'Normal'
vim.g.minimap_range_color = 'Normal'
vim.g.minimap_diffadd_color = 'DiffAdd'
vim.g.minimap_diff_color = 'DiffChange'
vim.g.minimap_diffremove_color = 'DiffDelete'
vim.g.minimap_cursor_diffadd_color = 'DiffAddBright'
vim.g.minimap_cursor_diff_color = 'DiffChangeBright'
vim.g.minimap_cursor_diffremove_color = 'DiffDeleteBright'
vim.g.minimap_range_diffadd_color = 'DiffAddBright'
vim.g.minimap_range_diff_color = 'DiffChangeBright'
vim.g.minimap_range_diffremove_color = 'DiffDeleteBright'

map('n', '<leader>m', '<cmd>MinimapToggle<cr>')

-- requires `code-minimap`. will throw a soft error if not installed
P[#P + 1] = { 'wfxr/minimap.vim', config = config }

-- navigation

config = function()
  local ripgrep = { 'rg', '--smart-case', '--sortr', 'modified', '--multiline' }
  local pickers = {
    find_files = { find_command = { unpack(ripgrep), '--files' } },
    live_grep = { find_command = { unpack(ripgrep) } },
    lsp_references = {},
    help_tags = {},
    resume = {},
  }
  for _, picker in ipairs(pickers) do
    picker.initial_mode = 'insert'
  end
  require('telescope').setup({ pickers = pickers })

  hi({ 'TelescopeMatching', bg_none, fg_white, st_bold }) -- same as search

  local builtin = require('telescope.builtin')
  map('n', '<leader>o', builtin.find_files)
  map('n', '<leader>f', builtin.live_grep)
  map('n', '<leader>h', builtin.help_tags)
  map('n', '<leader>n', builtin.resume)
end

P[#P + 1] = 'nvim-lua/plenary.nvim'
P[#P + 1] = { 'nvim-telescope/telescope.nvim', config = config }

map('n', '<leader>s', '<cmd>silent! w<cr>')
map('n', '<leader>q', '<cmd>q!<cr>')

for _, key in ipairs({ '<up>', '<down>', '<left>', '<right>' }) do
  for _, mode in ipairs({ 'n', 'i', 'v' }) do
    map(mode, key, '<nop>')
  end
end

-- convenience

build = function()
  vim.cmd('Copilot setup')
end

vim.g.copilot_filetypes = { markdown = true }

P[#P + 1] = { 'github/copilot.vim', build = build }

P[#P + 1] = 'honza/vim-snippets'
P[#P + 1] = 'SirVer/ultisnips'

config = function()
  require('Comment').setup()
end

P[#P + 1] = { 'numToStr/Comment.nvim', config = config }

P[#P + 1] = 'tpope/vim-surround'

-- run telescope.nvim
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
