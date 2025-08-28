-- Jenkinsfile autocmd
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  desc = 'Set filetype to groovy for Jenkinsfiles',
  group = vim.api.nvim_create_augroup('jenkinsfile_ft', { clear = true }),
  pattern = { '*.Jenkinsfile', 'Jenkinsfile' },
  command = 'set filetype=groovy',
})

return {
  {
    'ckipp01/nvim-jenkinsfile-linter',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
}
