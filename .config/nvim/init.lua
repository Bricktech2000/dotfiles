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

require('config')
require('lang')

for _, plugin in ipairs(P) do
  if type(plugin) == 'string' then plugin = { plugin } end
  if plugin.lazy == nil then plugin.lazy = false end
  if plugin.priority == nil then plugin.priority = 0 end
end

require('lazy').setup(P)
