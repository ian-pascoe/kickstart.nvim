return {
  'folke/zen-mode.nvim',
  config = function()
    require('zen-mode').setup()
    vim.keymap.set('n', '<leader>zt', function()
      require('zen-mode').toggle()
    end, { desc = '[T]oggle' })
  end,
}
