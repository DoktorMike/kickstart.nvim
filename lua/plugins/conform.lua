vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- No well-standardised style for C/C++
    local disabled = { c = true, cpp = true }
    if disabled[vim.bo[bufnr].filetype] then return nil end
    return { timeout_ms = 5000 }
  end,
  default_format_opts = { lsp_format = 'fallback' },
  formatters = {
    styler = {
      -- Run styler via R with 4-space indent, borrowed from https://github.com/devOpifex/r.nvim
      args = { '-s', '-e', 'styler::style_file(commandArgs(TRUE),indent_by=4L)', '--args', '$FILENAME' },
      stdin = false,
    },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    r = { 'styler' },
    quarto = { 'styler' },
    julia = { 'runic' },
    sql = { 'pg_format', 'sql_formatter', stop_after_first = true },
    html = { 'htmlbeautifier', 'html_beautify', stop_after_first = true },
    sh = { 'beautysh', 'shfmt', stop_after_first = true },
    json = { 'prettier' },
    jsonc = { 'prettier' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
