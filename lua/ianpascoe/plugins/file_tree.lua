return {
  'stevearc/oil.nvim',
  dependencies = {
    'echasnovski/mini.icons',
  },
  lazy = false,
  config = function()
    local oil = require 'oil'
    oil.setup()
    vim.keymap.set('n', '<leader>\\', oil.open, { desc = '[\\] File Tree' })
  end,
}
