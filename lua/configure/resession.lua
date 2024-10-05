local resession = require('resession')
local opts = {}

opts.dir = 'resession'

opts.autoload = {
  enabled = true,
  interval = 60,
  notify = true,
}

-- override default filter
opts.buf_filter = function(bufnr)
  local buftype = vim.bo[bufnr].buftype

  if buftype == 'help' then
    return true
  end

  if buftype ~= '' and buftype ~= 'acwrite' then
    return false
  end

  if vim.api.nvim_buf_get_name(bufnr) == '' then
    return false
  end

  return true -- this is required, since the default filter skips nobuflisted buffers
end

opts.extensions = { scope = {} }

resession.setup(opts)

local map = vim.keymap.set

map('n', '<leader>ss', resession.save)
map('n', '<leader>sl', resession.load)
map('n', '<leader>sd', resession.delete)

-- automatically save a session named "last" when exiting
vim.api.nvim_create_autocmd('VimLeavePre', {
  group = vim.api.nvim_create_augroup('resession_save', { clear = false }),
  callback = function()
    resession.save('last')
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('resession_load', { clear = false }),
  callback = function()
    -- only load if nvim was started with no args
    if vim.fn.argc(-1) == 0 then
      resession.load('last')
    end
  end,
})
