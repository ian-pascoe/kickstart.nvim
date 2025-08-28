return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      SpiritVim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help' })
      SpiritVim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
      SpiritVim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Files' })
      SpiritVim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Select Telescope' })
      SpiritVim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Current Word' })
      SpiritVim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Grep' })
      SpiritVim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })
      SpiritVim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume' })
      SpiritVim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Recent Files' })
      SpiritVim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      SpiritVim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 0,
          previewer = false,
        })
      end, { desc = 'Search current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      SpiritVim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Open Files' })

      -- Shortcut for searching your Neovim configuration files
      SpiritVim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Neovim files' })

      SpiritVim.keymap.set(
        'v',
        '<leader>ss',
        "\"zy<CMD>exec 'Telescope live_grep default_text=' . escape(@z, ' ')<CR><ESC>",
        { desc = 'Selection', noremap = true, silent = true }
      )
    end,
  },
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>sR',
        function()
          local grug = require 'grug-far'
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
    },
  },
}
