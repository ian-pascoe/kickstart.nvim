return {
  'stevearc/oil.nvim',
  dependencies = {
    'echasnovski/mini.icons',
  },
  lazy = false,
  config = function()
    require('oil').setup()
    vim.keymap.set('n', '<leader>\\', '<CMD>Oil<CR>', { desc = '[\\] File Tree' })
  end,
}
