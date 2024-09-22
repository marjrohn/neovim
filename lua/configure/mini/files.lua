local mini_files = require('mini.files')

local opts = {}

opts.option = {
  permament_delete = false,
}

opts.windows = {
  preview = true,
  width_focus = 30,
  width_preview = 30,
}

vim.keymap.set('n', '<leader>e', function()
  mini_files.open(vim.api.nvim_buf_get_name(0), true)
end, { desc = 'Open File Explorer' })

vim.keymap.set('n', '<leader>E', function()
  mini_files.open(vim.uv.cwd(), true)
end, { desc = 'Open File Explorer (CWD)' })

mini_files.setup(opts)
