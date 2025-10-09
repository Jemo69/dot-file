# Development Environment Documentation

This document provides an overview of the configuration for Neovim and Tmux, including a comprehensive list of keybindings and custom snippets.

## File Structure

All configuration files are located in the `.config` directory.

-   **`.config/nvim/`**: Contains the Neovim configuration.
    -   `init.lua`: The main entry point for the Neovim configuration. It sets up `lazy.nvim` and defines all the plugins and their settings.
    -   `lua/custom_snippets.lua`: Contains custom snippets for `luasnip`.
-   **`.tmux.conf`**: The main configuration file for Tmux, located in the root directory of the repository.

## Neovim Configuration (`nvim/init.lua`)

The Neovim configuration is managed using `lazy.nvim`, a modern plugin manager for Neovim. It is designed to be modular and easy to maintain.

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
| `<C-S-s>`           | Toggle file explorer                              |
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

### Custom Snippets

Custom snippets are managed by `luasnip` and can be added to the `.config/nvim/lua/custom_snippets.lua` file. Any snippets added to this file will be automatically loaded.

#### Available Snippets

| Trigger  | Language | Description                |
| -------- | -------- | -------------------------- |
| `dmodel` | python   | Creates a Django model class. |

To add a new snippet, you can follow the example in the `custom_snippets.lua` file. The basic structure for a snippet is:

```lua
ls.add_snippets("filetype", {
    s("trigger", {
        t("snippet text"),
        i(1, "placeholder"),
    })
})
```

-   `filetype`: The file type for which the snippet should be active (e.g., "python", "javascript", "all").
-   `trigger`: The text that will expand into the snippet.
-   `snippet text`: The static text of the snippet.
-   `placeholder`: An interactive placeholder where you can type. The number `1` indicates the position in the tab order.

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
| `h` (prefix) | Navigate to the left pane (repeatable) |
| `j` (prefix) | Navigate to the pane below (repeatable) |
| `k` (prefix) | Navigate to the pane above (repeatable) |
| `l` (prefix) | Navigate to the right pane (repeatable) |
| `S-h` (prefix) | Resize pane left (repeatable) |
| `S-j` (prefix) | Resize pane down (repeatable) |
| `S-k` (prefix) | Resize pane up (repeatable) |
| `S-l` (prefix) | Resize pane right (repeatable) |