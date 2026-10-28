vim.pack.add {
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  'https://github.com/rafamadriz/friendly-snippets',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
  'https://github.com/erooke/blink-cmp-latex',
  'https://github.com/moyiz/blink-emoji.nvim',
}

require('luasnip').setup {}
require('luasnip.loaders.from_vscode').lazy_load()

require('blink.cmp').setup {
  -- <c-y> accept, <c-space> menu/docs, <c-n>/<c-p> select, <tab>/<s-tab> snippet jump, <c-k> signature
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { 'lsp', 'path', 'latex', 'emoji', 'snippets', 'lazydev' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      emoji = {
        module = 'blink-emoji',
        name = 'Emoji',
        score_offset = 15,
        opts = { insert = true, trigger = function() return { ':' } end },
        should_show_items = function() return vim.tbl_contains({ 'gitcommit', 'markdown' }, vim.bo.filetype) end,
      },
      latex = {
        module = 'blink-cmp-latex',
        name = 'Latex',
        opts = { insert_command = false },
      },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
}
