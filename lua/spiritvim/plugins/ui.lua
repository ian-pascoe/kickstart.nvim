return {
  { -- icons
    'echasnovski/mini.icons',
    lazy = true,
    opts = {
      file = {
        ['.keep'] = { glyph = '󰊢 ', hl = 'MiniIconsGrey' },
        ['devcontainer.json'] = { glyph = ' ', hl = 'MiniIconsAzure' },
      },
      filetype = {
        dotenv = { glyph = ' ', hl = 'MiniIconsYellow' },
      },
    },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: Remove custom require to speed up startup time
      local lualine_require = require 'lualine_require'
      lualine_require.require = require

      return {
        options = {
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { 'alpha', 'dashboard', 'ministarter', 'snacks_dashboard' },
        },
      }
    end,
  },
  { -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    keys = {
      { '<leader>sn', '', desc = '+Noice' },
      {
        '<S-Enter>',
        function()
          require('noice').redirect(vim.fn.getcmdline())
        end,
        mode = 'c',
        desc = 'Redirect Cmdline',
      },
      {
        '<leader>snl',
        function()
          require('noice').cmd 'last'
        end,
        desc = 'Noice Last Message',
      },
      {
        '<leader>snh',
        function()
          require('noice').cmd 'history'
        end,
        desc = 'Noice History',
      },
      {
        '<leader>sna',
        function()
          require('noice').cmd 'all'
        end,
        desc = 'Noice All',
      },
      {
        '<leader>snd',
        function()
          require('noice').cmd 'dismiss'
        end,
        desc = 'Dismiss All',
      },
      {
        '<leader>snt',
        function()
          require('noice').cmd 'pick'
        end,
        desc = 'Noice Picker (Telescope/FzfLua)',
      },
      {
        '<c-f>',
        function()
          if not require('noice.lsp').scroll(4) then
            return '<c-f>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll Forward',
        mode = { 'i', 'n', 's' },
      },
      {
        '<c-b>',
        function()
          if not require('noice.lsp').scroll(-4) then
            return '<c-b>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll Backward',
        mode = { 'i', 'n', 's' },
      },
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == 'lazy' then
        vim.cmd [[messages clear]]
      end
      require('noice').setup(opts)
    end,
  },
  { -- dashboard
    'folke/snacks.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      dashboard = {
        preset = {
          header = [[
⠀⠀⠀⠀⠀⠀⠀⡏⠉⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢸⠉⠉⠁⠀⠉⠉⢹⠀⠀⠀⠀
⠀⠀⠀⠀⠘⠒⠒⡆⠀⡖⠒⠚⠀⠀⠀⠀
 ⡿⡀⠀⠀⠀⠀⡇⠀⡇⠀⠀⠀⠀⡜⡇
⠀⡇⡇⠀⠀⠀⠀⡇⠀⡇⠀⠀⠀⢀⠇⡇
⠀⢧⠘⢴⠲⣄⠀⠉⠉⠁⢀⡴⢲⠞⢰⠃
⠀⠈⠳⡄⠳⠌⠳⡀⠀⡴⠋⠴⢁⡴⠋⠀
⠀⠀⠀⢸⠀⠀⠀⡱⢸⠁⠀⠀⢸⠀⠀⠀
⠀⠀⠀⡞⠀⠀⢀⡇⠀⡇⠀⠀⠸⡄⠀⠀
]],
          keys = {
            { icon = '󰈞 ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = '󰈔 ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            { icon = '󰊄 ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = '󰋚 ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = '󰒓 ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = '󰁯 ', key = 's', desc = 'Restore Session', section = 'session' },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
            { icon = '󰗼 ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
      },
    },
  },
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'LazyFile',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
