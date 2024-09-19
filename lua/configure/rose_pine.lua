local opts = {}

require('rose-pine').setup(opts)

vim.cmd.colorscheme('rose-pine-main')

-- custom lualine theme
local palette = require('rose-pine.palette')

local modes = {
  normal = palette.rose,
  insert = palette.foam,
  visual = palette.iris,
  replace = palette.pine,
  command = palette.love,
  inactive = palette.base,
}

local theme = {}

for mode, color in pairs(modes) do
  theme[mode] = {
    a = { bg = color, fg = palette.base, gui = 'bold' },
    b = { bg = 'none', fg = palette.text },
    c = { bg = 'none', fg = color, gui = 'bold' },
  }
end

theme.inactive = {
  a = { bg = palette.base, fg = palette.muted, gui = 'bold' },
  a = { bg = 'none', fg = palette.muted },
  a = { bg = 'none', fg = palette.base, gui = 'bold' },
}

vim.g.lualine_theme = theme
