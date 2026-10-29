vim.pack.add { 'https://github.com/HakonHarnes/img-clip.nvim' }

require('img-clip').setup {}
vim.keymap.set('n', '<leader>ii', '<cmd>PasteImage<CR>', { desc = '[I]nsert [I]mage from clipboard' })
