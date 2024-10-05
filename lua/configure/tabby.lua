vim.opt.showtabline = 2 -- always show tabline

local opts = {}

local left_sep = ''
local right_sep = ''

local tab_sep_fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
local tab_sep_bg = vim.api.nvim_get_hl(0, { name = 'lualine_c_inactive' }).fg
local head_fg = vim.api.nvim_get_hl(0, { name = 'lualine_c_command' }).fg

vim.api.nvim_set_hl(0, 'tabby_tab_sep', { bg = tab_sep_bg, fg = tab_sep_fg })
vim.api.nvim_set_hl(0, 'tabby_tab_head', { bg = tab_sep_bg, fg = head_fg })

local sep_hl_inv = 'tabby_tab_sep'

opts.line = function(line)
  local mode = require('utils').get_mode_for_theme()
  local curr_tabnr = vim.fn.tabpagenr()
  local last_tabnr = vim.fn.tabpagenr('$')

  -- don't show name of non current tab if the terminal was small width
  local show_name = last_tabnr <= math.floor(vim.o.columns / 24 + 0.5)

  return {
    hl = 'lualine_b_normal',

    { ' 󰓩 ', hl = 'tabby_tab_head' },

    line.tabs().foreach(function(tab)
      local tabnr = tab.number()
      local is_current = tab.is_current()
      local is_first_tab = tabnr == 1
      local is_last_tab = tabnr == last_tabnr
      local is_before = (tabnr <= curr_tabnr)
      local is_after = (tabnr >= curr_tabnr)

      local name = (is_current or show_name) and tab.name() .. ' ' or ''
      local icon = is_current and '' or ''

      local hl = is_current and 'lualine_a_' .. mode or 'lualine_a_inactive'
      local sep_hl = 'lualine_c_' .. (is_current and mode or 'inactive')

      return {
        hl = hl,

        is_before and { left_sep, hl = sep_hl_inv },
        is_before and { left_sep, hl = sep_hl },
        is_after and not is_current and ' ',
        icon .. ' ',
        tabnr .. ': ',
        name,
        tab.close_btn(''),
        is_before and not is_current and ' ',
        is_after and { right_sep, hl = sep_hl },
        (not is_last_tab) and is_after and { right_sep, hl = sep_hl_inv },
      }
    end),

    line.spacer(),

    -- TODO: change this to show diagnostics sign
    { ' :diagnostics: ', hl = 'lualine_a_inactive' },
  }
end

require('tabby').setup(opts)
