local LazyUtil = require 'lazy.core.util'

---@class spiritvim.util: LazyUtilCore
---@field keymap spiritvim.util.keymap
---@field list spiritvim.util.list
---@field root spiritvim.util.root
---@field table spiritvim.util.table
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    t[k] = require('spiritvim.util.' .. k)
    return t[k]
  end,
})

function M.is_win()
  return vim.uv.os_uname().sysname:find 'Windows' ~= nil
end

---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end,
  })
end

---@param name string
function M.get_plugin(name)
  return require('lazy.core.config').spec.plugins[name]
end

---@param name string
---@param path string?
function M.get_plugin_path(name, path)
  local plugin = M.get_plugin(name)
  path = path and '/' .. path or ''
  return plugin and (plugin.dir .. path)
end

---@param plugin string
function M.has(plugin)
  return M.get_plugin(plugin) ~= nil
end

---@param ms number
---@param fn function
---@return any
function M.debounce(ms, fn)
  local timer = vim.uv.new_timer()
  if timer == nil then
    SpiritVim.warn 'Unable to find timer, skipping debouce'
    return function(...)
      local argv = { ... }
      vim.schedule_wrap(fn)(unpack(argv))
    end
  end

  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

return M
