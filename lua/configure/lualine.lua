local opts = {}
local icons = require('icons')

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
    padding = 0,
    separator = { left = '', right = '' },
  },
}
opts.sections.lualine_b = {
  { 'branch', icon = icons.git.branch },
  {
    'diff',
    symbols = {
      added = icons.git.diff.added .. ' ',
      modified = icons.git.diff.modified .. ' ',
      removed = icons.git.diff.removed .. ' ',
    },
    padding = { left = 0, right = 1 },
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
      local mode = vim.fn.mode()
      local bg = vim.g.lualine_theme.normal.a.bg
      local fg = vim.g.lualine_theme.normal.a.fg

      for _, m in ipairs({ 'i', 'ic', 'ix' }) do
        if mode == m then
          bg = vim.g.lualine_theme.insert.a.bg
          break
        end
      end

      -- \22 is CTRL-V
      for _, m in ipairs({ 'v', 'vs', 'V', 'Vs', '\22', '\22s', 's', 'S', 'CTRL-S' }) do
        if mode == m then
          bg = vim.g.lualine_theme.visual.a.bg
          break
        end
      end

      for _, m in ipairs({ 'R', 'Rc', 'Rv', 'Rvc', 'Rvx' }) do
        if mode == m then
          bg = vim.g.lualine_theme.replace.a.bg
          break
        end
      end

      for _, m in ipairs({ 'c', 'cr', 'cv', 'cvr' }) do
        if mode == m then
          bg = vim.g.lualine_theme.command.a.bg
          break
        end
      end

      return { fg = fg, bg = bg }
    end,
  },
}
opts.sections.lualine_y = {
  'diagnostics',
  {
    'filetype',
    fmt = function(name)
      return string.upper(name)
    end,
  },
  'encoding',
}
opts.sections.lualine_z = {
  {
    'location',
    separator = { left = '', right = '' },
    padding = { left = 0, right = 1 },
  },
}

require('lualine').setup(opts)
