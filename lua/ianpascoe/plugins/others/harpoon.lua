return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  event = { 'LazyFile', 'VeryLazy' },
  config = function()
    require('harpoon').setup {}
    pcall(require('telescope').load_extension, 'harpoon')

    local harpoon_ui = require 'harpoon.ui'
    local harpoon_mark = require 'harpoon.mark'

    vim.keymap.set('n', '<leader>ha', harpoon_mark.add_file, { desc = '[A]dd file' })
    vim.keymap.set('n', '<leader>hh', harpoon_ui.toggle_quick_menu, { desc = 'Toggle' })
    vim.keymap.set('n', '<leader>hs', '<CMD>Telescope harpoon marks<CR>', { desc = '[S]earch marked' })
    vim.keymap.set('n', '[h', harpoon_ui.nav_prev, { desc = 'Harpoon: navigate prev' })
    vim.keymap.set('n', ']h', harpoon_ui.nav_next, { desc = 'Harpoon: navigate next' })
    -- Dynamic keymap for <leader>h{number} to navigate to harpoon file by index
    vim.keymap.set('n', '<leader>h', function()
      local num = vim.fn.getchar()
      local char = vim.fn.nr2char(num)
      local file_index = tonumber(char)
      if file_index and file_index >= 1 and file_index <= 9 then
        harpoon_ui.nav_file(file_index)
      else
        print('Invalid harpoon file number: ' .. char)
      end
    end, { desc = 'Harpoon: Navigate to file by number (1-9)' })
  end,
}
