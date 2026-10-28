vim.pack.add { { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } }

require('catppuccin').setup { default_integrations = true }
vim.cmd.colorscheme 'catppuccin'
