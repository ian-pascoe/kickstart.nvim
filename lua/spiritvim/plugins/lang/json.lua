return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'json', 'json5', 'jsonc' },
    },
  },
  { 'b0o/SchemaStore.nvim' },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            local schemastore = require 'schemastore'
            new_config.settings.json.schemas = vim.tbl_deep_extend(new_config.settings.json.schemas or {}, schemastore.json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
}
