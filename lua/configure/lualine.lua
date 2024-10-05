local opts = {}
local icons = require('icons')

local section_b_cond = function()
  return vim.o.columns >= 100
end

vim.opt.showmode = false
vim.opt.fillchars = vim.tbl_extend('force', vim.opt.fillchars:get(), {
  stl = '󱘹',
  stlnc = '󱘹',
})

opts.options = {
  theme = vim.g.lualine_theme, -- defined in 'configure/rose_pine.lua'
  globalstatus = vim.o.laststatus == 3,
  component_separators = '',
  section_separators = { left = '', right = '' },
}

opts.sections = { lualine_x = {} }
opts.sections.lualine_a = {
  {
    'mode',
    icon = icons.neovim,
    separator = { left = '', right = '' },
    padding = { left = 1, right = 0 },
  },
}
opts.sections.lualine_b = {
  { 'branch', icon = icons.git.branch, cond = section_b_cond },
  {
    'diff',
    symbols = {
      added = icons.git.diff.added .. ' ',
      modified = icons.git.diff.modified .. ' ',
      removed = icons.git.diff.removed .. ' ',
    },
    padding = { left = 0, right = 1 },
    cond = section_b_cond,
  },
}
opts.sections.lualine_c = {
  { '%=', padding = 0 },
  {
    'datetime',
    style = '%H:%M',
    separator = { left = '', right = '' },
    padding = 0,
    color = function(section)
      local mode = require('utils').get_mode_for_theme()

      return {
        bg = vim.g.lualine_theme[mode].a.bg,
        fg = vim.g.lualine_theme[mode].a.fg,
        gui = 'bold',
      }
    end,
  },
}
opts.sections.lualine_y = {
  {
    'filetype',
    fmt = function(name)
      return string.upper(name)
    end,
    cond = section_b_cond,
  },
  { 'encoding', cond = section_b_cond },
}
opts.sections.lualine_z = {
  {
    'location',
    separator = { left = '', right = '' },
    padding = { left = 0, right = 1 },
  },
}

require('lualine').setup(opts)
