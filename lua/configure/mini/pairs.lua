local opts = {}

opts.modes = {
  insert = true,
  command = true,
  terminal = false,
}

-- skip autopair when next character is one of these
opts.skip_next = [=[[%w%%%'%[%"%.%`%$]]=]

-- skip autopair when the cursor is inside these treesitter nodes
opts.skip_ts = { 'string' }

-- skip autopair when next character is closing pair
-- and there are more closing pairs than opening pairs
opts.skip_unbalanced = true
