vim.pack.add {
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/folke/lazydev.nvim',
}

require('fidget').setup {}

-- Give lua_ls the Neovim API, plus a plugin's types only once it is `require`d.
-- Loading the whole runtimepath as a library makes lua_ls slow on every edit.
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local function map(keys, func, desc, mode) vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    -- Highlight references of the word under the cursor while it rests there
    if client:supports_method('textDocument/documentHighlight', event.buf) then
      local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Installed by Mason and enabled below. Each value is passed to `vim.lsp.config()`.
local servers = {
  bashls = {},
  docker_compose_language_service = {},
  fish_lsp = {},
  postgres_lsp = {},
  pyright = {},
  r_language_server = {},
  stylua = {},
  ts_ls = {},
  lua_ls = {
    -- Formatting is done by stylua. Neovim runtime and plugin types come from lazydev.
    on_init = function(client) client.server_capabilities.documentFormattingProvider = false end,
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
        format = { enable = false },
      },
    },
  },
}

require('mason').setup {}
require('mason-lspconfig').setup { automatic_enable = false }
require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- Julia: not managed by Mason. Uses LanguageServer.jl from a dedicated environment;
-- its main branch dropped SymbolServer/StaticLint so the lspconfig default cmd breaks.
vim.lsp.config('julials', {
  cmd = {
    'julia',
    '--startup-file=no',
    '--history-file=no',
    '--project=' .. vim.fn.expand '~/.julia/environments/nvim-lspconfig',
    '-e',
    'using LanguageServer; runserver()',
  },
})
vim.lsp.enable 'julials'
