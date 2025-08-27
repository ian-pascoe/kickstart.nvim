_G.Util = require 'ianpascoe.util'

---@class ianpascoe.config
---@field options ianpascoe.config.options
---@field keymaps ianpascoe.config.keymaps
---@field autocmds ianpascoe.config.autocmds
local M = {}

setmetatable(M, {
  __index = function(_, k)
    local mod = require('ianpascoe.config.' .. k)
    return mod
  end,
})

function M.setup()
  M.options.setup()
  M.keymaps.setup()
  M.autocmds.setup()
end

M.did_init = false
function M.init()
  if M.did_init then
    return
  end
  M.did_init = true

  M.options.setup()
end

return M
