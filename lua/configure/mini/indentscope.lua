local opts = {
  symbol = '│',
  options = { try_as_border = true },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'fzf',
    'help',
    'lazy',
    'lazyterm',
    'notify',
    'toggleterm',
    'Trouble',
    'trouble',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

require('mini.indentscope').setup(opts)
