vim.uv = vim.uv or vim.loop

local M = {}

function M.setup()
  require('spiritvim.lazy').setup()
  require('spiritvim.config').setup()
end

return M
