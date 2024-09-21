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

return M
