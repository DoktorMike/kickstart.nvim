vim.pack.add {
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/rcarriga/nvim-notify',
  'https://github.com/folke/noice.nvim',
}

require('noice').setup {
  lsp = {
    -- Render LSP hover/signature markdown with treesitter
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
  routes = {
    -- Hide the "written" message on every save
    { filter = { event = 'msg_show', kind = '', find = 'written' }, opts = { skip = true } },
  },
}
