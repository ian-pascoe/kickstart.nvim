require('ianpascoe.config').init()

return {
  { 'folke/lazy.nvim' },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    config = function(_, opts)
      require('snacks').setup(opts)
    end,
  },
}
