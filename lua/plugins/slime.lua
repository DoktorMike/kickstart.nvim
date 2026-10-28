-- Send code to a tmux pane
vim.g.slime_target = 'tmux'
vim.g.slime_default_config = { socket_name = 'default', target_pane = '{last}' }
vim.g.slime_cell_delimiter = '#%%'
vim.g.slime_bracketed_paste = 1
vim.g.slime_python_ipython = 1

vim.pack.add { 'https://github.com/jpalardy/vim-slime' }
