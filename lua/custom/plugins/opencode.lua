return {
  'NickvanDyke/opencode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  ---@type opencode.Config
  opts = {},
  keys = {
    {
      '<leader>aot',
      function()
        require('opencode').toggle()
      end,
      desc = '[T]oggle',
    },
    {
      '<leader>aoa',
      function()
        require('opencode').ask '@cursor: '
      end,
      desc = '[A]sk ',
      mode = 'n',
    },
    {
      '<leader>aoa',
      function()
        require('opencode').ask '@selection: '
      end,
      desc = '[A]sk About Selection',
      mode = 'v',
    },
    {
      '<leader>aop',
      function()
        require('opencode').select_prompt()
      end,
      desc = 'Select [P]rompt',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aon',
      function()
        require('opencode').command 'session_new'
      end,
      desc = '[N]ew Session',
    },
    {
      '<leader>aoy',
      function()
        require('opencode').command 'messages_copy'
      end,
      desc = '[Y]ank Last Message',
    },
  },
}
