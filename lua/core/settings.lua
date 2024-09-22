-- [[ General Settings ]]

local g = vim.g
local opt = vim.opt

-- colorscheme (builtin)
g.default_colorscheme = 'sorbet'

-- set leader to space key
g.mapleader = ' '
g.localmapleader = ','

-- silent providers warning when running ':checkhealth'
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- fix markdown indentation settings and enable folding
g.markdown_folding = 1
g.markdown_recommended_style = 0

-- enable auto save
opt.autowriteall = true

-- don't stop backspece at insert
opt.backspace:append({ 'nostop' })

-- wrap indent
opt.breakindent = true

-- sync system clipboard to '*' and '+' registers
opt.clipboard = 'unnamedplus'

-- insert mode completion options
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- copy the previous indentation on autoindenting
opt.copyindent = true

-- hightlight current line
opt.cursorline = true

-- use space insted of tabs
opt.expandtab = true

-- remove '~' char for empty lines and change fold chars
opt.fillchars:append({
  foldopen = '',
  foldclose = '',
  foldsep = '',
  eob = ' ',
})

-- folding
opt.foldenable = true
opt.foldmethod = 'indent'
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99

-- preview substituition live as you type
opt.inccommand = 'split'

-- case insentive search
opt.infercase = true
opt.ignorecase = true

-- make the jumplist behavior more intuitive
opt.jumpoptions = { 'view' }

-- make statusline global
opt.laststatus = 3

-- wrap lines at covenients points
opt.linebreak = true

-- enable mouse support for all modes
opt.mouse = 'a'

-- show line numbers
opt.number = true

-- preserve indent structure as much as possible
opt.preserveindent = true

-- make line numbers relative to current line
opt.relativenumber = true

-- minimal numbers of line to keep above (below) the cursor
opt.scrolloff = 4

-- round indentation with '>' ('<') to shiftwidth
opt.shiftround = true

-- use the same value of 'tabstop' as indentation size
opt.shiftwidth = 0

-- disable some startup messages
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- same as 'scrolloff' but horizontally
opt.sidescrolloff = 8

-- always show signcolumn, otherwise it would shift the text each time
opt.signcolumn = 'yes'

-- make search case-sensitive if pattern contain upper case letters
opt.smartcase = true

-- insert indents automatically
opt.smartindent = true

opt.smoothscroll = true

-- set langueges for spell check
opt.spelllang = { 'en_us', 'pt_br' }
opt.spelloptions = { 'camel' }

-- window split behavior
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true

-- disable swap file
opt.swapfile = false

-- number of space that <tab> count
opt.tabstop = 2

-- enable true color support
opt.termguicolors = true

-- column width
vim.opt.textwidth = 120

-- set terminal title to show filaname and path
opt.title = true

-- automatically saves undo history to a file
opt.undofile = true
opt.undolevels = 5000

-- save content to swap files after 0.4 seconds without typing
opt.updatetime = 400

-- allow cursor to move there is no text in visual block mode
opt.virtualedit = 'block'

-- completion mode
opt.wildmode = { 'longest:full', 'full' }

-- minimum window width
opt.winminwidth = 8

-- don't wrap line
opt.wrap = false

-- don't backup file before saving
opt.writebackup = false
