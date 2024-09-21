-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'

  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- mappings
local map = vim.keymap.set

map('n', '<leader>pl', ':Lazy<cr>', { desc = 'Lazy', silent = true })
map('n', '<leader>pi', ':Lazy install<cr>', { desc = 'Install', silent = true })
map('n', '<leader>pu', ':Lazy update<cr>', { desc = 'Update', silent = true })
map('n', '<leader>ps', ':Lazy sync<cr>', { desc = 'Sync', silent = true })
map('n', '<leader>pc', ':Lazy clean<cr>', { desc = 'Clean', silent = true })
map('n', '<leader>pC', ':Lazy check<cr>', { desc = 'Check', silent = true })
map('n', '<leader>pL', ':Lazy log<cr>', { desc = 'Log', silent = true })
map('n', '<leader>pr', ':Lazy restore<cr>', { desc = 'Restore', silent = true })
map('n', '<leader>pp', ':Lazy profile<cr>', { desc = 'Profile', silent = true })
map('n', '<leader>pb', ':Lazy debug<cr>', { desc = 'Debug', silent = true })
map('n', '<leader>ph', ':Lazy help<cr>', { desc = 'Help', silent = true })
