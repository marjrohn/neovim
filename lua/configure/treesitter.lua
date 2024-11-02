local opts = {}

opts.highlight = { enable = true }
opts.indent = { enable = true }
opts.ensure_installed = {
  'vim',
  'vimdoc',
  'bash',
  'c',
  'diff',
  'lua',
  'luadoc',
  'printf',
  'query',
  'regex',
  'markdown',
  'markdown_inline',
  'json',
  'toml',
  'html',
}
opts.sync_install = true
opts.incremental_selection = { enable = true }
opts.incremental_selection.keymaps = {
  init_selection = '<c-space>',
  node_incremental = '<c-space>',
  scope_incremental = false,
  node_decremental = '<bs>',
}

-- text objects
opts.textobjects = {
  swap = { enable = true },
  move = { enable = true },
}

opts.textobjects.swap.swap_next = { ['<a-l>'] = '@parameter.inner' }
opts.textobjects.swap.swap_previous = { ['<a-h>'] = '@parameter.inner' }

opts.textobjects.move.goto_next_start = {
  [']f'] = '@function.outer',
  [']c'] = '@class.outer',
  [']a'] = '@parameter.inner',
}
opts.textobjects.move.goto_next_end = {
  [']F'] = '@function.outer',
  [']C'] = '@class.outer',
  [']A'] = '@parameter.inner',
}

opts.textobjects.move.goto_previous_start = {
  ['[f'] = '@function.outer',
  ['[c'] = '@class.outer',
  ['[a'] = '@parameter.inner',
}
opts.textobjects.move.goto_previous_start = {
  ['[F'] = '@function.outer',
  ['[C'] = '@class.outer',
  ['[A'] = '@parameter.inner',
}

require('nvim-treesitter.configs').setup(opts)

-- textobjects keymaps
local map = vim.keymap.set

local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

-- repeat movement with ; and ,
map({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
map({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

-- make builtin f, F, t, T also repeatable with ; and ,
map({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true, silent = true })
map({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true, silent = true })
map({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true, silent = true })
map({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true, silent = true })
