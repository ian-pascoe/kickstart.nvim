return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>gg', '<CMD>Neogit<CR>', { desc = '[G] Neogit' })
  end,
}
