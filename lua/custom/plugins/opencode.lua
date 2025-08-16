return {
  'NickvanDyke/opencode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  ---@type opencode.Config
  opts = {},
  keys = {
    {
      '<leader>ot',
      function()
        require('opencode').toggle()
      end,
      desc = '[O]pencode: [T]oggle',
    },
    {
      '<leader>oa',
      function()
        require('opencode').ask '@cursor: '
      end,
      desc = '[O]pencode: [A]sk ',
      mode = 'n',
    },
    {
      '<leader>oa',
      function()
        require('opencode').ask '@selection: '
      end,
      desc = '[O]pencode: [A]sk About Selection',
      mode = 'v',
    },
    {
      '<leader>op',
      function()
        require('opencode').select_prompt()
      end,
      desc = '[O]pencode: Select [P]rompt',
      mode = { 'n', 'v' },
    },
    {
      '<leader>on',
      function()
        require('opencode').command 'session_new'
      end,
      desc = '[O]pencode: [N]ew Session',
    },
    {
      '<leader>oy',
      function()
        require('opencode').command 'messages_copy'
      end,
      desc = '[O]pencode: [Y]ank Last Message',
    },
  },
}
