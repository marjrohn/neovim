-- [[ Genral Keymappings ]]

local map = function(mode, lhs, rhs, opts)
  opts = opts or {}

  if opts.silent == nil then
    opts.silent = true
  end

  opts.noremap = not opts.remap

  vim.keymap.set(mode, lhs, rhs, opts)
end

if vim.g.mapleader == ' ' then
  map('n', '<space>', '<nop>')
end

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true })
map({ 'n', 'x' }, '<down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true })
map({ 'n', 'x' }, '<up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true })

-- center scrolling
map('n', '<c-u>', '<c-u>zz')
map('n', '<c-d>', '<c-d>zz')

-- move to window using <ctrl> hjkl keys
map('n', '<c-h>', '<c-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<c-j>', '<c-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<c-k>', '<c-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<c-l>', '<c-w>l', { desc = 'Go to Right Window', remap = true })

-- resize window using <ctrl> arrow keys
map('n', '<c-up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<c-down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<c-left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<c-right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- move lines
map('n', '<a-j>', '<cmd>m .+1<cr>==', { desc = 'Move Line Down' })
map('i', '<a-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Line Down' })
map('x', '<a-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Line Down' })

map('n', '<a-k>', '<cmd>m .-2<cr>==', { desc = 'Move Line Up' })
map('i', '<a-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Line Up' })
map('x', '<a-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Line Down' })

