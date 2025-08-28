return {
  {
    'tpope/vim-sleuth',
    event = 'LazyFile',
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      formatters = {},
      formatters_by_ft = {},
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
    },
    config = function(_, opts)
      local conform = require 'conform'
      conform.setup(opts)
      Util.keymap.set('n', '<leader>cf', function()
        conform.format { async = true, lsp_format = 'fallback' }
      end, { desc = '[F]ormat buffer' })
    end,
  },
  { import = 'ianpascoe.plugins.formatting' },
}
