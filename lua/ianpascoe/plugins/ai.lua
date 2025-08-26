return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'ravitemer/mcphub.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
        },
        build = 'npm install -g mcp-hub@latest',
        config = function()
          require('mcphub').setup()
        end,
      },
    },
    event = 'VeryLazy',
    config = function()
      require('codecompanion').setup {
        extensions = {
          mcphub = {
            callback = 'mcphub.extensions.codecompanion',
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_results_in_chat = true,
            },
          },
        },
      }
      vim.keymap.set('n', '<leader>acc', function()
        require('codecompanion').toggle()
      end, { desc = 'Toggle [C]ode [C]ompanion' })
    end,
  },
  {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    event = 'VeryLazy',
    ---@type opencode.Opts
    opts = {},
    keys = {
      {
        '<leader>aoo',
        function()
          require('opencode').toggle()
        end,
        desc = '[T]oggle',
      },
      {
        '<leader>aoa',
        function()
          require('opencode').ask '@cursor: '
        end,
        desc = '[A]sk ',
        mode = 'n',
      },
      {
        '<leader>aoa',
        function()
          require('opencode').ask '@selection: '
        end,
        desc = '[A]sk About Selection',
        mode = 'v',
      },
      {
        '<leader>aop',
        function()
          require('opencode').select_prompt()
        end,
        desc = 'Select [P]rompt',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aon',
        function()
          require('opencode').command 'session_new'
        end,
        desc = '[N]ew Session',
      },
      {
        '<leader>aoy',
        function()
          require('opencode').command 'messages_copy'
        end,
        desc = '[Y]ank Last Message',
      },
    },
  },
}
