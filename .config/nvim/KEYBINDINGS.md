# VSCode-like Neovim Keybindings Reference

## File Operations
- `Ctrl + n` - New file
- `Ctrl + s` - Save file
- `Ctrl + p` - Open file (fuzzy finder)
- `Ctrl + Shift + f` - Find in files (live grep)
- `Space + b` - Find buffers
- `Space + r` - Recent files

## Tab/Buffer Navigation
- `Ctrl + Tab` - Next buffer
- `Ctrl + Shift + Tab` - Previous buffer
- `Ctrl + w` - Close buffer

## File Explorer
- `Ctrl + b` - Toggle file explorer (NvimTree)
- `Space + e` - Toggle file explorer

## Search and Replace
- `Ctrl + f` - Find/search in current file
- `Ctrl + Shift + h` - Find and replace
- `Esc` - Clear search highlighting

## Text Manipulation
- `Ctrl + a` - Select all
- `Alt + Shift + Down` - Duplicate line down
- `Alt + Shift + Up` - Duplicate line up
- `Alt + Up` - Move line up
- `Alt + Down` - Move line down
- `gc` - Comment/uncomment (visual mode or motion)

## Multi-cursor (VSCode-like)
- `Ctrl + d` - Select next occurrence (like VSCode)
- `Alt + Ctrl + d` - Select all occurrences
- `Ctrl + p` - Previous cursor
- `Ctrl + x` - Skip current selection
- `Esc` - Exit multi-cursor mode

## Navigation Enhancement
- `s + [two chars]` - Jump to any location (EasyMotion)
- `Space + n` - Toggle relative/absolute line numbers

## Utility
- `Space + tw` - Trim trailing whitespace

## Text Objects (Vim surround)
- `cs\"'` - Change surrounding quotes from " to '
- `ds\"` - Delete surrounding quotes
- `ysiw\"` - Surround word with quotes
- `S\"` - Surround selection with quotes (in visual mode)

## LSP Features
- `gd` - Go to definition
- `gD` - Go to declaration
- `gt` - Go to type definition
- `gi` - Go to implementation
- `gr` - Find references
- `Space + rn` - Rename symbol
- `Space + ca` - Code actions
- `Space + f` - Format code
- `Space + d` - Show diagnostics
- `[d` - Go to previous diagnostic
- `]d` - Go to next diagnostic

## Git Operations
- `Space + gg` - Git status
- `Space + gc` - Git commit
- `Space + gb` - Git blame

## Auto-completion (nvim-cmp)
- `Tab` - Accept suggestion
- `Ctrl + Space` - Trigger completion
- `Ctrl + k` - Previous suggestion
- `Ctrl + j` - Next suggestion
- `Ctrl + b/f` - Scroll documentation

## VSCode-specific additions
- `Ctrl + z` - Undo
- `Ctrl + y` - Redo
- `Ctrl + /` - Toggle comment

## Notes
- Leader key is set to `Space`
- Most VSCode shortcuts work in Insert mode
- Configuration uses Lazy.nvim for plugin management
- LSP servers managed by Mason
- Use `:Mason` to manage language servers
