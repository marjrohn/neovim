-- [[ Genral Keymappings ]]

local map = vim.keymap.set

if vim.g.mapleader == ' ' then
  map('n', '<space>', '<nop>')
end

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- move to window using <ctrl> hjkl keys
map('n', '<c-h>', '<c-w>h', { desc = 'Go to Left Window', remap = true, silent = true })
map('n', '<c-j>', '<c-w>j', { desc = 'Go to Lower Window', remap = true, silent = true })
map('n', '<c-k>', '<c-w>k', { desc = 'Go to Upper Window', remap = true, silent = true })
map('n', '<c-l>', '<c-w>l', { desc = 'Go to Right Window', remap = true, silent = true })

-- resize window using <ctrl> arrow keys
map('n', '<c-up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height', silent = true })
map('n', '<c-down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height', silent = true })
map('n', '<c-left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width', silent = true })
map('n', '<c-right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width', silent = true })

-- move lines
map('n', '<a-j>', '<cmd>m .+1<cr>==', { desc = 'Move Line Down', silent = true })
map('i', '<a-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Line Down', silent = true })
map('v', '<a-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Line Down', silent = true })

map('n', '<a-k>', '<cmd>m .-2<cr>==', { desc = 'Move Line Up', silent = true })
map('i', '<a-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Line Up', silent = true })
map('v', '<a-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Line Down', silent = true })

