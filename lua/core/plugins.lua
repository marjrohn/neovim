return {
  -- colorscheme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('configure.rose_pine')
    end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    config = function()
      require('configure.treesitter')
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  
  -- lualine
  { 
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'UiEnter',
    config = function()
      require('configure.lualine')
    end,
  },
}
