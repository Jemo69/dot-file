# Development Environment Documentation

This document provides an overview of the configuration for Neovim and Tmux, including a comprehensive list of keybindings.

## Neovim Configuration (`nvim/init.lua`)

The Neovim configuration is managed using `lazy.nvim`, a modern plugin manager for Neovim. The configuration is designed to be modular and easy to maintain.

### Keybindings

| Keybinding          | Description                                       |
| ------------------- | ------------------------------------------------- |
| `Space`             | Leader key                                        |
| `<leader>pv`        | Open current file in explorer                     |
| `<C-p>`             | Find files using Telescope                        |
| `<C-S-f>`           | Find text in files using Telescope                |
| `<leader>b`         | Find buffers using Telescope                      |
| `<leader>h`         | Find help tags using Telescope                    |
| `<leader>r`         | Find recent files using Telescope                 |
| `<leader>gg`        | Open Git status                                   |
| `<leader>gc`        | Git commit                                        |
| `<leader>gb`        | Git blame                                         |
| `gd`                | Go to definition (LSP)                            |
| `gD`                | Go to declaration (LSP)                           |
| `gt`                | Go to type definition (LSP)                       |
| `gi`                | Go to implementation (LSP)                        |
| `gr`                | Find references (LSP)                             |
| `<leader>rn`        | Rename symbol (LSP)                               |
| `<leader>ca`        | Show code actions (LSP)                           |
| `<leader>e`         | Toggle file explorer (NvimTree)                   |
| `<C-b>`             | Toggle file explorer (VSCode style)               |
| `<leader>d`         | Show diagnostics (LSP)                            |
| `[d`                | Go to previous diagnostic (LSP)                   |
| `]d`                | Go to next diagnostic (LSP)                       |
| `<leader>f`         | Format code (LSP)                                 |
| `<leader>xx`        | Toggle Trouble (diagnostics list)                 |
| `<leader>xt`        | Show TODO comments in Trouble                     |
| `<C-s>`             | Save file                                         |
| `<C-a>`             | Select all                                        |
| `<C-z>`             | Undo                                              |
| `<C-y>`             | Redo                                              |
| `gcc`               | Toggle comment (Normal mode)                      |
| `gc`                | Toggle comment (Visual mode)                      |

## Tmux Configuration (`.tmux.conf`)

The Tmux configuration is designed for a seamless experience with Neovim, featuring a shared color scheme and efficient navigation.

### Keybindings

| Keybinding | Description                      |
| ---------- | -------------------------------- |
| `C-h`      | Navigate to the left pane        |
| `C-j`      | Navigate to the pane below       |
| `C-k`      | Navigate to the pane above       |
| `C-l`      | Navigate to the right pane       |
| `C-\`     | Navigate to the previous pane    |