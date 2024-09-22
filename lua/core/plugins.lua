return {
  { -- colorscheme
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
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
        version = false,
        build = ':TSUpdate',
        config = function()
          require('configure.treesitter')
        end,
      },
    },
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
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lualine/lualine.nvim' },
    config = function()
      require('configure.tabby')
    end,
  },

  { -- signcolumn customization
    'luukvbaal/statuscol.nvim',
    event = 'UiEnter',
    config = function()
      require('configure.statuscol')
    end,
  },

  -- buffers
  { 'tiagovla/scope.nvim', config = true },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = 'VeryLazy',
    dependencies = { "nvim-lua/plenary.nvim" }
    config = function()
      require'configure.harpoon'
    end
  },

  -- show marks in sign column
  { 'chentoast/marks.nvim', event = 'VeryLazy', config = true },

  --- mini library
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

  -- auto highlight word under cursor
  { 'echasnovski/mini.cursorword', event = 'VeryLazy', config = true },

  -- indent current scope with animation
  {
    'echasnovski/mini.indentscope',
    event = 'VeryLazy',
    config = function()
      require('configure.mini.indentscope')
    end,
  },
  {
    'echasnovski/mini.files',
    event = 'VeryLazy',
    config = function()
      require('configure.mini.files')
    end,
  },

  -- auto pairs certain characteres
  { 'echasnovski/mini.pairs', event = 'VeryLazy', config = true },

  -- split/join arguments under cursor
  { 'echasnovski/mini.splitjoin', event = 'VeryLazy', config = true },

  -- surrounding manipulation
  { 'echasnovski/mini.surround', event = 'VeryLazy', config = true },
  ---

  --- git
  { -- show git diff in signcolumn
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
      require('configure.gitsigns')
    end,
  },
  ---
}
