local builtin = require('telescope.builtin')
local map = require('utils').mapping
local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local command = function(name, opts)
  return function()
    builtin[name](opts)
  end
end

--- Options
local opts = { defaults = { layout_config = {} } }

opts.defaults.file_ignore_patterns = { '^%.git[/\\]', '[/\\]%.git[/\\]' }
opts.defaults.path_display = { 'truncate' }
opts.defaults.sorting_strategy = 'ascending'

opts.defaults.layout_config.horizontal = { prompt_position = 'top', preview_width = 0.45 }
opts.defaults.layout_config.vertical = { mirror = false }
opts.defaults.layout_config.width = 0.87
opts.defaults.layout_config.height = 0.80
opts.defaults.layout_config.preview_cutoff = 120
---

--- Setup
require('telescope').setup(opts)

-- extensions
require('telescope').load_extension('fzf')
---

--- Keymaps
-- Find
map('n', '<leader>:', command('command_history'), { desc = 'Command History' })
map('n', '<leader>/', command('search_history'), { desc = 'Search History' })
map('n', '<leader>f<cr>', command('resume'), { desc = 'Resume Last Search' })
map('n', "<leader>f'", command('marks'), { desc = 'Find Marks' })
map('n', '<leader>f/', command('current_buffer_fuzzy_find'), { desc = 'Find Words in Current Buffer' })
map('n', '<leader>fb', command('buffers', { show_all_buffers = false }), { desc = 'Find Buffers' })
map('n', '<leader><leader>', command('buffers', { show_all_buffers = false }), { desc = 'Find Buffers' })
map('n', '<leader>ff', command('find_files'), { desc = 'Find Files' })
map('n', '<leader>fF', command('find_files', { hidden = true, no_ignore = true }), { desc = 'Find All Files' })
map('n', '<leader>fg', command('git_files'), { desc = 'Find Git Files' })
map('n', '<leader>fh', command('help_tags'), { desc = 'Find Help' })
map('n', '<leader>fk', command('keymaps'), { desc = 'Find Keymaps' })
map('n', '<leader>fm', command('man_pages'), { desc = 'Find Man Pages' })
map('n', '<leader>fo', command('oldfiles'), { desc = 'Find Old Files' })
map('n', '<leader>fr', command('registers'), { desc = 'Find Registers' })
map('n', '<leader>fT', command('tags'), { desc = 'Find Tags (cwd)' })
map('n', '<leader>ft', command('current_buffer_tags'), { desc = 'Find Tags' })
map('n', '<leader>fc', command('colorscheme', { enable_preview = true }), { desc = 'Find Colorschemes' })
map('n', '<leader>fl', command('live_grep'), { desc = 'Live Grep' })
map('n', '<leader>fw', command('grep_string'), { desc = 'Find Word Under Cursor' })
map(
  'n',
  '<leader>fL',
  command('live_grep', {
    aditional_args = function(args)
      return vim.list_extend(args, { '--hidden', '--no-ignore' })
    end,
  }),
  { desc = 'Live Grep (All Files)' }
)
map(
  'n',
  '<leader>fW',
  command('grep_string', {
    aditional_args = function(args)
      return vim.list_extend(args, { '--hidden', '--no-ignore' })
    end,
  }),
  { desc = 'Find Word Under Cursor (All Files)' }
)

-- Git
map('n', '<leader>gb', command('git_branches', { use_file_path = true }), { desc = 'Git Branches' })
map('n', '<leader>gc', command('git_commits', { use_file_path = true }), { desc = 'Git Commits (Repository)' })
map('n', '<leader>gC', command('git_bcommits', { use_file_path = true }), { desc = 'Git Commits (Current File)' })
map('n', '<leader>gs', command('git_status', { use_file_path = true }), { desc = 'Git Status' })
---

--- LSP
autocmd('LspAttach', {
  group = augroup('telescope_lsp'),
  callback = function(event)
    -- Jump to the definition of the word under your cursor.
    map('n', '<leader>ld', command('lsp_definitions'), { desc = 'Goto To Definition', buffer = event.buf })

    -- Find references for the word under your cursor.
    map('n', '<leader>lr', command('lsp_references'), { desc = 'Goto References', buffer = event.buf })

    -- Jump to the implementation of the word under your cursor.
    map('n', '<leader>li', command('lsp_implementations'), { desc = 'Goto Implementation', buffer = event.buf })

    -- Jump to the type of the word under your cursor.
    map('n', '<leader>ltd', command('lsp_type_definitions'), { desc = 'Type Definition', buffer = event.buf })

    -- Fuzzy find all the symbols in your current document.
    map('n', '<leader>ls', command('lsp_document_symbols'), { desc = 'Document Symbols', buffer = event.buf })

    -- Fuzzy find all the symbols in your current workspace.
    map('n', '<leader>lw', command('lsp_dynamic_workspace_symbols'), { desc = 'Workspace Symbols', buffer = event.buf })
  end,
})

map('n', '<leader>lD', command('diagnostics'), { desc = 'Find Diagnostics' })
---
