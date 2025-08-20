return {
  'folke/zen-mode.nvim',
  config = function()
    require('zen-mode').setup()
    vim.keymap.set('n', '<leader>z', function()
      require('zen-mode').toggle()
    end, { desc = 'Toggle [Z]en mode' })
  end,
}
