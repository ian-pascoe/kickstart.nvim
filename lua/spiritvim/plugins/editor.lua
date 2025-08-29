return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    cmd = { 'TSInstall', 'TSInstallSync', 'TSUpdate', 'TSUpdateSync' },
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
    opts_extend = { 'ensure_installed' },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {},
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        opts.ensure_installed = SpiritVim.list.dedup(opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons' },
    opts_extend = { 'spec' },
    opts = {
      preset = 'helix',
      delay = 0,
      -- Document existing key chains
      spec = {
        { '<leader>a', group = 'AI' },
        { '<leader>ac', group = 'Code Companion' },
        { '<leader>ao', group = 'Opencode' },
        {
          '<leader>b',
          group = 'Buffer',
          expand = function()
            return require('which-key.extras').expand.buf()
          end,
        },
        { '<leader>c', group = 'Code' },
        { '<leader>d', group = 'Debug' },
        { '<leader>dp', group = 'Profiler' },
        { '<leader>f', group = 'File/Find' },
        { '<leader>g', group = 'Git' },
        { '<leader>gh', group = 'Hunk', mode = { 'n', 'v' } },
        { '<leader>gt', group = 'Toggle' },
        { '<leader>h', group = 'Harpoon', icon = '⚓' },
        { '<leader>q', group = 'Quit' },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Terminal' },
        { '<leader>u', group = 'UI' },
        {
          '<leader>w',
          group = 'Window',
          proxy = '<c-w>',
          expand = function()
            return require('which-key.extras').expand.win()
          end,
        },
        { '[', group = 'Prev' },
        { ']', group = 'Next' },
        { 'g', group = 'Goto' },
        { 'gr', group = 'LSP' },
        { 'gs', group = 'Surround' },
        { 'z', group = 'Fold' },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Which Key (current buffer)',
      },
    },
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    lazy = false,
    opts = {},
    keys = {
      { '<leader>\\', '<cmd>Oil<cr>', desc = '[\\] File Tree' },
    },
  },
  {
    'ThePrimeagen/harpoon',
    event = { 'LazyFile', 'VeryLazy' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('harpoon').setup {}
      pcall(require('telescope').load_extension, 'harpoon')

      local harpoon_ui = require 'harpoon.ui'
      local harpoon_mark = require 'harpoon.mark'

      SpiritVim.keymap.set('n', '<leader>ha', harpoon_mark.add_file, { desc = 'Add file' })
      SpiritVim.keymap.set('n', '<leader>hh', harpoon_ui.toggle_quick_menu, { desc = 'Toggle' })
      SpiritVim.keymap.set('n', '<leader>hs', '<CMD>Telescope harpoon marks<CR>', { desc = 'Search marked' })
      SpiritVim.keymap.set('n', '[h', harpoon_ui.nav_prev, { desc = 'Harpoon prev' })
      SpiritVim.keymap.set('n', ']h', harpoon_ui.nav_next, { desc = 'Harpoon next' })
      -- Static keymaps for <leader>h{1-9} to navigate to harpoon files
      for i = 1, 9 do
        SpiritVim.keymap.set('n', '<leader>h' .. i, function()
          harpoon_ui.nav_file(i)
        end, { desc = 'Navigate to harpoon file ' .. i })
      end
    end,
  },
}
