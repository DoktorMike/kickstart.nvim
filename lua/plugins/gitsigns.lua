vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }

local gitsigns = require 'gitsigns'
gitsigns.setup {
  signs = {
    add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
  },
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { desc = desc, buf = bufnr }) end

    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, 'Jump to next git [c]hange')
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, 'Jump to previous git [c]hange')

    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'git [s]tage hunk')
    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'git [r]eset hunk')
    map('n', '<leader>hs', gitsigns.stage_hunk, 'git [s]tage hunk')
    map('n', '<leader>hr', gitsigns.reset_hunk, 'git [r]eset hunk')
    map('n', '<leader>hS', gitsigns.stage_buffer, 'git [S]tage buffer')
    map('n', '<leader>hR', gitsigns.reset_buffer, 'git [R]eset buffer')
    map('n', '<leader>hp', gitsigns.preview_hunk, 'git [p]review hunk')
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, 'git preview hunk [i]nline')
    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, 'git [b]lame line')
    map('n', '<leader>hd', gitsigns.diffthis, 'git [d]iff against index')
    map('n', '<leader>hD', function() gitsigns.diffthis '~' end, 'git [D]iff against last commit')
    map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, 'git hunk [Q]uickfix list (all files)')
    map('n', '<leader>hq', gitsigns.setqflist, 'git hunk [q]uickfix list (this file)')
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, '[T]oggle git [b]lame line')
    map('n', '<leader>tw', gitsigns.toggle_word_diff, '[T]oggle git [w]ord diff')
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, '[i]nside [h]unk')
  end,
}
