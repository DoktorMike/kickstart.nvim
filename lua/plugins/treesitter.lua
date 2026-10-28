vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } }

local ts = require 'nvim-treesitter'
ts.install { 'bash', 'c', 'diff', 'fish', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

local function attach(buf, language)
  if not vim.treesitter.language.add(language) then return end
  vim.treesitter.start(buf, language)
  if vim.treesitter.query.get(language, 'indents') then vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

-- Start treesitter for every filetype, installing missing parsers on demand.
local available = ts.get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, language = args.buf, vim.treesitter.language.get_lang(args.match)
    if not language then return end
    if not vim.tbl_contains(ts.get_installed 'parsers', language) and vim.tbl_contains(available, language) then
      ts.install(language):await(function() attach(buf, language) end)
    else
      attach(buf, language)
    end
  end,
})
