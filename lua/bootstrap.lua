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

map('n', '<leader><cr><cr>', ':Lazy<cr>', { desc = 'Plugin Management', silent = true })
map('n', '<leader><cr>i', ':Lazy install<cr>', { desc = 'Install', silent = true })
map('n', '<leader><cr>u', ':Lazy update<cr>', { desc = 'Update', silent = true })
map('n', '<leader><cr>s', ':Lazy sync<cr>', { desc = 'Sync', silent = true })
map('n', '<leader><cr>c', ':Lazy clean<cr>', { desc = 'Clean', silent = true })
map('n', '<leader><cr>C', ':Lazy check<cr>', { desc = 'Check', silent = true })
map('n', '<leader><cr>l', ':Lazy log<cr>', { desc = 'Log', silent = true })
map('n', '<leader><cr>r', ':Lazy restore<cr>', { desc = 'Restore', silent = true })
map('n', '<leader><cr>p', ':Lazy profile<cr>', { desc = 'Profile', silent = true })
map('n', '<leader><cr>b', ':Lazy debug<cr>', { desc = 'Debug', silent = true })
map('n', '<leader><cr>h', ':Lazy help<cr>', { desc = 'Help', silent = true })
