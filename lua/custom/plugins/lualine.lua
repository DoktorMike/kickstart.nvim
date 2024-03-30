--  _                _ _
-- | |   _   _  __ _| (_)_ __   ___
-- | |  | | | |/ _` | | | '_ \ / _ \
-- | |__| |_| | (_| | | | | | |  __/
-- |_____\__,_|\__,_|_|_|_| |_|\___|
--

local config = function()
  require('lualine').setup {
    options = {
      theme = 'catppuccin',
      globalstatus = true,
      component_separators = { left = '|', right = '|' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        {
          'buffers',
        },
      },
    },
  }
end

return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  config = config,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
