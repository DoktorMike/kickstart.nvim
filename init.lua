-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'config.options'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
require 'config.keymaps'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
require 'config.autocommands'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.

-- NOTE: These are the options going into lazy
local opts = {
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { 'catppuccin' },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    --enabled = true,
    notify = false, -- get a notification when changes are found
  },
  rtp = {
    ---@type string[] list any plugins you want to disable here
    disabled_plugins = {
      -- "gzip",
      -- "matchit",
      -- "matchparen",
      -- "netrwPlugin",
      -- "tarPlugin",
      -- "tohtml",
      -- "tutor",
      -- "zipPlugin",
    },
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}

-- NOTE: This sets up all plugins located in 'lua/custom/plugins' directory.
-- This is the easiest way to modularize your config.

require('lazy').setup('custom.plugins', opts)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
