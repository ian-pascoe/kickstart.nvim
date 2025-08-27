require('ianpascoe.config').init()

return {
  { 'folke/lazy.nvim' },
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'LazyFile',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {},
    config = function(_, opts)
      require('snacks').setup(opts)
    end,
  },
  {
    import = 'ianpascoe.plugins.other',
  },
}
