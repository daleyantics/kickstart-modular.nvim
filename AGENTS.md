# AGENTS.md

## Build/Lint/Test Commands

### Formatting
- `stylua --check .` - Check Lua formatting
- `stylua .` - Format all Lua files
- In Neovim: `<leader>f` - Format current buffer (uses conform.nvim)

### Linting
- Markdown: Uses markdownlint via nvim-lint
- In Neovim: Linting runs automatically on BufEnter, BufWritePost, and InsertLeave

### Testing
- No specific test framework configured in this Neovim configuration
- Plugin functionality can be tested by running Neovim and using the configured keymaps
- To test a single plugin, start Neovim with `nvim` and verify the plugin works as expected

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

### Documentation
- Comment complex code sections
- Use `-- NOTE:` for important implementation details
- Document public APIs and configuration options

### Project Structure
- Modular approach: Configuration is split into multiple files under `lua/`
- `lua/kickstart/` contains core plugin configurations
- `lua/custom/` contains user-specific plugin configurations