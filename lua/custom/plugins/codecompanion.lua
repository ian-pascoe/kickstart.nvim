return {
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
    vim.keymap.set('n', '<leader>ct', function()
      require('codecompanion').toggle()
    end, { desc = '[C]ode Companion: [T]oggle' })
  end,
}
