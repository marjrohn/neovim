local ai = require('mini.ai')

local opts = { n_lines = 250, custom_textobjects = {} }

-- scope
opts.custom_textobjects.o = ai.gen_spec.treesitter({
  a = { '@block.outer', '@conditional.outer', '@loop.outer' },
  i = { '@block.inner', '@conditional.inner', '@loop.inner' },
})

-- function
opts.custom_textobjects.f = ai.gen_spec.treesitter({
  a = '@function.outer',
  i = '@function.inner',
})

-- class
opts.custom_textobjects.c = ai.gen_spec.treesitter({
  a = '@class.outer',
  i = '@class.inner',
})

-- tags
opts.custom_textobjects.t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }

-- word with case
opts.custom_textobjects.e = {
  { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
  '^().*()$',
}
ai.setup(opts)