-- clear search with <esc>
map({ 'n', 'i' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear Hightlight Search' })

-- Clear search, diff update and redraw
map('n', '<leader>ur', '<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <c-L><cr>', { desc = 'Redraw' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zzzv'", { desc = 'Next Search Result', expr = true })
map('x', 'n', "'Nn'[v:searchforward]", { desc = 'Next Search Result', expr = true })
map('o', 'n', "'Nn'[v:searchforward]", { desc = 'Next Search Result', expr = true })
map('n', 'N', "'nN'[v:searchforward].'zzzv'", { desc = 'Prev Search Result', expr = true })
map('x', 'N', "'nN'[v:searchforward]", { desc = 'Prev Search Result', expr = true })
map('o', 'N', "'nN'[v:searchforward]", { desc = 'Prev Search Result', expr = true })

-- undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')
map('i', ':', ':<c-g>u')
map('i', '/', '/<c-g>u')

-- file saving
map('n', '<c-s>', '<cmd>w<cr>', { desc = 'Save File' })

-- better indenting
map('x', '>', '>gv')
map('x', '<tab>', '>gv')
map('x', '<', '<gv')
map('x', '<s-tab>', '<gv')

-- yank to system clipboard
for _, key in ipairs({ 'y', 'Y' }) do
  map({ 'n', 'x' }, '<leader>' .. key, function()
    local count = vim.v.count == 0 and '' or vim.v.count

    return '"+' .. count .. key
  end, { desc = 'Yank (System Clipboard)', expr = true })
end

-- paste to system clipboard
for _, key in ipairs({ 'p', 'P' }) do
  map('n', '<leader>' .. key, function()
    local count = vim.v.count == 0 and '' or vim.v.count

    return '"+' .. count .. key
  end, { desc = 'Paste (System Clipboard)', expr = true })
end

vim.keymap.set('x', 'p', 'P')
vim.keymap.set('x', 'P', 'p')
vim.keymap.set('x', '<leader>p', function()
  local count = vim.v.count == 0 and '' or vim.v.count

  return '"+' .. count .. 'P'
end, { desc = 'Paste Without Yank (System Clipboard)', expr = true })

vim.keymap.set('x', '<leader>P', function()
  local count = vim.v.count == 0 and '' or vim.v.count

  return '"+' .. count .. 'p'
end, { desc = 'Paste (System Clipboard)', expr = true })

--{{{ don't yank to register if line is blank
map('n', 'yy', function()
  if vim.fn.getline('.') ~= '' then
    local count = vim.v.count <= 1 and '' or vim.v.count
    local reg = vim.v.register

    vim.api.nvim_feedkeys('"' .. reg .. count .. 'yy', 'n', false)
  end
end, { desc = 'Yank Current Line' })

map('n', '<leader>yy', function()
  if vim.fn.getline('.') ~= '' then
    local count = vim.v.count <= 1 and '' or vim.v.count
    local reg = '+'

    vim.api.nvim_feedkeys('"' .. reg .. count .. 'yy', 'n', false)
  end
end, { desc = 'Yank Current Line (System Clipboard)' })

map('n', 'dd', function()
  local count = vim.v.count <= 1 and '' or vim.v.count
  local reg = vim.v.register

  if vim.fn.getline('.'):match('^%s*$') then
    reg = '_'
  end

  vim.api.nvim_feedkeys('"' .. reg .. count .. 'dd', 'n', false)
end, { desc = 'Delete Current Line' })

map('n', 'cc', function()
  local count = vim.v.count <= 1 and '' or vim.v.count
  local reg = vim.v.register

  if vim.fn.getline('.'):match('^%s*$') then
    reg = '_'
  end

  vim.api.nvim_feedkeys('"' .. reg .. count .. 'cc', 'n', false)
end, { desc = 'Change Current Line' })
--}}}

-- don't yank when delete with `x`
map({ 'n', 'x' }, 'x', '"_x')
map({ 'n', 'x' }, 'X', '"_X')
map({ 'n', 'x' }, '<del>', '"_<del>')

-- commenting
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Bellow' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })
map('n', 'gcA', function()
  if vim.fn.getline('.'):match('^%s*$') then
    return 'Vcx<esc><cmd><normal gcc<cr>fxa<bs>'
  end

  return '<cmd>normal gcc^"-dW<cr>A <esc>"-Pa'
end, { desc = 'Add Comment to End', expr = true })

-- quit
map('n', '<leader>q', '<cmd>confirm q<cr>', { desc = 'Quit' })
map('n', '<leader>Q', '<cmd>confirm qall<cr>', { desc = 'Exit Neovim' })

-- quickfix
map('n', ']q', '<cmd>cnext<cr>', { desc = 'Next Quickfix' })
map('n', '[q', '<cmd>cprev<cr>', { desc = 'Previous Quickfix' })
map('n', '[Q', '<cmd>cfirst<cr>', { desc = 'First Quickfix' })
map('n', ']Q', '<cmd>clast<cr>', { desc = 'Last Quickfix' })

-- loclist
map('n', ']l', '<cmd>lnext<cr>', { desc = 'Next Loclist' })
map('n', '[l', '<cmd>lprev<cr>', { desc = 'Previous Loclist' })
map('n', '[L', '<cmd>lfirst<cr>', { desc = 'First Loclist' })
map('n', ']L', '<cmd>llast<cr>', { desc = 'Last Loclist' })

--{{{ diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil

  return function()
    go({ severity = severity })
  end
end

map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Previous Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Diagnostic Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Previous Diagnostic Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Diagnostic Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Previous Diagnostic Warning' })
--}}}

--{{{ buffers
map('n', '<s-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<s-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New Buffer' })
map('n', '<leader>bb', '<cmd>edit #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>bD', '<cmd>:bdelete<cr>', { desc = 'Delete Buffer and Window' })
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
end, { desc = 'Delete Buffer' })
--}}}

-- windows
map('n', '<c-w><tab>', '<c-w>T', { desc = 'Move Windows to a New Tab' })
map('n', '<leader>w', '<c-w>', { desc = 'Windows', remap = true })
map('n', '<leader>\\', '<c-w>s', { desc = 'Split Window Below' })
map('n', '<leader>|', '<c-w>v', { desc = 'Split Window Right' })

--{{{ tabs
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>n', '<cmd>tabnew<cr>', { desc = 'New Tab' })

map('n', '<leader><tab>0', '<cmd>tabfirst<cr>', { desc = 'Go to First Tab' })
map('n', '<leader><tab>$', '<cmd>tablast<cr>', { desc = 'Go to Last Tab' })

map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
map('n', '<leader><tab>l', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>h', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

map('n', '<leader><tab>0', '<cmd>0tabmove<cr>', { desc = 'Move Tab to the First' })
map('n', '<leader><tab>$', '<cmd>$tabmove<cr>', { desc = 'Move Tab to the Last' })

map('n', '<leader><tab>k', '<cmd>+tabmove<cr>', { desc = 'Move Tab to the Right' })
map('n', '<leader><tab>j', '<cmd>-tabmove<cr>', { desc = 'Move Tab to the Left' })

map('n', '<leader><tab>D', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })

for i = 1, 9 do
  map('n', '<leader><tab>' .. i, '<cmd>silent! tabnext ' .. i .. '<cr>', { desc = 'Go to Tab ' .. i })
  map('n', '<a-' .. i .. '>', '<cmd>silent! tabnext ' .. i .. '<cr>', { desc = 'Go to Tab ' .. i })
end
--}}}
