return {

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = function(_, opts)
      opts.notify_on_error = opts.notify_on_error or false
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.format_on_save = opts.format_on_save
        or function(bufnr)
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          else
            return {
              timeout_ms = 500,
              lsp_format = 'fallback',
            }
          end
        end
    end,
    config = function(_, opts)
      require('conform').setup(opts)
      vim.keymap.set('n', '<leader>cf', function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end, { desc = '[F]ormat buffer' })
    end,
  },
  {
    import = 'ianpascoe.plugins.format',
  },
}
