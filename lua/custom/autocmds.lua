-- autocmds.lua: Custom autocommands

-- Set conceallevel and concealcursor for Markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = 'nc'
  end,
})
