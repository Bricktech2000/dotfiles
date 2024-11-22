local config = function() end
local build = function() end

local map = vim.keymap.set
local hi = vim.cmd.highlight
local bg_none = 'ctermbg=none'
local fg_none = 'ctermfg=none'
local fg_black = 'ctermfg=0'
local st_bold = 'cterm=bold'
local fg_white = 'ctermfg=7'
local bg_gray = 'ctermbg=238'
local fg_gray = 'ctermfg=239'

-- XXX why do plugins not autoload? need PlugInstall or this:
P[#P + 1] = { 'tpope/vim-speeddating' }
P[#P + 1] = { 'tpope/vim-commentary' }
P[#P + 1] = { 'tpope/vim-surround' }
P[#P + 1] = { 'tpope/vim-repeat' }
P[#P + 1] = { 'tomasr/molokai' }
P[#P + 1] = { 'llathasa-veleth/vim-brainfuck' }
P[#P + 1] = { 'vim-scripts/bnf.vim' }
P[#P + 1] = { 'airblade/vim-gitgutter' }

-- navigation

config = function()
  local devicons = require('nvim-web-devicons')
  for _, icon in pairs(devicons.get_icons()) do
    devicons.set_icon({ [icon.name] = { name = icon.name, color = 'white' } })
  end
  devicons.set_default_icon('', 'white') -- exa's default icon
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

  -- local builtin = require('telescope.builtin')
  -- map('n', '<leader>o', builtin.find_files)
  -- map('n', '<leader>f', builtin.live_grep)
  -- map('n', '<leader>h', builtin.help_tags)
  -- map('n', '<leader>n', builtin.resume)
end

P[#P + 1] = 'nvim-lua/plenary.nvim'
P[#P + 1] = { 'nvim-telescope/telescope.nvim', config = config }

-- -- run telescope.nvim on startup if the current buffer is a directory
-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     local bufferPath = vim.fn.expand('%:p')
--     local builtin = require('telescope.builtin')
--     if vim.fn.isdirectory(bufferPath) ~= 0 then
--       vim.api.nvim_buf_delete(0, { force = true })
--       builtin.find_files({ search_dirs = { bufferPath } })
--     end
--   end,
-- })
