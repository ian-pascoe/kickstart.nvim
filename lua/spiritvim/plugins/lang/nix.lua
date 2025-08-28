return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'nix' },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = { 'alejandra' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        nixd = {
          mason = false,
          cmd = { 'nixd' },
          filetypes = { 'nix' },
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        nix = { 'alejandra' },
      },
    },
  },
}
