local opts = {}

opts.menu = {
  width = vim.api.nvim_win_get_width(0) - 4
}

opts.settings = {
  save_on_toggle = true
}

local harpoon = require('harpoon')

harpoon:setup()

local map = function(lhs, rhs, desc)
  vim.keymap.set.('n', lhs, rhs, { desc = desc })
end

map('<leader>a', function() harpon:list():add() end, 'Harpoon File')
map('<leader><leader>', function() harpon.ui:toggle_quick_menu(harpon:list()) end, 'Harpoon Quick Menu')

for i = 1, 9 do
  map('<leader>' .. i, function() harpoon:list():select(i) end, desc = 'Harpon Select File ' .. i)
end
