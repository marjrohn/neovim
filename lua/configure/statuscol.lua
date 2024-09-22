local builtin = require('statuscol.builtin')
local opts = {}

opts.relculright = true
opts.segments = {
  {
    text = { builtin.foldfunc, ' ' },
    sign = {
      foldclosed = true,
      colwidth = 1,
      auto = true,
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
      colwidth = 2,
      auto = true,
    },
    click = 'v:lua.ScSa',
  },

  {
    text = { builtin.lnumfunc, ' ' },
    condition = { true, builtin.not_empty },
    click = 'v:lua.ScLa',
  },

  {
    sign = {
      namespace = { 'gitsigns' },
      colwidth = 1,
      auto = true,
    },
    click = 'v:lua.ScSa',
  },
}

require('statuscol').setup(opts)
