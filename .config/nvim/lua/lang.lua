local config = function() end

local hi = vim.cmd.highlight
local bg_none = 'ctermbg=None'
local st_underline = 'cterm=underline'

config = function()
  require('mason').setup()
end

P[#P + 1] = { 'williamboman/mason.nvim', config = config }

-- language servers

config = function()
  require('mason-lspconfig').setup({
    -- 'automatic_installation' does not seem to work
    ensure_installed = {
      'rust_analyzer',
      'clojure_lsp',
      'pyright',
      'clangd',
      'lua_ls',
      'bashls',
      'vimls',
      'rnix',
      'tailwindcss',
      'dockerls',
      'tsserver',
      'prismals',
      'denols',
      'eslint',
      'cssls',
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
  lspconfig.tailwindcss.setup({})
  lspconfig.dockerls.setup({})
  lspconfig.tsserver.setup({})
  lspconfig.prismals.setup({})
  lspconfig.denols.setup({})
  lspconfig.eslint.setup({})
  lspconfig.cssls.setup({})
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
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
  end,
})

-- linting and formatting

config = function()
  require('mason-null-ls').setup({
    automatic_installation = true,
  })
end

P[#P + 1] = { 'jay-babu/mason-null-ls.nvim', config = config }

config = function()
  local null_ls = require('null-ls')
  local fmt = null_ls.builtins.formatting
  local diag = null_ls.builtins.diagnostics

  -- from null-ls documentation
  local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

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
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end
    end,
  })
end

P[#P + 1] = { 'jose-elias-alvarez/null-ls.nvim', config = config }

-- notes

config = function()
  local conceals = {
    ['&nbsp;'] = ' ',
    ['&mdash;'] = '—',
    ['&times;'] = '×',
    ['&bull;'] = '•',
    ['&lambda;'] = 'λ',
    ['&minus;'] = '−',
    ['&equiv;'] = '≡',
    ['&uarr;'] = '↑',
    ['&darr;'] = '↓',
    ['&larr;'] = '←',
    ['&rarr;'] = '→',
  }
  for match, cchar in pairs(conceals) do
    vim.cmd('autocmd BufEnter * syntax match Conceal "' .. match .. '" conceal cchar=' .. cchar)
  end

  hi({ 'clear', 'Conceal' })
end

P[#P + 1] = { 'vimwiki/vimwiki', config = config }
vim.g.vimwiki_key_mappings = { table_mappings = 0 } -- prevents vimwiki from remapping <Tab> in insert mode
vim.g.vimwiki_table_auto_fmt = 0 -- prevents vtmwiki from constantly breaking tables
vim.g.vimwiki_filetypes = { 'markdown' } -- prevents vimwiki from overriding `filetype` and breaking Prettier
vim.g.vimwiki_conceallevel = 0 -- disables vimwiki conceal
-- vim.g.vimwiki_conceal_pre = 1 -- conceals code block markers
-- vim.g.vimwiki_ext2syntax = { ['.md'] = 'default' } -- needed for backlink update on rename
