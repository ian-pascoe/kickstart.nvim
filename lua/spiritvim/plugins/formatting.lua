return {
  {
    'tpope/vim-sleuth',
    event = 'LazyFile',
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      formatters = {},
      formatters_by_ft = {},
      format_on_save = function(bufnr)
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
    },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        desc = '[F]ormat buffer',
      },
    },
  },
  { import = 'spiritvim.plugins.formatting' },
}
