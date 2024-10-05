local M = {
  vim = '',
  neovim = '',
}

M.fold = {
  open    = '╭',
  close   = '╴',
  scope   = '│ ',
  divider = '├',
  foldend = '╰╼',
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
