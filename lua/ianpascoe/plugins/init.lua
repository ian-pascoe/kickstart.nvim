return {
  {
    'tpope/vim-sleuth',
    event = 'LazyFile',
  },
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'LazyFile',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    import = 'ianpascoe.plugins.others',
  },
}
