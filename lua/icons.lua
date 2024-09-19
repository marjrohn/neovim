local M = {
  vim = '',
  neovim = '',
}

M.numeric = {
  [1] = '󰬺',
  [2] = '󰬻',
  [3] = '󰬼',
  [4] = '󰬽',
  [5] = '󰬾',
  [6] = '󰬿',
  [7] = '󰭀',
  [8] = '󰭁',
  [9] = '󰭂',
}

M.git = {
  logo = '',
  branch = '',
  commit = '',
  merge = '',
  compare = '',
}

M.git.diff = {
  added = '',
  ignored = '',
  modified = '',
  removed = '',
  renamed = '',
}

M.diagnostics = {
  error = '',
  warn = '',
  info = '',
  hint = '',
}

return M
