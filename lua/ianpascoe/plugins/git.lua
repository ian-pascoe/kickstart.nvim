return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    event = 'VeryLazy',
    cmd = 'Neogit',
    config = function()
      local neogit = require 'neogit'
      neogit.setup {}
      Util.keymap.set('n', '<leader>gg', function()
        neogit.open {}
      end, { desc = '[G] Neogit' })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'LazyFile',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          Util.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>ghs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[g]it [s]tage hunk' })
        map('v', '<leader>ghr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[g]it [r]eset hunk' })
        -- normal mode
        map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = '[g]it [s]tage hunk' })
        map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = '[g]it [r]eset hunk' })
        map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = '[g]it [S]tage buffer' })
        map('n', '<leader>ghu', gitsigns.stage_hunk, { desc = '[g]it [u]ndo stage hunk' })
        map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = '[g]it [R]eset buffer' })
        map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = '[g]it [p]review hunk' })
        map('n', '<leader>ghb', gitsigns.blame_line, { desc = '[g]it [b]lame line' })
        map('n', '<leader>ghd', gitsigns.diffthis, { desc = '[g]it [d]iff against index' })
        map('n', '<leader>ghD', function()
          gitsigns.diffthis '@'
        end, { desc = '[g]it [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle [g]it show [b]lame line' })
        map('n', '<leader>gtD', gitsigns.preview_hunk_inline, { desc = '[T]oggle [g]it show [D]eleted' })
      end,
    },
  },
}
