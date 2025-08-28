local LazyUtil = require 'lazy.core.util'

---@class ianpascoe.util: LazyUtilCore
---@field keymap ianpascoe.util.keymap
---@field list ianpascoe.util.list
---@field table ianpascoe.util.table
local M = {}

setmetatable(M, {
  __index = function(_, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    local mod = require('ianpascoe.util.' .. k)
    return mod
  end,
})

---@param ms number
---@param fn function
---@return any
function M.debounce(ms, fn)
  local timer = vim.uv.new_timer()
  if timer == nil then
    Util.warn 'Unable to find timer, skipping debouce'
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
