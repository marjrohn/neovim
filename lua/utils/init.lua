local M = {}

M.isin = function(value, list)
  for _, v in ipairs(list) do
    if value == v then
      return true
    end
  end

  return false
end

M.get_mode_for_theme = function()
  local mode = vim.fn.mode()

  if M.isin(mode, { 'i', 'ic', 'ix' }) then
    return 'insert'
  end

  -- '\22' is CTRL-V
  if M.isin(mode, { 'v', 'vs', 'V', 'Vs', '\22', '\22s', 's', 'S', 'CTRL-S' }) then
    return 'visual'
  end

  if M.isin(mode, { 'R', 'Rc', 'Rv', 'Rvc', 'Rvx' }) then
    return 'replace'
  end

  if M.isin(mode, { 'c', 'cr', 'cv', 'cvr' }) then
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

return M
