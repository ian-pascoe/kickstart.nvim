return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        week_header = { enable = true },
        shortcut = {
          { desc = 'Update', icon = '󰊳 ', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = '@property',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            icon = '󰒻 ',
            icon_hl = '@variable',
            desc = 'Config',
            group = '@property',
            action = 'Telescope find_files cwd=~/.config/nvim',
            key = 'c',
          },
        },
        footer = {
          "💪🏼 Let's get to work 💪🏼",
        },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
