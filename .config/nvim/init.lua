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

-- import plugins and begin setup

P = {}

require('lang')
require('config')

for _, v in ipairs(P) do
  if type(v) == 'string' then
    v = { v }
  end
  if v.lazy == nil then
    v.lazy = false
  end
  if v.priority == nil then
    v.priority = 0
  end
end

require('lazy').setup(P)
