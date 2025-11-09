return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  cmd = {
    'ObsidianNew',
    'ObsidianNewFromTemplate',
    'ObsidianToday',
    'ObsidianDailies',
    'ObsidianTemplate',
    'ObsidianWorkspace',
    'ObsidianOpen',
    'ObsidianQuickSwitch',
    'ObsidianFollowLink',
    'ObsidianSearch',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'wms',
        path = '~/git/vaults/wms',
        overrides = {
          notes_subdir = '00_Inbox',
          daily_notes = {
            folder = '50_Daily',
            template = 'daily-note.md',
          },
        },
      },
      {
        name = 'lms',
        path = '~/git/vaults/lms',
        overrides = {
          notes_subdir = '00_Inbox',
          daily_notes = {
            folder = '50_Daily',
            template = 'daily-note-personal.md',
          },
        },
      },
    },

    -- Default behavior when not overridden by a workspace.
    notes_subdir = '00_Inbox',
    new_notes_location = 'notes_subdir',

    daily_notes = {
      folder = '50_Daily',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
    },

    templates = {
      folder = '~/git/vaults/_templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },

    picker = { name = 'telescope.nvim' },

    completion = {
      nvim_cmp = false, -- using a different completion engine
      min_chars = 2,
    },

    disable_frontmatter = false,
    note_frontmatter_func = function(note)
      if note.title then
        note:add_alias(note.title)
      end
      local out = { id = note.id, title = note.title, aliases = note.aliases, tags = note.tags or {} }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
  },
}
