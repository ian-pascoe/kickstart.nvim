return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'LazyFile', 'VeryLazy' },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require('lazy.core.loader').add_to_rtp(plugin)
      require 'nvim-treesitter.query_predicates'
    end,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    opts = function(_, opts)
      opts.highlight = vim.tbl_deep_extend('force', opts.highlight or {}, { enable = true })
      opts.indent = vim.tbl_deep_extend('force', opts.indent or {}, { enable = true })
      opts.ensure_installed = opts.ensure_installed or {}
    end,
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        opts.ensure_installed = Util.list.dedup(opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
