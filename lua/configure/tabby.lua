vim.opt.showtabline = 2 -- always show tabline

local opts = {}

opts.line = function(line)
  local mode = require('utils').get_mode_for_theme()
  local show_name = #line.api.get_tabs() <= math.max(math.floor(vim.o.columns / 25), 3)

  return {
    hl = 'lualine_b_normal',

    { ' 󰓩 ', hl = 'lualine_c_command' },

    line.tabs().foreach(function(tab)
      local is_current = tab.is_current()

      local number = tab.number()
      local name = (is_current or show_name) and tab.name() or ''
      local icon = is_current and '' or ''

      local left_sep = (number == 1) and '' or ''
      local right_sep = (number == #line.api.get_tabs()) and '' or ''

      local hl = is_current and 'lualine_a_' .. mode or 'lualine_a_inactive'
      local hl_sep = 'lualine_c_' .. (is_current and mode or 'inactive')

      return {
        { left_sep, hl = hl_sep },
        icon,
        number,
        name,
        tab.close_btn(''),
        { right_sep, hl = hl_sep },

        margin = ' ',
        hl = hl,
      }
    end),

    line.spacer(),

    -- TODO: change to show diagnostics sign
    { ' :diagnostics: ', hl = 'lualine_a_inactive' },
  }
end

require('tabby').setup(opts)
