# AGENTS.md

## Build/Lint/Test Commands

### Formatting
- `stylua --check .` - Check Lua formatting
- `stylua .` - Format all Lua files
- In Neovim: `<leader>f` - Format current buffer (uses conform.nvim)

### Linting
- Markdown: Uses markdownlint via nvim-lint
- In Neovim: Linting runs automatically on BufEnter, BufWritePost, and InsertLeave
- Run linting manually: `:Lint` (if plugin is enabled)

### Testing
- No specific test framework configured in this Neovim configuration
- Plugin functionality can be tested by running Neovim and using the configured keymaps
- To test a single plugin, start Neovim with `nvim` and verify the plugin works as expected
- For LSP functionality, open a file of the appropriate type and check that diagnostics, completion, and other features work

## Code Style Guidelines

### Formatting
- Column width: 160 characters
- Line endings: Unix
- Indentation: 2 spaces
- Quote style: Auto prefer single quotes
- Call parentheses: None when possible

### Naming Conventions
- Lua modules: lowercase with hyphens (e.g., `my-plugin.lua`)
- Variables: snake_case
- Functions: snake_case
- Classes/Types: PascalCase

### Imports
- Use relative paths for local modules: `require 'module'`
- Group standard library imports first, then third-party, then local imports
- Use descriptive module names that reflect their purpose

### Error Handling
- Use Lua's `pcall` for safe function calls
- Provide meaningful error messages
- Handle errors close to where they occur

### Plugin Configuration
- Plugin specs should be in separate files under `lua/kickstart/plugins/` or `lua/custom/plugins/`
- Use the lazy.nvim plugin specification format
- Include keymaps and commands in plugin configurations when appropriate
- Document plugin functionality with comments

### Documentation
- Comment complex code sections
- Use `-- NOTE:` for important implementation details
- Document public APIs and configuration options
- Include references to help documentation when relevant

### Project Structure
- Modular approach: Configuration is split into multiple files under `lua/`
- `lua/kickstart/` contains core plugin configurations
- `lua/custom/` contains user-specific plugin configurations
- Plugin files return a table with plugin specifications
- Keymaps and options are in separate files (`keymaps.lua`, `options.lua`)

### Code Conventions
- Use `vim.keymap.set()` for key mappings
- Use `vim.api.nvim_create_autocmd()` for autocommands
- Use `vim.schedule()` for operations that might affect startup time
- Follow the existing comment style with `--` for single-line comments and `--[[ ]]` for multi-line comments