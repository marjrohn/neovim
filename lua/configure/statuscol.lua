local builtin = require('statuscol.builtin')
local ffi = require('statuscol.ffidef')
local foldicons = require('icons').fold

local foldend = nil
local lastbuf = nil
local anyfold = nil

local cursor_fold = { level = 0, start = -1, foldend = -1 }
local _win = 0

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufWinEnter' }, {
  callback = function(ev)
    local line = vim.api.nvim_win_get_cursor(_win)[1]
    local foldlevel = vim.fn.foldlevel(line)

    if foldlevel == 0 then
      cursor_fold.level = 0
      cursor_fold.start = -1
      cursor_fold.foldend = -1
    elseif line <= cursor_fold.start or line >= cursor_fold.foldend or foldlevel ~= cursor_fold.level then
      cursor_fold.level = foldlevel

      local foldstart = vim.fn.foldclosed(line)
      if foldstart ~= -1 then
        cursor_fold.start = foldstart
        cursor_fold.foldend = vim.fn.foldclosedend(line)
      else
        vim.cmd('silent! ' .. line .. 'foldclose')
        cursor_fold.start = vim.fn.foldclosed(line)
        cursor_fold.foldend = vim.fn.foldclosedend(line)
        vim.cmd('silent! ' .. line .. 'foldopen')
      end
    end
  end,
})

local opts = {}

opts.relculright = true
opts.segments = {
  {
    text = {
      function(args)
        local fold_hl = '%#LineNr#'
        local lnum = args.lnum
        local foldinfo = ffi.C.fold_info(args.wp, lnum)
        local next_foldinfo = ffi.C.fold_info(args.wp, lnum + 1)
        local foldlevel = foldinfo.level
        local foldstart = foldinfo.start
        local next_foldlevel = next_foldinfo.level
        local next_foldstart = next_foldinfo.start

        _win = args.win

        if foldlevel == 0 then
          return ''
        end

        if lnum >= cursor_fold.start and lnum <= cursor_fold.foldend then
          fold_hl = '%#CursorLineNr#'
        end

        if foldinfo.lines > 0 then
          return fold_hl .. foldicons.close
        end

        if lnum == foldstart then
          return fold_hl .. (foldlevel == 1 and foldicons.open or foldicons.divider)
        end

        -- end of fold
        if
          not (foldlevel == next_foldlevel and foldstart == next_foldstart) and (foldlevel == 1 and next_foldlevel <= 1)
        then
          return fold_hl .. foldicons.foldend
        end

        return fold_hl .. foldicons.scope
      end,
    },
    condition = {
      function(args)
        if (not vim.wo.foldenable) or vim.wo.foldcolumn == '0' then
          return false
        end

        if (not anyfold) or (args.buf ~= lastbuf) then
          local foldinfo = ffi.C.fold_info(args.wp, args.lnum)
          lastbuf = args.buf
          anyfold = foldinfo.level > 0
        end

        return anyfold
      end,
    },
    sign = { colwidth = 2 },
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
    text = { builtin.lnumfunc },
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
