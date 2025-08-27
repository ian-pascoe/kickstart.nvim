return {
  'folke/zen-mode.nvim',
  event = 'VeryLazy',
  config = function()
    local zen = require 'zen-mode'
    zen.setup()
    Util.keymap.set('n', '<leader>z', function()
      zen.toggle()
    end, { desc = 'Toggle [Z]en mode' })
  end,
}
