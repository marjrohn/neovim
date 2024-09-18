local lazy = require('lazy')

lazy.setup({
  -- load plugins
  spec = require('core.plugins'),
  defaults = { lazy = false, version = false },
  install = {
    -- colorscheme used when installed plugins
    colorscheme = { vim.g.default_coloscheme, 'sorbet' },
  },
  -- automatically check for plugins update
  checker = {
    enabled = true,
    notify = true,
    concurrenty = 1, -- check for update slowly
    frequency = 6 * 3600, -- check for update every six hours
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'zipPlugin',
      },
    },
  },
})
