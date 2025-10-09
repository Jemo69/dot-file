-- Set up lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 'nvim-telescope/telescope.nvim',               tag = '0.1.5',       dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'nvim-treesitter/nvim-treesitter',             build = ':TSUpdate' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { "catppuccin/nvim",                             name = "catppuccin", priority = 1000 },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'L3MON4D3/LuaSnip' },
    { 'windwp/nvim-autopairs' },
    { 'lewis6991/gitsigns.nvim' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'folke/tokyonight.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    { 'nvim-neorg/neorg' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-fugitive' },
    { 'mfussenegger/nvim-dap' },
    { 'rcarriga/nvim-dap-ui' },
    { 'stevearc/conform.nvim' },
    { 'mfussenegger/nvim-lint' },
    { 'williamboman/mason.nvim' },
    { 'jay-babu/mason-lspconfig.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim',    build = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'github/copilot.lua' },
    { "zbirenbaum/copilot-cmp" },
    { 'chikko80/error-lens.nvim' },
    -- {
    --     'supermaven-inc/supermaven-nvim',
    --     config = function()
    --         require("supermaven-nvim").setup({})
    --     end,
    -- },
    { "mattn/emmet-vim" },
    -- New Plugins
    { 'folke/trouble.nvim',        dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = {} },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    { "Exafunction/codeium.nvim",  dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" } },
    { 'numToStr/Comment.nvim',     opts = {} },
    { "folke/todo-comments.nvim",  dependencies = { "nvim-lua/plenary.nvim" },       opts = {} },
    { "christoomey/vim-tmux-navigator" },

}, {})

-- General Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.showmode = false
vim.opt.signcolumn = "auto"
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Keymappings
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open current file in explorer' })
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<C-S-f>', ':Telescope live_grep<CR>', { desc = 'Find text' })
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>h', ':Telescope help_tags<CR>', { desc = 'Find help' })
vim.keymap.set('n', '<leader>r', ':Telescope oldfiles<CR>', { desc = 'Find recent files' })
vim.keymap.set('n', '<leader>gg', ':G<CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find references' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', '<C-S-s>', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = 'Format code (LSP)' })
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })

-- VSCode-like keybindings
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { desc = 'Save file (insert mode)' })
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })
vim.keymap.set('n', '<C-y>', '<C-r>', { desc = 'Redo' })
-- Commenting is now handled by Comment.nvim

-- Plugin configurations

-- nvim-notify
pcall(function()
    require("notify").setup({
        background_colour = "#000000",
        stages = "fade_in_slide_out",
        timeout = 3000,
    })
    vim.notify = require("notify")
end)

-- Comment.nvim
pcall(function()
    require('Comment').setup()
end)

-- Codeium
pcall(function()
    require('codeium').setup({})
end)

-- Autocompletion (nvim-cmp) - with error handling
pcall(function()
    local cmp = require('cmp')
    require("copilot_cmp").setup()
    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'copilot' },
            { name = 'codeium' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
        }),
    })
end)

-- LSP Configuration - with error handling
pcall(function()
    local lspconfig = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require("mason").setup({
        ui = {
            border = "rounded",
        },
    })

    require("mason-lspconfig").setup({
        ensure_installed = {
            -- Web development
            'tsserver',
            'cssls',
            'html',
            'jsonls',
            'svelte',
            'vue',
            -- Python
            'pyright',
            -- Lua
            'lua_ls',
            -- Shell
            'bashls',
            -- Docker
            'dockerls',
            -- Go
            'gopls',
            -- Rust
            'rust_analyzer',
            -- C/C++
            'clangd',
            -- Java
            'jdtls',
        },
        automatic_installation = true,
    })

    require("mason-lspconfig").setup_handlers {
        function(server_name)
            lspconfig[server_name].setup {
                capabilities = capabilities,
            }
        end,
    }
end)

-- Copilot Configuration
pcall(function()
    require('copilot').setup({
        panel = {
            enabled = true,
            auto_refresh = true,
            keymap = {
                jump_prev = "[[" .. "]]",
                jump_next = "]]",
                accept = "<CR>",
                refresh = "gr",
                open = "<M-CR>"
            },
            layout = {
                position = "bottom",
                ratio = 0.4
            },
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
                accept = "<M-l>",
                accept_word = "<M-w>",
                accept_line = "<M-Enter>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-e>",
            },
        },
        filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = true,
        },
        copilot_node_command = 'node',
        server_opts_override = {},
    })
end)

-- Conform.nvim Configuration (modern formatter, replaces null-ls) - with error handling
pcall(function()
    require('conform').setup({
        formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            json = { "prettier" },
            python = { "black" },
            lua = { "stylua" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    })
end)

-- nvim-lint Configuration (modern linter, replaces null-ls) - with error handling
pcall(function()
    require('lint').setup({
        linters_by_ft = {
            javascript = { 'eslint' },
            typescript = { 'eslint' },
            python = { 'pylint' },
        },
    })

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead", "InsertLeave" }, {
        callback = function()
            require("lint").try_lint()
        end,
    })
end)

-- Other essential plugin configurations - with error handling

-- Treesitter Configuration
pcall(function()
    require('nvim-treesitter.configs').setup({
        ensure_installed = { 'javascript', 'typescript', 'python', 'lua', 'html', 'css', 'json', 'vim', 'vimdoc', 'svelte', 'vue' },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
    })
end)

-- Autopairs Configuration
pcall(function()
    require('nvim-autopairs').setup({})
end)

-- GitSigns Configuration
pcall(function()
    require('gitsigns').setup()
end)

-- NvimTree Configuration
pcall(function()
    require('nvim-tree').setup({
        sort_by = 'case_sensitive',
        view = {
            adaptive_size = true,
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = false,
        },
    })
end)

-- Lualine Configuration
pcall(function()
    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'catppuccin',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = { "NvimTree", "dashboard", "noice" },
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { "nvim_diagnostic" } } },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'nvim-tree' }
    }
end)

-- Telescope Configuration
pcall(function()
    require('telescope').setup({
        defaults = {
            layout_strategy = 'horizontal',
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = { "truncate" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            use_less = true,
            set_env = { ["COLORTERM"] = "truecolor" },
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        },
    })

    -- Load telescope extensions
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'live_grep_args')
end)

-- Catppuccin Configuration
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {     -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    float = {
        transparent = false,        -- enable transparent floating windows
        solid = false,              -- use solid styling for floating windows, see |winborder|
    },
    show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
    term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false,            -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15,          -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,              -- Force no italic
    no_bold = false,                -- Force no bold
    no_underline = false,           -- Force no underline
    styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" },    -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
        virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
        },
        underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
        },
        inlay_hints = {
            background = true,
        },
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    auto_integrations = false,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        notify = true,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
