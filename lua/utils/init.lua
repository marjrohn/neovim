local M = {}

M.get_mode_for_theme = function()
  local mode = vim.fn.mode()

  if vim.list_contains({ 'i', 'ic', 'ix' }, mode) then
    return 'insert'
  end

  -- '\22' is CTRL-V
  if vim.list_contains({ 'v', 'vs', 'V', 'Vs', '\22', '\22s', 's', 'S', 'CTRL-S' }, mode) then
    return 'visual'
  end

  if vim.list_contains({ 'R', 'Rc', 'Rv', 'Rvc', 'Rvx' }, mode) then
    return 'replace'
  end

  if vim.list_contains({ 'c', 'cr', 'cv', 'cvr' }, mode) then
    return 'command'
  end

  return 'normal'
end

M.mapping = function(mode, lhs, rhs, opts)
  opts = opts or {}

  if opts.silent == nil then
    opts.silent = true
  end

  if opts.noremap == nil then
    opts.noremap = true
  end

  if opts.remap then
    opts.noremap = false
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

M.buf_list = function()
  return vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
  end, vim.api.nvim_list_bufs())
end

M.buf_remove = function(buf)
  local buflist = M.buf_list()
  local current_buf = vim.api.nvim_win_get_buf(0)

  if buf == nil or buf == 0 then
    buf = current_buf
  elseif not vim.api.nvim_buf_is_valid(buf) then
    return false
  end

  if not vim.list_contains(buflist, buf) then
    return false
  end

  if #buflist == 1 and vim.api.nvim_buf_get_name(buf) == '' then
    return false
  end

  if buf ~= current_buf then
    vim.api.nvim_buf_delete(buf)
    return true
  end

  if #buflist == 1 then
    vim.cmd('enew')
  elseif buf == buflist[1] then
    vim.cmd('bnext')
  else
    vim.cmd('bprevious')
  end

  vim.api.nvim_buf_delete(buf, {})
  return true
end

return M
