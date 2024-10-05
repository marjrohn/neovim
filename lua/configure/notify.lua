local notify = require('notify')
local opts = {}

opts.stages = 'fade'
opts.timeout = 4000
opts.max_height = function()
  return math.floor(vim.o.lines * 0.75)
end

opts.max_width = function()
  return math.floor(vim.o.columns * 0.75)
end

opts.on_open = function(win)
  vim.api.nvim_win_set_config(win, { zindex = 100 })
end

notify.setup(opts)
vim.notify = notify

local map = vim.keymap.set

map('n', '<leader>nn', '<cmd>Notifications<cr>', { desc = 'Show Notifications Log', silent = true })

map('n', '<leader>nd', function()
  notify.dismiss({ silent = true, pending = true })
end, { desc = 'Dismiss All Notifications', silent = true })

map('n', '<leader>nh', function()
  notify.history()
end, { desc = 'Show Past Notifications' })