-- clear search with <esc>
map({ 'n', 'i' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear Hightlight Search', silent = true })

-- Clear search, diff update and redraw
map('n', '<leader>ur', '<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <c-L><cr>', { desc = 'Redraw', silent = true })

-- disable annoying 'q:' command
map('n', 'q:', '<nop')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { desc = 'Next Search Result', expr = true, silent = true })
map('x', 'n', "'Nn'[v:searchforward]", { desc = 'Next Search Result', expr = true, silent = true })
map('o', 'n', "'Nn'[v:searchforward]", { desc = 'Next Search Result', expr = true, silent = true })
map('n', 'N', "'nN'[v:searchforward].'zv'", { desc = 'Prev Search Result', expr = true, silent = true })
map('x', 'N', "'nN'[v:searchforward]", { desc = 'Prev Search Result', expr = true, silent = true })
map('o', 'N', "'nN'[v:searchforward]", { desc = 'Prev Search Result', expr = true, silent = true })

-- undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')
map('i', ':', ':<c-g>u')
map('i', '/', '/<c-g>u')

-- file saving
map({ 'n', 'i', 'x', 's' }, '<c-s>', '<cmd>w<cr><esc>', { desc = 'Save File', silent = true })

-- new file
map('n', '<leader>n', '<cmd>enew<cr>', { desc = 'New File' })

-- better indenting
map('v', '>', '>gv')
map('v', '<tab>', '>gv')
map('v', '<', '<gv')
map('v', '<s-tab>', '<gv')

--{{{ yank
-- yank to system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank (System Clipboard)', silent = true })
map({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Delete (System Clipboard)', silent = true })
map({ 'n', 'v' }, '<leader>c', '"+c', { desc = 'Change (System Clipboard)', silent = true })

-- paste to system clipboard
map({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste After Cursor (System Clipboard)', silent = true })
map({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste Before Cursor (System Clipboard)', silent = true })

--{{{ don't yank if line is blank
map('n', 'yy', function()
  if vim.fn.getline('.') ~= '' then
    vim.cmd([[normal! yy]])
  end
end, { desc = 'Yank Current Line', silent = true })

map('n', '<leader>yy', function()
  if vim.fn.getline('.') ~= '' then
    vim.api.nvim_feedkeys('"+yy', 'n', false)
  end
end, {
  desc = 'Yank Current Line (System Clipboard)',
  silent = true,
})

map('n', 'dd', function()
  if vim.fn.getline('.'):match('^%s*$') then
    vim.api.nvim_feedkeys('"_dd', 'n', false)
  else
    vim.cmd([[normal! dd]])
  end
end, { desc = 'Delete Current Line', silent = true })

map('n', '<leader>dd', function()
  if vim.fn.getline('.'):match('^%s*$') then
    vim.api.nvim_feedkeys('"_dd', 'n', false)
  else
    vim.api.nvim_feedkeys('"+dd', 'n', false)
  end
end, {
  desc = 'Delete Current Line (System Clipboard)',
  silent = true,
})

map('n', 'cc', function()
  if vim.fn.getline('.'):match('^%s*$') then
    vim.api.nvim_feedkeys('"_cc', 'n', false)
  else
    vim.cmd([[normal! cc]])
  end
end, { desc = 'Change Current Line', silent = true })

map('n', '<leader>cc', function()
  if vim.fn.getline('.'):match('^%s*$') then
    vim.api.nvim_feedkeys('"_cc', 'n', false)
  else
    vim.api.nvim_feedkeys('"+cc', 'n', false)
  end
end, {
  desc = 'Change Current Line (System Clipboard)',
  silent = true,
})
--}}}

-- don't yank when delete with 'x'
map({ 'n', 'v' }, 'x', '"_x')
map({ 'n', 'v' }, 'X', '"_X')
map({ 'n', 'v' }, '<del>', '"_<del>')
--}}}

-- comment
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Bellow', silent = true })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above', silent = true })
map('n', 'gcA', '<cmd>normal gcc^"0dW<cr>A <esc>"0pA', { desc = 'Add Comment to End', silent = true })

-- quit
map('n', '<leader>q', '<cmd>confirm q<cr>', { desc = 'Quit', silent = true })
map('n', '<leader>Q', '<cmd>confirm qall<cr>', { desc = 'Exit Neovim', silent = true })

-- quickfix
map('n', ']q', '<cmd>cnext<cr>', { desc = 'Next Quickfix', silent = true })
map('n', '[q', '<cmd>cprev<cr>', { desc = 'Previous Quickfix', silent = true })
map('n', '[Q', '<cmd>cfirst<cr>', { desc = 'First Quickfix', silent = true })
map('n', ']Q', '<cmd>clast<cr>', { desc = 'Last Quickfix', silent = true })

-- loclist
map('n', ']l', '<cmd>lnext<cr>', { desc = 'Next Loclist', silent = true })
map('n', '[l', '<cmd>lprev<cr>', { desc = 'Previous Loclist', silent = true })
map('n', '[L', '<cmd>lfirst<cr>', { desc = 'First Loclist', silent = true })
map('n', ']L', '<cmd>llast<cr>', { desc = 'Last Loclist', silent = true })

--{{{ diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil

  return function()
    go({ severity = severity })
  end
end

map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic', silent = true })
map('n', '[d', diagnostic_goto(false), { desc = 'Previous Diagnostic', silent = true })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Diagnostic Error', silent = true })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Previous Diagnostic Error', silent = true })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Diagnostic Warning', silent = true })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Previous Diagnostic Warning', silent = true })
--}}}

--{{{ buffers
map('n', '<s-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer', silent = true })
map('n', '<s-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer', silent = true })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer', silent = true })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer', silent = true })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer', silent = true })
map('n', '<leader>bD', '<cmd>:bdelete<cr>', { desc = 'Delete Buffer and Window', silent = true })
map('n', '<leader>bd', function()
  if
    #vim
      .iter(vim.api.nvim_list_bufs())
      :filter(function(buf)
        return vim.fn.buflisted(buf) == 1
      end)
      :totable() == 1
  then
    if vim.fn.bufname() ~= '' then
      vim.cmd([[enew]])
      vim.cmd([[confirm bdelete #]])
    end
  else
    vim.cmd([[bprevious]])
    vim.cmd([[confirm bdelete #]])
  end
end, { desc = 'Delete Buffer', silent = true })
--}}}

-- windows
map('n', '<c-w><tab>', '<c-w>T', { desc = 'Move Windows to a New Tab', silent = true })
map('n', '<leader>w', '<c-w>', { desc = 'Windows', remap = true, silent = true })
map('n', '<leader>\\', '<c-w>s', { desc = 'Split Window Below', silent = true })
map('n', '<leader>|', '<c-w>v', { desc = 'Split Window Right', silent = true })

--{{{ tabs
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab', silent = true })
map('n', '<leader><tab>n', '<cmd>tabnew<cr>', { desc = 'New Tab', silent = true })

map('n', '<leader><tab>0', '<cmd>tabfirst<cr>', { desc = 'Go to First Tab', silent = true })
map('n', '<leader><tab>$', '<cmd>tablast<cr>', { desc = 'Go to Last Tab', silent = true })

map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab', silent = true })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab', silent = true })
map('n', '<leader><tab>l', '<cmd>tabnext<cr>', { desc = 'Next Tab', silent = true })
map('n', '<leader><tab>h', '<cmd>tabprevious<cr>', { desc = 'Previous Tab', silent = true })

map('n', '<leader><tab>0', '<cmd>0tabmove<cr>', { desc = 'Move Tab to the First', silent = true })
map('n', '<leader><tab>$', '<cmd>$tabmove<cr>', { desc = 'Move Tab to the Last', silent = true })

map('n', '<leader><tab>k', '<cmd>+tabmove<cr>', { desc = 'Move Tab to the Right', silent = true })
map('n', '<leader><tab>j', '<cmd>-tabmove<cr>', { desc = 'Move Tab to the Left', silent = true })

map('n', '<leader><tab>D', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs', silent = true })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab', silent = true })

for i = 1, 9 do
  map('n', '<leader><tab>' .. i, '<cmd>silent! tabnext ' .. i .. '<cr>', { desc = 'Go to Tab ' .. i, silent = true })
  map('n', '<a-' .. i .. '>', '<cmd>silent! tabnext ' .. i .. '<cr>', { desc = 'Go to Tab ' .. i, silent = true })
end
--}}}
