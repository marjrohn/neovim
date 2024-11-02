local opts = {}
local builtin = require('statuscol.builtin')
local ffi = require('statuscol.ffidef')
local foldicons = require('icons').fold

-- opts.relculright = true
opts.ft_ignore = { 'oil' }

local cursor_fold = { level = 0, start = -1, end_ = -1 }

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  group = vim.api.nvim_create_augroup('Statuscol Fold', { clear = false }),
  callback = function(ev)
    if vim.tbl_contains(opts.ft_ignore or {}, vim.bo.filetype) then
      return
    end

    if not vim.wo.foldenable or vim.wo.foldcolumn == '0' then
      return
    end

    local line = vim.api.nvim_win_get_cursor(0)[1]
    local foldlevel = vim.fn.foldlevel(line)

    if foldlevel == 0 then
      cursor_fold.level = 0
      cursor_fold.start = -1
      cursor_fold.end_ = -1
    elseif line < cursor_fold.start or line > cursor_fold.end_ or foldlevel ~= cursor_fold.level then
      cursor_fold.level = foldlevel

      local foldstart = vim.fn.foldclosed(line)
      if foldstart ~= -1 then
        cursor_fold.start = foldstart
        cursor_fold.end_ = vim.fn.foldclosedend(line)
      else
        vim.cmd('silent! ' .. line .. 'foldclose')
        cursor_fold.start = vim.fn.foldclosed(line)
        cursor_fold.end_ = vim.fn.foldclosedend(line)
        vim.cmd('silent! ' .. line .. 'foldopen')
      end
    end
  end,
})

local fold_has_level = function(args)
  if not vim.wo.foldenable or vim.wo.foldcolumn == '0' then
    return false
  end

  local foldlevel = ffi.C.fold_info(args.wp, args.lnum).level

  return foldlevel > 0
end

local fold_not_has_level = function(args)
  return not fold_has_level(args)
end

opts.segments = {
  {
    text = {
      function(args)
        local fold_hl = '%#FoldColumn#'
        local lnum = args.lnum
        local foldinfo = ffi.C.fold_info(args.wp, lnum)
        local next_foldinfo = ffi.C.fold_info(args.wp, lnum + 1)
        local foldlevel = foldinfo.level
        local foldstart = foldinfo.start
        local next_foldlevel = next_foldinfo.level
        local next_foldstart = next_foldinfo.start

        if lnum >= cursor_fold.start and lnum <= cursor_fold.end_ then
          fold_hl = '%#FoldColumnScope#'
        end

        if foldinfo.lines > 0 then
          return fold_hl .. foldicons.close
        end

        if lnum == foldstart then
          return fold_hl .. (foldlevel == 1 and foldicons.open or foldicons.scopestart)
        end

        -- end of fold
        local a = foldlevel ~= next_foldlevel
        local b = foldstart < next_foldstart
        if (a or b) and not (a and b) then
          if foldlevel == 1 and next_foldlevel <= 1 then
            return fold_hl .. foldicons.end_
          end

          return fold_hl .. foldicons.scopeend
        end

        return fold_hl .. foldicons.scope
      end,
    },
    condition = { fold_has_level },
    click = 'v:lua.ScFa',
  },

  {
    sign = {
      name = { 'Diagnostic' },
      colwidth = 1,
    },
    click = 'v:lua.ScSa',
  },

  {
    sign = {
      name = { '.*' },
      -- take anything except gitsigns, since it will be added after numbers
      namespace = { '^(?!.*(gitsigns))' },
      colwidth = 1,
      auto = true,
    },
    click = 'v:lua.ScSa',
  },

  {
    text = { '  ', builtin.lnumfunc },
    condition = { fold_not_has_level, true },
    click = 'v:lua.ScLa',
  },

  {
    sign = {
      namespace = { 'gitsigns' },
    },
    click = 'v:lua.ScSa',
  },
}

require('statuscol').setup(opts)
