for _, name in ipairs({ 'settings', 'mappings', 'auto_commands' }) do
  local module = 'core.' .. name
  require(module)
end

vim.cmd.colorscheme(vim.g.default_colorscheme)

require('bootstrap')
require('plugins_load')
