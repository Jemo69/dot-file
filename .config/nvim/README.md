# Neovim Configuration

This is a Neovim configuration designed for a modern, VSCode-like experience. It uses `lazy.nvim` for plugin management and is built around native LSP, Treesitter, and other powerful plugins.

## Features

-   **Plugin Manager**: `lazy.nvim` for fast and easy plugin management.
-   **LSP**: Native LSP with `nvim-lspconfig` for code intelligence.
-   **Completion**: `nvim-cmp` for autocompletion.
-   **Syntax Highlighting**: `nvim-treesitter` for better syntax highlighting.
-   **Fuzzy Finding**: `Telescope.nvim` for finding files, buffers, and more.
-   **Git Integration**: `gitsigns.nvim` and `vim-fugitive` for Git integration.
-   **UI**: `tokyonight.nvim` theme (with `catppuccin` and `celestial-echoes-nvim` available), `lualine.nvim` for the statusline, and `nvim-tree.lua` for the file explorer.
-   **Formatting and Linting**: `conform.nvim` for formatting and `nvim-lint` for linting. (Note: `null-ls.nvim` was not re-added as it is deprecated and its functionality is covered by `conform.nvim` and `nvim-lint`).
-   **AI-powered code completion**: `copilot.vim`, `supermaven-nvim`, `neocodeium` and `askCode`.
-   **Debugging**: `nvim-dap` and `nvim-dap-ui` for a powerful debugging experience.
-   **HTML/CSS Emmet**: `emmet-vim` for faster HTML/CSS workflow.
-   **Advanced Grep**: `telescope-live-grep-args.nvim` for more powerful live grep.
-   **Problem/Todo Viewer**: `trouble.nvim` for viewing diagnostics, references, and more.

## LSP Server Installation

This configuration uses `nvim-lspconfig` to manage Language Server Protocol (LSP) servers. However, it does **not** automatically install them. You need to install the LSP servers for the languages you want to use manually.

Here are some examples of how to install some of the configured LSP servers:

-   **Python**: `npm i -g pyright`
-   **TypeScript/JavaScript**: `npm i -g typescript-language-server`
-   **Lua**: Follow the instructions on the [lua-language-server](https://github.com/luals/lua-language-server) repository.
-   **JSON**: `npm i -g vscode-langservers-extracted`
-   **HTML**: `npm i -g vscode-langservers-extracted`
-   **CSS**: `npm i -g vscode-langservers-extracted`

After installing the servers, they should be available in your `PATH` and Neovim will be able to use them.

## Keybindings

### General

| Key | Description |
| --- | --- |
| `<leader>` | `Space` |
| `<C-s>` | Save file |
| `<C-a>` | Select all |
| `<C-z>` | Undo |
| `<C-y>` | Redo |

### File Explorer (`nvim-tree`)

| Key | Description |
| --- | --- |
| `<leader>s` | Toggle file explorer |

### Telescope

| Key | Description |
| --- | --- |
| `<C-p>` | Find files |
| `<leader>g` | Find text in files |
| `<leader>b` | Find buffers |
| `<leader>h` | Find help tags |
| `<leader>r` | Find recent files |

### LSP

| Key | Description |
| --- | --- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gt` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Find references |
| `<leader>rn` | Rename |
| `<leader>ca` | Code actions |
| `<leader>f` | Format code |

### Diagnostics

| Key | Description |
| --- | --- |
| `<leader>d` | Show diagnostics |
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |

### Debugging

| Key | Description |
| --- | --- |
| `<leader>dt` | Toggle DAP UI |
| `<leader>dc` | DAP Continue |
| `<leader>do` | DAP Step Over |
| `<leader>di` | DAP Step Into |
| `<leader>du` | DAP Step Out |
| `<leader>db` | DAP Toggle Breakpoint |
| `<leader>dr` | DAP Toggle REPL |

### Git

| Key | Description |
| --- | --- |
| `<leader>gg` | Git status |
| `<leader>gc` | Git commit |
| `<leader>gb` | Git blame |

### AI

| Key | Description |
| --- | --- |
| `<leader>ae` | Ask code to explain |
| `<leader>ab` | Ask code to find bugs |
| `<leader>ad` | Ask code to add docstring |
| `<leader>ar` | Ask code to refactor |

### Other

| Key | Description |
| --- | --- |
| `<leader>xt` | Show TODOs in trouble |
| `<leader>cs` | Create a code snapshot |
| `<leader>m` | Toggle markdown preview |
| `<leader>cA` | Change Case (text-transform) |
| `,v` | Select Python virtual environment (venv-selector) |
| `<leader>nl` | Clear search highlights |
