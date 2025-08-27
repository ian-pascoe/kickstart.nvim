return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = 'LazyFile',
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters = opts.linters or {}
    end,
    config = function(_, opts)
      local nvimLint = require 'lint'
      nvimLint.linters_by_ft = opts.linters_by_ft or {}

      local function lint()
        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = nvimLint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original.
        names = vim.list_extend({}, names)

        -- Add fallback linters.
        if #names == 0 then
          vim.list_extend(names, nvimLint.linters_by_ft['_'] or {})
        end

        -- Add global linters.
        vim.list_extend(names, nvimLint.linters_by_ft['*'] or {})

        -- Run linters.
        if #names > 0 then
          nvimLint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = Util.debounce(100, lint),
      })
    end,
  },
}
