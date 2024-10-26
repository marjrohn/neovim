vim.o.foldenable = true
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0

  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)

    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      local hlGroup = chunk[2]

      chunkText = truncate(chunkText, targetWidth - curWidth)
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      table.insert(newVirtText, { chunkText, hlGroup })

      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end

      break
    end

    curWidth = curWidth + chunkWidth
  end

  table.insert(newVirtText, { suffix, 'FoldedSuffix' })

  return newVirtText
end

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end,
  fold_virt_text_handler = handler,
})

local map = require('utils').mapping

map('n', 'zR', require('ufo').openAllFolds, { desc = 'Open All Folds' })
map('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close All Folds' })
map('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Open Folds Except Kinds' })
map('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Close Folds With' })
