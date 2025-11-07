return {
  'nvim-telekasten/telekasten.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    local tk = require 'telekasten'

    tk.setup {
      -- default (on startup) vault:
      home = vim.fn.expand '~/vaults/wms',

      -- shared templates for *both* vaults
      templates = '~/vaults/_templates',

      -- optional: set specific template filenames that live in the shared folder
      template_new_note = 'note.md',
      template_new_daily = 'daily.md',
      template_new_project = 'project.md',
      template_new_weekly = 'weekly.md',
      new_note_location = 'prefer_home', -- or "smart"
      tag_notation = '#tag',

      dailies = '~/vaults/wms/00_Inbox/Daily',
      weeklies = '~/vaults/wms/00_Inbox/Weekly',
      vaults = {
        wms = {
          home = '~/vaults/wms',
          templates = '~/vaults/_templates',
          dailies = '~/vaults/wms/00_Inbox/Daily',
          weeklies = '~/vaults/wms/00_Inbox/Weekly',
        },
        lms = {
          home = '~/vaults/lms',
          templates = '~/vaults/_templates',
          dailies = '~/vaults/lms/00_Inbox/Daily',
          weeklies = '~/vaults/lms/00_Inbox/Weekly',
        },
      },
    }

    -- Keymaps (adjust <leader>z to taste)
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { desc = 'TK: ' .. desc })
    end

    -- Vault switching
    map('<leader>zV', tk.switch_vault, 'Pick vault')
    map('<leader>zw', function()
      tk.switch_vault 'wms'
    end, 'Switch to WMS')
    map('<leader>zl', function()
      tk.switch_vault 'lms'
    end, 'Switch to LMS')

    -- Capture / navigate
    map('<leader>zn', ':Telekasten new_note<CR>', 'New note (template)')
    map('<leader>zd', ':Telekasten goto_today<CR>', 'Today (daily)')
    map('<leader>zwk', ':Telekasten week<CR>', 'This week')
    map('<leader>zz', ':Telekasten panel<CR>', 'Panel')
    map('<leader>zt', ':Telekasten toggle_todo<CR>', 'Toggle TODO')
    map('<leader>zi', ':Telekasten insert_link<CR>', 'Insert link')
    map('<leader>zf', ':Telekasten find_notes<CR>', 'Find notes')
    map('<leader>zT', ':Telekasten show_templates<CR>', 'Browse templates')

    -- Optional: statusline component showing current vault
    vim.g.tk_current_vault = function()
      return (require('telekasten').config.home:gsub('^.*/', '')) -- "wms" or "lms"
    end
  end,
}
