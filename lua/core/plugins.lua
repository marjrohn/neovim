return {
  -- `vim.uv` typings
  { 'Bilal2453/luvit-meta', lazy = true },

  -- show marks in signcolumn
  { 'chentoast/marks.nvim', config = true },

  { -- better text-objects
    'echasnovski/mini.ai',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require('configure.mini_ai')
    end,
  },

  -- text alignment
  { 'echasnovski/mini.align', config = true },

  { 'echasnovski/mini.extra' },

  -- split/join arguments under cursor
  { 'echasnovski/mini.splitjoin', config = true },

  -- surrounding
  { 'echasnovski/mini.surround', config = true },

  { -- luaLS configuration
    'folke/lazydev.nvim',
    ft = 'lua',
    config = function()
      require('lazydev').setup({ library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } } })
    end,
  },

  { -- folding
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require('configure.ufo')
    end,
  },

  { -- show git diff in the gutter
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

  { -- LSP
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'saghen/blink.cmp' },
      { 'j-hui/fidget.nvim', config = true },
    },
    config = function()
      require('configure.lsp')
    end,
  },

  -- highlight color
  { 'NvChad/nvim-colorizer.lua', config = true },

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

  { -- completion
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    build = 'cargo build --release',
    config = function()
      require('configure.blink')
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
