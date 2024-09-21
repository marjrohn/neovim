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
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    config = function()
      require('configure.treesitter')
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = 'nvim-treesitter/nvim-treesitter' },

  -- raibow parentheses
  { 'HiPhish/rainbow-delimiters.nvim', depedencies = 'nvim-treesitter/nvim-treesitter' },

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

  -- buffers per tab
  { "tiagovla/scope.nvim", config = true },

  -- show marks in sign column
  { "chentoast/marks.nvim", event = "VeryLazy", config = true },
}
