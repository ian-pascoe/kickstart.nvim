return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'json', 'json5', 'jsonc' })
    end,
  },
  { 'b0o/SchemaStore.nvim' },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.jsonls = {
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          local schemastore = require 'schemastore'
          new_config.settings.json.schemas = vim.tbl_deep_extend('force', new_config.settings.json.schemas or {},
            schemastore.json.schemas())
        end,
        settings = {
          json = {
            format = { enable = true },
            validate = { enable = true },
          },
        },
      }
    end,
  },
}
