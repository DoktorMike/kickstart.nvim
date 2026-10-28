return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 5000,
            lsp_format = 'fallback',
          }
        end
      end,
      -- Fix styler
      formatters = {
        -- runic = {
        --   command = 'julia',
        --   args = { '--startup-file=no', '--project=@runic', '-e', 'using Runic; exit(Runic.main(ARGS))' },
        -- },
        styler = {
          -- hijacking "https://github.com/devOpifex/r.nvim",
          args = { '-s', '-e', 'styler::style_file(commandArgs(TRUE),indent_by=4L)', '--args', '$FILENAME' },
          stdin = false,
        },
        -- I'm not using this but I could use this instead of the styler where I control all of it.
        -- Right now I'm just changing the behavior of styler above instead.
        my_styler = {
          command = 'R',
          args = { '-s', '-e', 'styler::style_file(commandArgs(TRUE))', '--args', '$FILENAME' },
          stdin = false,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        r = { 'styler' },
        quarto = { 'styler' },
        julia = { 'runic' },
        sql = { 'pgformatter', 'sql-formatter', stop_after_first = true },
        html = { 'htmlbeautifier', 'html_beautify', stop_after_first = true },
        sh = { 'beautysh', 'shfmt', stop_after_first = true },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
