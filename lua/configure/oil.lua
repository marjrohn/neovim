local oil = require('oil')
opts = {}

opts.delete_to_trash = true
opts.skip_confirm_for_simple_edits = true
opts.lsp_file_methods = { autosave_changes = true }
opts.keymaps = {
  ['<c-j>'] = 'actions.preview_scroll_down',
  ['<c-k>'] = 'actions.preview_scroll_up',
}
opts.view_options = {
  is_always_hidden = function(name)
    return name == '.git'
  end,
}
opts.float = { padding = 4 }
opts.float.win_options = { winblend = 12 }
opts.float.override = function(conf)
  conf.width = math.floor(0.8 * vim.o.columns)
  conf.col = math.floor(0.1 * vim.o.columns)

  return conf
end

oil.setup(opts)

vim.keymap.set('n', '<leader>e', function()
  oil.toggle_float()
end, { desc = 'File Explorer', noremap = true, silent = true })

vim.keymap.set('n', '<leader>E', function()
  oil.open_float(vim.fn.getcwd())
end, { desc = 'File Explorer (CWD)', noremap = true, silent = true })
