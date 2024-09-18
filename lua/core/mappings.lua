-- [[ Genral Keymappings ]]

local map = vim.keymap.set

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

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
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Line Down' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Line Down' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Line Down' })

map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Line Up' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Line Up' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Line Down' })

-- clear search with <esc>
map({ 'n', 'i' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear Hightlight Search' })

-- Clear search, diff update and redraw
map('n', '<leader>ur', '<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <c-L><cr>', { desc = 'Redraw' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { desc = 'Next Search Result', expr = true })
map('x', 'n', "'Nn'[v:searchforward]", { desc = 'Next Search Result', expr = true })
map('o', 'n', "'Nn'[v:searchforward]", { desc = 'Next Search Result', expr = true })
map('n', 'N', "'nN'[v:searchforward].'zv'", { desc = 'Prev Search Result', expr = true })
map('x', 'N', "'nN'[v:searchforward]", { desc = 'Prev Search Result', expr = true })
map('o', 'N', "'nN'[v:searchforward]", { desc = 'Prev Search Result', expr = true })

-- undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')
map('i', ':', ':<c-g>u')
map('i', '/', '/<c-g>u')

-- file saving
map({ 'n', 'i', 'x', 's' }, '<c-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
map({ 'n', 'i', 'x', 's' }, '<leader>s', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- new file
map('n', '<leader>n', '<cmd>enew<cr>', { desc = 'New File' })

-- better indenting
map('v', '>', '>gv')
map('v', '<tab>', '>gv')
map('v', '<', '<gv')
map('v', '<s-tab>', '<gv')

-- comment
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Bellow' })
map('n', 'gcO', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

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

-- diagnostics
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

-- buffers
map('n', '<s-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<s-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>bd', '<cmd>Bclose<cr>', { desc = 'Delete Buffer' })
map('n', '<leader>c', '<cmd>Bclose<cr>', { desc = 'Delete Buffer' })
map('n', '<leader>bD', '<cmd>:bdelete<cr>', { desc = 'Delete Buffer and Window' })

-- windows
map('n', '<leader>w', '<c-w>', { desc = 'Windows', remap = true })
map('n', '\\', '<c-w>s', { desc = 'Split Window Below' })
map('n', '|', '<c-w>v', { desc = 'Split Window Right' })
map('n', '<leader>wd', '<c-w>c', { desc = 'Delete Windows', remap = true })

-- tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
