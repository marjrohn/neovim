local map = require('utils').mapping
local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name, clear)
  return vim.api.nvim_create_augroup(name, { clear = clear or false })
end

autocmd('LspAttach', {
  group = augroup('lsp_attach'),
  callback = function(event)
    --- keymaps
    map('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename', buffer = event.buf })
    map('n', '<f2>', vim.lsp.buf.rename, { desc = 'Rename', buffer = event.buf })
    map('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename', buffer = event.buf })

    map('n', '<f3>', vim.lsp.buf.format, { desc = 'Format', buffer = event.buf })
    map('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format', buffer = event.buf })

    map({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, { desc = 'Code Action', buffer = event.buf })
    map({ 'n', 'x' }, '<f4>', vim.lsp.buf.code_action, { desc = 'Code Action', buffer = event.buf })
    map({ 'n', 'x' }, '<leader>lca', vim.lsp.buf.code_action, { desc = 'Code Action', buffer = event.buf })

    map('n', 'grn', vim.lsp.buf.references, { desc = 'Goto References', buffer = event.buf })
    map('n', 'gR', vim.lsp.buf.references, { desc = 'Goto References', buffer = event.buf })

    map('n', 'gri', vim.lsp.buf.implementation, { desc = 'Goto Implementations', buffer = event.buf })
    map('n', 'go', vim.lsp.buf.type_definition, { desc = 'Type Definitions', buffer = event.buf })
    map('n', 'gO', vim.lsp.buf.document_symbol, { desc = 'Document Symbols', buffer = event.buf })

    map('i', '<c-s>', vim.lsp.buf.signature_help, { desc = 'Signature Help', buffer = event.buf })

    map('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition', buffer = event.buf })
    map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration', buffer = event.buf })

    map('n', 'K', vim.lsp.buf.hover, { desc = 'Symbol Hover', buffer = event.buf })
    ---

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = augroup('lsp_highlight', true)

      autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      autocmd('LspDetach', {
        group = augroup('lsp_detach'),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'lsp_highlight', buffer = event2.buf })
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server upports them
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('n', '<leader>lH', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, { desc = 'Toggle Inlay Hints', buffer = event.buf })
    end
  end,
})

--- Change diagnostic symbols in the sign column (gutter)
local signs = require('icons').diagnostics

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type:lower():gsub('^%l', string.upper)
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
---

--- languages serves
local servers = {}

-- lua language server
servers.lua_ls = { settings = {} }
servers.lua_ls.settings.lua = { completion = { callSnippet = 'Replace' } }
servers.lua_ls.settings.diagnostics = { disable = { 'missing-fields' } }
---

--- setup servers
for server, config in pairs(servers) do
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  require('lspconfig')[server].setup(config)
end
---
