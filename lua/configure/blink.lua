local opts = {}

opts.nerd_font_variant = 'mono'
opts.highlight = { use_nvim_cmp_as_default = true }

opts.accept = { auto_brackets = { enabled = true } }
opts.trigger = { signature_help = { enabled = true } }

opts.sources = {
  -- add lazydev to your completion providers
  completion = { enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' } },
  -- dont show LuaLS require statements when lazydev has items
  providers = {
    lsp = { fallback_for = { 'lazydev' } },
    lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
  },
}

require('blink.cmp').setup(opts)
