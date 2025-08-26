return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('rose-pine').setup {
        variant = 'auto',
        styles = { transparency = true },
      }
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
}
