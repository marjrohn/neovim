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
  inactive = palette.surface,
}

local background = 'none'
local fg_text = palette.text
local fg_base = palette.base
local fg_muted = palette.muted

local theme = {}
for mode, color in pairs(modes) do
  local is_inactive = (mode == 'inactive')
  local fg_a = is_inactive and fg_muted or fg_base
  local fg_b = is_inactive and fg_muted or fg_text

  theme[mode] = {
    a = { bg = color, fg = fg_a, gui = 'bold' },
    b = { bg = background, fg = fg_b },
    c = { bg = background, fg = color, gui = 'bold' },
  }
end

vim.g.lualine_theme = theme
