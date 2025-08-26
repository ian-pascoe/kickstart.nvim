-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
local M = {}

function M.setup()
  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
      vim.hl.on_yank()
    end,
  })

  -- Jenkinsfile autocmd
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.Jenkinsfile', 'Jenkinsfile' },
    command = 'set filetype=groovy',
  })
end

return M
