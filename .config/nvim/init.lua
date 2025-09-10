-- bootstrap lazy.nvim. from lazy.nvim documentation
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load `.vimrc`. from Neovim documentation
vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])

-- import plugins and begin setup

P = {}

-- XXX why do plugins not autoload? need PlugInstall or this:
P[#P + 1] = { 'tpope/vim-commentary' }
P[#P + 1] = { 'tpope/vim-unimpaired' }
P[#P + 1] = { 'tpope/vim-surround' }
P[#P + 1] = { 'wellle/targets.vim' }
P[#P + 1] = { 'tpope/vim-repeat' }
P[#P + 1] = { 'llathasa-veleth/vim-brainfuck' }
P[#P + 1] = { 'vim-scripts/bnf.vim' }
P[#P + 1] = { 'Bricktech2000/jumptree.vim' }
P[#P + 1] = { 'airblade/vim-gitgutter' }

local config = function() end

config = function() require('mason').setup() end
P[#P + 1] = { 'williamboman/mason.nvim', config = config }

-- language servers

config = function()
  require('mason-lspconfig').setup({
    -- XXX `automatic_installation` does not appear to work
    ensure_installed = {
      'rust_analyzer',
      'clojure_lsp',
      'pyright',
      -- 'clangd', XXX broken; can't seem to find standard headers. installing from NixOS config instead
      'lua_ls',
      'bashls',
      'vimls',
      'rnix',
      'dockerls',
      'prismals',
      'denols',
      'eslint',
      'cssls',
      'ts_ls',
      'yamlls',
      'jsonls',
      'taplo',
      'html',
    },
    -- automatic_installation = true,
  })
end

P[#P + 1] = { 'williamboman/mason-lspconfig', config = config }

config = function()
  local lspconfig = require('lspconfig')

  -- https://vi.stackexchange.com/questions/43428/how-to-disable-lsp-server-syntax-highlighting
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  })

  -- general purpose
  lspconfig.rust_analyzer.setup({})
  lspconfig.clojure_lsp.setup({})
  lspconfig.pyright.setup({})
  lspconfig.clangd.setup({})
  -- domain specific
  lspconfig.lua_ls.setup({ settings = { Lua = { diagnostics = { globals = { 'vim', 'P' } } } } })
  lspconfig.bashls.setup({})
  lspconfig.vimls.setup({})
  lspconfig.rnix.setup({})
  -- web cruft
  lspconfig.dockerls.setup({})
  lspconfig.prismals.setup({})
  lspconfig.denols.setup({})
  lspconfig.eslint.setup({})
  lspconfig.cssls.setup({})
  lspconfig.ts_ls.setup({})
  -- data and markup
  lspconfig.yamlls.setup({})
  lspconfig.jsonls.setup({})
  lspconfig.taplo.setup({})
  lspconfig.html.setup({})
end

P[#P + 1] = { 'neovim/nvim-lspconfig', config = config }

-- mostly from nvim-lsp documentation
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
  end,
})

-- linting and formatting

config = function()
  require('mason-null-ls').setup({
    -- XXX `automatic_installation` does not appear to work
    ensure_installed = {
      'clang_format',
      'autopep8',
      'rustfmt',
      'shfmt',
      'stylua',
      'prettierd',
      'eslint_d',
    },
    -- automatic_installation = true,
  })
end

P[#P + 1] = { 'jay-babu/mason-null-ls.nvim', config = config }

config = function()
  local null_ls = require('null-ls')
  local fmt = null_ls.builtins.formatting
  local diag = null_ls.builtins.diagnostics

  -- from null-ls documentation
  local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

  -- XXX prettierd is toast so Markdown formatting doesn't work anymore
  null_ls.setup({
    sources = {
      -- general purpose
      fmt.clang_format,
      fmt.autopep8,
      fmt.rustfmt,
      -- domain specific
      fmt.shfmt,
      fmt.stylua,
      -- data and markup
      fmt.prettierd,
      fmt.eslint_d,
    },

    -- from null-ls documentation
    on_attach = function(client, bufnr)
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ async = false }) end,
        })
      end
    end,
  })
end

P[#P + 1] = 'nvim-lua/plenary.nvim'
P[#P + 1] = { 'jose-elias-alvarez/null-ls.nvim', config = config }

for _, plugin in ipairs(P) do
  if type(plugin) == 'string' then plugin = { plugin } end
  if plugin.lazy == nil then plugin.lazy = false end
  if plugin.priority == nil then plugin.priority = 0 end
end

require('lazy').setup(P)
