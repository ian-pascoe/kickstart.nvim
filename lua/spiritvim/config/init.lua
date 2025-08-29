_G.SpiritVim = require 'spiritvim.util'

---@class spiritvim.config
local M = {}

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local function _load(mod)
    if require('lazy.core.cache').find(mod)[1] then
      SpiritVim.try(function()
        require(mod)
      end, { msg = 'Failed loading ' .. mod })
    end
  end

  local pattern = 'SpiritVim' .. name:sub(1, 1):upper() .. name:sub(2)
  _load('spiritvim.config.' .. name)
  if vim.bo.filetype == 'lazy' then
    -- HACK: SpiritVim may have overwritten options of the Lazy ui, so reset this here
    vim.cmd [[do VimResized]]
  end
  vim.api.nvim_exec_autocmds('User', { pattern = pattern, modeline = false })
end

local lazy_clipboard

function M.setup()
  -- autocmds can be loaded lazily when not opening a file
  local lazy_autocmds = vim.fn.argc(-1) == 0
  if not lazy_autocmds then
    M.load 'autocmds'
  end
  local group = vim.api.nvim_create_augroup('SpiritVim', { clear = true })
  vim.api.nvim_create_autocmd('User', {
    group = group,
    pattern = 'VeryLazy',
    callback = function()
      if lazy_autocmds then
        M.load 'autocmds'
      end
      M.load 'keymaps'
      if lazy_clipboard ~= nil then
        vim.opt.clipboard = lazy_clipboard
      end

      SpiritVim.root.setup()
    end,
  })
end

M.did_init = false
function M.init()
  if M.did_init then
    return
  end
  M.did_init = true

  -- delay notifications till vim.notify was replaced or after 500ms
  SpiritVim.lazy_notify()

  -- load options here, before lazy init while sourcing plugin modules
  -- this is needed to make sure options will be correctly applied
  -- after installing missing plugins
  M.load 'options'

  -- defer built-in clipboard handling: "xsel" and "pbcopy" can be slow
  lazy_clipboard = vim.opt.clipboard
  vim.opt.clipboard = ''
end

return M
