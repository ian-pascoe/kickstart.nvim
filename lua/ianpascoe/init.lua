vim.uv = vim.uv or vim.loop

local M = {}

function M.setup()
  require('ianpascoe.config').setup()
  require('ianpascoe.lazy').setup()
end

return M
