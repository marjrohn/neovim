local builtin = require('statuscol.builtin')
local opts = {}

opts.relculright = true
opts.segments = {
  {
    text = {
      function(args)
        local lnum = args.lnum
        local foldlevel = vim.fn.foldlevel(lnum)

        -- stylua: ignore
        local fold_icons = {
          open    = '╭',
          close   = '╴',
          scope   = '│ ',
          divider = '├',
          foldend = '╰╼',
        }

        local result = function()
          if foldlevel == 0 then
            return ''
          end

          if lnum == vim.fn.foldclosed(lnum) then
            return fold_icons.close
          end

          vim.cmd(lnum .. 'foldclose')
          local foldstart = vim.fn.foldclosed(lnum)
          local foldend = vim.fn.foldclosedend(lnum)
          vim.cmd(lnum .. 'foldopen')

          if lnum == foldstart then
            return (foldlevel == 1) and fold_icons.open or fold_icons.divider
          end

          if lnum == foldend then
            return (foldlevel == 1) and fold_icons.foldend or fold_icons.scope
          end

          return fold_icons.scope
        end

        return '%#FoldColumn#' .. result()
      end,
    },
    click = 'v:lua.ScFa',
  },

  {
    sign = {
      name = { 'Diagnostic' },
      colwidth = 1,
      auto = true,
    },
    click = 'v:lua.ScSa',
  },

  {
    sign = {
      name = { '.*' },
      namespace = { '^(?!.*(gitsigns))' }, -- take anything except gitsigns, since it will be added after numbers
      colwidth = 1,
      auto = true,
    },
    click = 'v:lua.ScSa',
  },

  {
    text = { ' ', builtin.lnumfunc, ' ' },
    condition = { true, true, builtin.not_empty },
    click = 'v:lua.ScLa',
  },

  {
    sign = {
      namespace = { 'gitsigns' },
      colwidth = 1,
    },
    click = 'v:lua.ScSa',
  },
}

require('statuscol').setup(opts)
