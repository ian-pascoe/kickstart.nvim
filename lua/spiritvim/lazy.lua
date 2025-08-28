local M = {}

function M.setup()
  -- [[ Install `lazy.nvim` plugin manager ]]
  --    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
      error('Error cloning lazy.nvim:\n' .. out)
    end
  end

  ---@type vim.Option
  local rtp = vim.opt.rtp
  rtp:prepend(lazypath)

  local Event = require 'lazy.core.handler.event'
  Event.mappings.LazyFile = { id = 'LazyFile', event = { 'BufReadPre', 'BufReadPost', 'BufNewFile', 'BufWritePre' } }
  Event.mappings['User LazyFile'] = Event.mappings.LazyFile

  require('lazy').setup {
    spec = {
      { import = 'spiritvim.plugins' },
    },
    defaults = {
      lazy = true,
      version = '*',
    },
    install = {
      colorscheme = { 'rose-pine', 'habamax' },
    },
    change_detection = {
      enabled = true,
      notify = false,
    },
  }
end

return M
