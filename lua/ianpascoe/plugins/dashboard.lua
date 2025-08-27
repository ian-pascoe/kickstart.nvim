return {
  'nvimdev/dashboard-nvim',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  lazy = vim.fn.argc(-1) ~= 0, -- Do not load on startup if files are passed in
  opts = {
    theme = 'hyper',
    config = {
      header = {
        '',
        ' ██████╗  ██████╗  ██████╗ ██████╗  █████╗ ██████╗  ██████╗ ███████╗',
        '██╔════╝ ██╔═══██╗██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██╔════╝',
        '██║  ███╗██║   ██║██║  ███╗██████╔╝███████║██║  ██║██║   ██║███████╗',
        '██║   ██║██║   ██║██║   ██║██╔══██╗██╔══██║██║  ██║██║   ██║╚════██║',
        '╚██████╔╝╚██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝╚██████╔╝███████║',
        ' ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚══════╝',
        '',
        '          ✝  For God so loved the world, that He gave His only Son  ✝',
        '                   that whoever believes in Him should not perish',
        '                        but have eternal life.  John 3:16',
        '',
      },
      week_header = { enable = false },
      shortcut = {
        {
          desc = 'Update',
          icon = '󰊳 ',
          group = '@property',
          action = 'Lazy update',
          key = 'u',
        },
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
        '',
        'Whatever you do, work heartily, as for the Lord and not for men',
        'Colossians 3:23',
        '',
      },
    },
  },
}
