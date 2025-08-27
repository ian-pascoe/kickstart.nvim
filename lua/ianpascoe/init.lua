vim.uv = vim.uv or vim.loop

local M = {}

function M.setup()
  require('ianpascoe.lazy').setup()
  require('ianpascoe.config').setup()
end

return M
