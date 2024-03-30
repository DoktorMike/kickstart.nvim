return { -- Send code to tmux terminal
  'jpalardy/vim-slime',
  lazy = false,
  config = function()
    vim.g.slime_target = 'tmux'
    vim.g.slime_python_ipython = 1
    -- vim.g.slime_default_config = { socket_name = "default", target_pane = ":.2" }
    vim.g.slime_default_config = { socket_name = 'default', target_pane = '{last}' }
    vim.b.slime_cell_delimiter = '#%%'
  end,
}
