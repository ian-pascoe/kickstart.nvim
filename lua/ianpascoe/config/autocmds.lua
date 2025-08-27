---@class ianpascoe.config.autocmds
local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
    callback = function()
      vim.hl.on_yank()
    end,
  })

  -- Jenkinsfile autocmd
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    desc = 'Set filetype to groovy for Jenkinsfiles',
    group = vim.api.nvim_create_augroup('jenkinsfile_ft', { clear = true }),
    pattern = { '*.Jenkinsfile', 'Jenkinsfile' },
    command = 'set filetype=groovy',
  })
end

return M
