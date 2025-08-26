return {
  {
    'akinsho/toggleterm.nvim',
    event = "VimEnter",
    config = function()
      local tterm = require 'toggleterm'
      tterm.setup {}

      local map = vim.keymap.set
      map('n', '<C-\\>', function()
        tterm.toggle()
      end, { desc = 'Toggle terminal' })
      map('n', '<leader>tt', function()
        tterm.toggle()
      end, { desc = '[T]oggle [T]erminal' })
      map('n', '<leader>tn', function()
        tterm.new()
      end, { desc = '[N]ew [T]erminal' })
      map('n', '<leader>tv', function()
        tterm.new(90, nil, 'vertical')
      end, { desc = '[T]oggle [V]ertical terminal' })
      map('n', '<leader>ta', function()
        tterm.toggle_all()
      end, { desc = '[T]oggle [A]ll terminals' })

      -- Dynamic keymap for <leader>t{number} to navigate to terminal by index
      vim.keymap.set('n', '<leader>t', function()
        local num = vim.fn.getchar()
        local char = vim.fn.nr2char(num)
        local term_index = tonumber(char)
        if term_index and term_index >= 1 and term_index <= 9 then
          tterm.toggle(term_index)
        else
          print('Invalid terminal index: ' .. char)
        end
      end, { desc = 'Toggle [T]erminal {Index}' })

      local function set_terminal_keymaps()
        local opts = { buffer = 0 }
        map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*',
        callback = set_terminal_keymaps,
      })
    end,
  },
}
