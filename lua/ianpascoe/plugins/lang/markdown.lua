vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    vim.filetype.add {
      extension = {
        mdx = 'markdown.mdx',
      },
    }
  end,
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'markdown', 'markdown_inline' },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = { 'markdownlint-cli2', 'markdown-toc' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        ['markdownlint-cli2'] = {},
        ['markdown-toc'] = {},
      },
      formatters_by_ft = {
        markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
        ['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
        ['markdown.mdx'] = { 'markdownlint-cli2' },
      },
    },
  },
}
