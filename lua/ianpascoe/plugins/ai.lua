return {
  {
    'github/copilot.vim',
    cmd = 'Copilot',
    event = 'BufWinEnter',
    init = function()
      vim.g.copilot_no_maps = true
    end,
    config = function()
      -- Block the normal Copilot suggestions
      vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload' }, {
        group = vim.api.nvim_create_augroup('github_copilot', { clear = true }),
        callback = function(args)
          vim.fn['copilot#On' .. args.event]()
        end,
      })
      vim.fn['copilot#OnFileType']()
    end,
  },
  {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    event = 'VeryLazy',
    ---@type opencode.Opts
    opts = {},
    keys = {
      {
        '<leader>aoo',
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
  },
}
