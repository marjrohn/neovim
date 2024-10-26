return {
  -- show marks in signcolumn
  { 'chentoast/marks.nvim', event = 'VeryLazy', config = true },

  { -- better text-objects
    'echasnovski/mini.ai',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require('configure.mini_ai')
    end,
  },

  -- text alignment
  { 'echasnovski/mini.align', event = 'VeryLazy', config = true },

  --  highlight word under cursor
  { 'echasnovski/mini.cursorword' },

  { 'echasnovski/mini.extra' },

  -- split/join arguments under cursor
  { 'echasnovski/mini.splitjoin', event = 'VeryLazy', config = true },

  -- surrounding
  { 'echasnovski/mini.surround', event = 'VeryLazy', config = true },

  { -- show git diff in signcolumn
    'lewis6991/gitsigns.nvim',
    config = function()
      require('configure.gitsigns')
    end,
  },

  { -- signcolumn
    'luukvbaal/statuscol.nvim',
    config = function()
      require('configure.statuscol')
    end,
  },

  { -- tabline
    'nanozuki/tabby.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lualine/lualine.nvim',
    },
    config = function()
      require('configure.tabby')
    end,
  },

  -- highlight color
  { 'NvChad/nvim-colorizer.lua', event = 'VeryLazy', config = true },

  { -- statusline
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('configure.lualine')
    end,
  },

  { -- fizzy finder
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = 'Telescope',
    config = function()
      require('configure.telescope')
    end,
  },

  { -- treesitter configuration
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
          require('configure.treesitter')
        end,
      },
    },
  },

  { -- notifications
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
      require('configure.notify')
    end,
  },

  { -- colorscheme
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('configure.rose_pine')
    end,
  },

  { -- file explorer
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('configure.oil')
    end,
  },

  { -- session management
    'stevearc/resession.nvim',
    dependencies = 'tiagovla/scope.nvim',
    config = function()
      require('configure.resession')
    end,
  },

  -- scoped tabs
  { 'tiagovla/scope.nvim', config = true },

  -- auto pairs
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
}
