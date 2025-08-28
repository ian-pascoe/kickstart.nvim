require('spiritvim.config').init()

return {
  { 'folke/lazy.nvim' },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    config = function(_, opts)
      local notify = vim.notify
      require('snacks').setup(opts)
      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      if SpiritVim.has 'noice.nvim' then
        vim.notify = notify
      end
    end,
  },
}
