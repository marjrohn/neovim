local M = {
  vim = '',
  neovim = '',
}

M.clock = ''
M.directory = ''

M.fold = {
  open = '',
  end_ = '╼',
  close = '╴',
  scope = '│ ',
  scopestart = '',
  scopeend = '╴',
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
