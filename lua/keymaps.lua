-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Obsidian Keymaps ]]
-- Helper: create an Obsidian note using a specific template in a specific subdir
local function obsidian_new_note_from_template_in_subdir(subdir, template)
  return function()
    local ok, obsidian = pcall(require, 'obsidian')
    if not ok then
      vim.notify('Obsidian.nvim is not available', vim.log.levels.ERROR)
      return
    end

    local client = obsidian.get_client()

    -- Prompt for title
    local title = vim.fn.input 'Title: '
    if title == nil or title == '' then
      return
    end

    -- dir is relative to the current workspace root
    local dir = client.dir / subdir

    client:create_note {
      title = title,
      dir = dir,
      template = template, -- e.g. "task.md" or "project.md"
    }
  end
end

-- Daily workflow
vim.keymap.set('n', '<leader>zdd', '<cmd>ObsidianToday<CR>', { desc = "Obsidian: Open today's daily note" })

-- Recent dailies
vim.keymap.set('n', '<leader>zww', '<cmd>ObsidianDailies -7 0<CR>', { desc = 'Obsidian: Recent dailies' })

-- Insert template
vim.keymap.set('n', '<leader>zti', '<cmd>ObsidianTemplate<CR>', { desc = 'Obsidian: Insert template' })

-- New note (default template)
vim.keymap.set('n', '<leader>znn', '<cmd>ObsidianNewFromTemplate default-note.md<CR>', { desc = 'Obsidian: New note (default template)' })

-- New Task note → 15_Tasks/ using task.md
vim.keymap.set('n', '<leader>znt', obsidian_new_note_from_template_in_subdir('15_Tasks', 'task.md'), { desc = 'Obsidian: New task note' })

-- New Project note → 10_Projects/ using project.md
vim.keymap.set('n', '<leader>znp', obsidian_new_note_from_template_in_subdir('10_Projects', 'project.md'), { desc = 'Obsidian: New project note' })

-- Open in Obsidian app
vim.keymap.set('n', '<leader>zo', '<cmd>ObsidianOpen<CR>', { desc = 'Obsidian: Open in app' })

-- Quick switch & search
vim.keymap.set('n', '<leader>zq', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Obsidian: Quick switch' })
vim.keymap.set('n', '<leader>zs', '<cmd>ObsidianSearch<CR>', { desc = 'Obsidian: Search' })

-- Backlinks & tags
vim.keymap.set('n', '<leader>zb', '<cmd>ObsidianBacklinks<CR>', { desc = 'Obsidian: Backlinks' })
vim.keymap.set('n', '<leader>ztg', '<cmd>ObsidianTags<CR>', { desc = 'Obsidian: Tags' })

-- Workspace switching
vim.keymap.set('n', '<leader>zw', '<cmd>ObsidianWorkspace wms<CR>', { desc = 'Obsidian: Switch to WMS' })
vim.keymap.set('n', '<leader>zl', '<cmd>ObsidianWorkspace lms<CR>', { desc = 'Obsidian: Switch to LMS' })

-- Follow markdown links only when on a link
vim.keymap.set('n', 'gf', function()
  if require('obsidian').util.cursor_on_markdown_link() then
    return '<cmd>ObsidianFollowLink<CR>'
  else
    return 'gf'
  end
end, { noremap = false, expr = true, desc = 'Obsidian: Follow link if on markdown link' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
