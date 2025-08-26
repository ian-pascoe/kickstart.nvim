_G.Utils = require 'ianpascoe.utils'

local M = {}

function M.setup()
  require('ianpascoe.config.options').setup()
  require('ianpascoe.config.keymaps').setup()
  require('ianpascoe.config.autocmds').setup()
end

return M
