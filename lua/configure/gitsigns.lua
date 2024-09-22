local opts = {}

opts.signs = {
  add = { text = '▎' },
  change = { text = '▎' },
  delete = { text = '' },
  topdelete = { text = '' },
  changedelete = { text = '▎' },
  untracked = { text = '▎' },
}

opts.signs_staged = {
  add = { text = '▎' },
  change = { text = '▎' },
  delete = { text = '' },
  topdelete = { text = '' },
  changedelete = { text = '▎' },
}

opts.on_attach = function(buffer)
  local gs = require('gitsigns')

  local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
  end

  map('n', ']h', function()
    if vim.wo.diff then
      vim.cmd.normal({ ']c', bang = true })
    else
      gs.nav_hunk('next')
    end
  end, 'Next Hunk')

  map('n', '[h', function()
    if vim.wo.diff then
      vim.cmd.normal({ '[c', bang = true })
    else
      gs.nav_hunk('prev')
    end
  end, 'Prev Hunk')

  -- stylua: ignore start
  map('n', ']H', function() gs.nav_hunk('last') end, 'Last Hunk')
  map('n', '[H', function() gs.nav_hunk('first') end, 'First Hunk')
  map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
  map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
  map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
  map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo Stage Hunk')
  map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
  map('n', '<leader>hp', gs.preview_hunk_inline, 'Preview Hunk Inline')
  map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame Line')
  map('n', '<leader>hB', function() gs.blame() end, 'Blame Buffer')
  map('n', '<leader>ghd', gs.diffthis, 'Diff This')
  map('n', '<leader>hD', function() gs.diffthis('~') end, 'Diff This ~')
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
  -- stylua: ignore end
end

require('gitsigns').setup(opts)