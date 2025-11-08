return {
  'nvim-telekasten/telekasten.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    local tk = require 'telekasten'

tk.setup {
      vaults = {
        default = {
          home = vim.fn.expand('~/git/vaults/wms'),
          templates = vim.fn.expand('~/git/vaults/_templates'),
          dailies = vim.fn.expand('~/git/vaults/wms/50_Daily'),
          weeklies = vim.fn.expand('~/git/vaults/wms/60_Weekly'),
        },
        wms = {
          home = vim.fn.expand('~/git/vaults/wms'),
          templates = vim.fn.expand('~/git/vaults/_templates'),
          dailies = vim.fn.expand('~/git/vaults/wms/50_Daily'),
          weeklies = vim.fn.expand('~/git/vaults/wms/60_Weekly'),
        },
        lms = {
          home = vim.fn.expand('~/git/vaults/lms'),
          templates = vim.fn.expand('~/git/vaults/_templates'),
          dailies = vim.fn.expand('~/git/vaults/lms/50_Daily'),
          weeklies = vim.fn.expand('~/git/vaults/lms/60_Weekly'),
        },
      },
      default_vault = 'wms',
      
      -- optional: set specific template filenames that live in the shared folder
      template_new_note = 'conversation-note.md', -- Using closest match to general note
      template_new_daily = 'daily-note.md',
      template_new_project = 'project.md',
      template_new_weekly = 'daily-note.md', -- Using daily as template for weekly
      new_note_location = 'prefer_home', -- or "smart"
      tag_notation = '#tag',

      -- Additional configuration options
      follow_creates_nonexisting = true,
      dailies_format = "%Y-%m-%d",
      weeklies_format = "%Y-W%V",
      image_subdir = "img",
      extension = ".md",
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
    map('<leader>zwk', ':Telekasten goto_thisweek<CR>', 'This week')
    map('<leader>zz', ':Telekasten panel<CR>', 'Panel')
    map('<leader>zt', ':Telekasten toggle_todo<CR>', 'Toggle TODO')
    map('<leader>zi', ':Telekasten insert_link<CR>', 'Insert link')
    map('<leader>zf', ':Telekasten find_notes<CR>', 'Find notes')
    map('<leader>zT', ':Telekasten new_templated_note<CR>', 'Browse templates')

    -- Additional useful keymaps
    map('<leader>zb', ':Telekasten show_backlinks<CR>', 'Show backlinks')
    map('<leader>zg', ':Telekasten show_tags<CR>', 'Search tags')
    map('<leader>zy', ':Telekasten yank_notelink<CR>', 'Yank note link')
    map('<leader>zr', ':Telekasten follow_link<CR>', 'Follow link')
    
    -- Custom function to insert template content into current note
    map('<leader>ztm', function()
      local template_path = vim.fn.input("Template file: ", tk.Cfg.templates .. "/", "file")
      if template_path ~= "" and vim.fn.filereadable(template_path) == 1 then
        local lines = {}
        for line in io.lines(template_path) do
          table.insert(lines, line)
        end
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        vim.api.nvim_buf_set_lines(0, row, row, false, lines)
      else
        print("Template file not found or not readable")
      end
    end, 'Insert template content')
  end,
}
