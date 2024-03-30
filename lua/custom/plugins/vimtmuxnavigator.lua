--  _                                            _             _   _
-- | |_ _ __ ___  _   ___  __  _ __   __ ___   _(_) __ _  __ _| |_(_) ___  _ __
-- | __| '_ ` _ \| | | \ \/ / | '_ \ / _` \ \ / / |/ _` |/ _` | __| |/ _ \| '_ \
-- | |_| | | | | | |_| |>  <  | | | | (_| |\ V /| | (_| | (_| | |_| | (_) | | | |
--  \__|_| |_| |_|\__,_/_/\_\ |_| |_|\__,_| \_/ |_|\__, |\__,_|\__|_|\___/|_| |_|
--                                                 |___/

return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  },
}
