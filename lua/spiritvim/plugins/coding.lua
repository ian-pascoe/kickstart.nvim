return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'saghen/blink.compat', opts = {} },
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'fang2hou/blink-copilot',
      'folke/lazydev.nvim',
    },
    opts_extend = {
      'sources.completion.enabled_providers',
      'sources.compat',
      'sources.default',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'copilot', 'lazydev' },
        providers = {
          copilot = { name = 'copilot', module = 'blink-copilot', score_offset = 100, async = true },
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },
  { -- Better text objects
    'echasnovski/mini.ai',
    opts = { n_lines = 500 },
  },
  { -- Better surround
    'echasnovski/mini.surround',
    opts = {},
  },
}
