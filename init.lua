require('core.settings')
require('core.mappings')
require('core.auto_commands')
require('bootstrap')
require('plugins_load')

-- temporally map until I setup LSP/formating

vim.keymap.set('n', '<leader>lf', '<cmd>silent !stylua %<cr>')
