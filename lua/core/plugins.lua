return {
  { -- LSP config for lua
    'folke/lazydev.nvim',
    ft = 'lua',
    config = function()
      require('configure.lazydev')
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

  { -- treesitter
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

  { -- telescope
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

  { -- statusline
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'UiEnter',
    config = function()
      require('configure.lualine')
    end,
  },

  -- winbar
  { 'Bekaboo/dropbar.nvim', dependencies = 'nvim-tree/nvim-web-devicons', event = 'UiEnter', config = true },

  { -- tabline
    'nanozuki/tabby.nvim',
    event = 'UiEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lualine/lualine.nvim',
      'tiagovla/scope.nvim',
    },
    config = function()
      require('configure.tabby')
    end,
  },

  { -- signcolumn
    'luukvbaal/statuscol.nvim',
    event = 'UiEnter',
    config = function()
      require('configure.statuscol')
    end,
  },

  -- show marks in signcolumn
  { 'chentoast/marks.nvim', event = 'VeryLazy', config = true },

  --[[ mini library ]]
  { -- better text-objects
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require('configure.mini.ai')
    end,
  },

  -- text alignment
  { 'echasnovski/mini.align', event = 'VeryLazy', config = true },

  --  highlight word under cursor
  { 'echasnovski/mini.cursorword', event = 'VeryLazy', config = true },

  { -- file management
    'echasnovski/mini.files',
    event = 'VeryLazy',
    config = function()
      require('configure.mini.files')
    end,
  },

  { -- auto pairs
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    config = function()
      require('configure.mini.pairs')
    end,
  },

  -- split/join arguments under cursor
  { 'echasnovski/mini.splitjoin', event = 'VeryLazy', config = true },

  -- surrounding
  { 'echasnovski/mini.surround', event = 'VeryLazy', config = true },
  --]]

  --[[ git ]]
  { -- show git diff in signcolumn
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
      require('configure.gitsigns')
    end,
  },
  --]]
}
