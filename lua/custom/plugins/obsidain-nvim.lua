return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = 'lms',
        path = '~/git/lms',
      },
    },

    templates = {
      folder = '30_Resources/Templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },

    daily_notes = {
      folder = '50_Daily',
      date_format = '%Y-%m-%d',
      default_tags = { 'daily-notes' },
      template = 'daily-note.md',
    },

    completion = {
      nvim_cmp = false,
      blink_cmp = true,
    },
    legacy_commands = false,

    -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
    checkboxes = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      order = { ' ', '/', 'x', '>', '~', '!' },
    },
  },
}
