-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local M = {}

function M.setup()
  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Buffer keymaps
  vim.keymap.set('n', '<leader>bd', '<CMD>bdel<CR>', { desc = '[D]elete' })
  vim.keymap.set('n', '<leader>br', '<CMD>checktime<CR>', { desc = '[R]efresh' })

  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous [D]iagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [D]iagnostic message' })
  vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, { desc = 'Show [E]rror message' })
  vim.keymap.set('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Open [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- Disable arrow keys in normal mode
  vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Disable arrow keys in insert mode to enforce vim worflows
  vim.keymap.set('i', '<left>', '<cmd>echo "Use Esc->h to move!!"<CR>')
  vim.keymap.set('i', '<right>', '<cmd>echo "Use Esc->l to move!!"<CR>')
  vim.keymap.set('i', '<up>', '<cmd>echo "Use Esc->k to move!!"<CR>')
  vim.keymap.set('i', '<down>', '<cmd>echo "Use Esc->j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
  vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
  vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
  vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

  -- Better page-up/down
  vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
  vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })

  -- Better indent
  vim.keymap.set('v', '<', '<gv', { noremap = true })
  vim.keymap.set('v', '>', '>gv', { noremap = true })

  -- Move selection
  vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
  vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
end

return M
