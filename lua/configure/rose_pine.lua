local opts = {}

require('rose-pine').setup(opts)

vim.cmd.colorscheme('rose-pine-main')

-- custom lualine theme
local palette = require('rose-pine.palette')

local modes = {
  normal = palette.iris,
  insert = palette.foam,
  visual = palette.rose,
  replace = palette.pine,
  command = palette.love,
  inactive = palette.overlay,
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
  local gui = (not is_inactive) and 'bold'

  theme[mode] = {
    a = { bg = color, fg = fg_a, gui = gui },
    b = { bg = background, fg = fg_b },
    c = { bg = background, fg = color, gui = gui },
  }
end

vim.g.lualine_theme = theme

vim.cmd.highlight('Identifier guifg=' .. palette.love)
vim.cmd.highlight('CursorLineNr guifg=' .. palette.gold)
vim.cmd.highlight('FoldedSuffix guifg=' .. palette.love)
vim.cmd.highlight('FoldColumnScope cterm=bold gui=bold guifg=' .. palette.rose)
