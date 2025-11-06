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

-- Check for Termux environment to conditionally load plugins
local is_termux = vim.fn.isdirectory("/data/data/com.termux") == 1

-- Setup lazy.nvim with plugins
require("lazy").setup({
    -- Core plugins
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim',               tag = '0.1.5',                                        dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'nvim-treesitter/nvim-treesitter',             build = ':TSUpdate' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'windwp/nvim-autopairs' },
    { 'lewis6991/gitsigns.nvim' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-fugitive' },
    { 'mfussenegger/nvim-dap' },
    { 'rcarriga/nvim-dap-ui' },
    { 'stevearc/conform.nvim' },
    { 'mfussenegger/nvim-lint' },
    { 'williamboman/mason.nvim',         cond = not is_termux },
    { 'jay-babu/mason-lspconfig.nvim',   cond = not is_termux },
    { 'nvim-telescope/telescope-fzf-native.nvim',    build = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { "mattn/emmet-vim" },

    -- UI & Theme
    { "catppuccin/nvim",                             name = "catppuccin",                                  priority = 1000 },
    { 'nvim-lualine/lualine.nvim',                   dependencies = { 'linux-cultist/venv-selector.nvim' } },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "neovim/nvim-lspconfig" },
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                ERROR = { icon = " ", color = "error" },
                TODO = { icon = " ", color = "info" },
                WARNING = { icon = " ", color = "warning" },
                todo = { icon = " ", color = "info" },
                error = { icon = " ", color = "error" },
                warning = { icon = " ", color = "warning" },
            },
        },
    },

    -- AI & Completion
    { "e3oroush/askCode",              config = function() require("askCode").setup() end },
    {
        "monkoose/neocodeium",
        event = "VeryLazy",
        config = function()
            require("neocodeium")
                .setup()
        end
    },
    -- { "Exafunction/codeium.nvim", dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" } },
    -- { 'github/copilot.lua' },
    -- { "zbirenbaum/copilot-cmp" },
    {
        'supermaven-inc/supermaven-nvim',
        config = function()
            require("supermaven-nvim").setup({})
        end,
    },

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            -- Use a more robust path for custom snippets
            require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath('config') .. "/lua/custom_snippets.lua" })
        end,
    },

    -- Utility
    { 'numToStr/Comment.nvim',         opts = {} },
    { "christoomey/vim-tmux-navigator" },
    { "chenasraf/text-transform.nvim", version = "*" },
    { "mistricky/codesnap.nvim",       build = "make build_generator" },
    { "APZelos/blamer.nvim" },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
        },
        ft = "python",                                                                                         -- Load when opening Python files
        keys = {
            { ",v", "<cmd>VenvSelect<cr>" },                                                                   -- Open picker on keymap
        },
        opts = {                                                                                               -- this can be an empty lua table - just showing below for clarity.
            search = {},
            options = {}
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },

}, {})

-- General Neovim settings
vim.g.blamer_enabled = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
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
vim.keymap.set("i", "<A-f>", function() require("neocodeium").accept() end)
vim.keymap.set("v", "<leader>ae", ":AskCodeExplain<CR>")
vim.keymap.set("v", "<leader>ab", ":AskCode \"Find potential bugs\"<CR>")
vim.keymap.set("v", "<leader>ad", ":AskCodeAddDocstring<CR>")
vim.keymap.set("v", "<leader>ar", ":AskCodeReplace \"Refactor this code\"<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cA", function()
    require("text-transform").actions.change_case_telescope()
end, { desc = "Change Case" })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open current file in explorer' })
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>', { desc = 'Find text' })
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
vim.keymap.set('n', '<leader>s', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = 'Format code (LSP)' })
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
vim.keymap.set('v', '<leader>cs', '<cmd>CodeSnap<cr>', { desc = 'Code snap' })
vim.keymap.set('n', '<leader>m', ':MarkdownPreviewToggle<CR>', { desc = 'Toggle markdown preview' })

-- VSCode-like keybindings
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { desc = 'Save file (insert mode)' })
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })
vim.keymap.set('n', '<C-y>', '<C-r>', { desc = 'Redo' })

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

-- Autocompletion (nvim-cmp)
pcall(function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
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
            ['<Tab>'] = cmp.mapping(function(fallback)
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
        }),
    })
end)

-- LSP Configuration
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


    -- Define the list of servers to set up
    local servers = {
        'tsserver', 'cssls', 'html', 'jsonls', 'svelte', 'vue', 'volar',
        'pyright', 'lua_ls', 'bashls', 'dockerls', 'gopls',
        'rust_analyzer', 'clangd', 'jdtls', 'ruff_lsp'
    }

if is_termux then
    -- In Termux, LSPs are expected to be in the path.
    -- We just need to set them up with lspconfig.
    for _, server_name in ipairs(servers) do
        lspconfig[server_name].setup {
            capabilities = capabilities,
        }
    end
else
    -- On other systems, use Mason to manage and set up LSPs.
    require("mason").setup({
        ui = {
            border = "rounded",
        },
    })
    require("mason-lspconfig").setup({
        ensure_installed = servers,
    })
    require("mason-lspconfig").setup_handlers {
        function(server_name)
            lspconfig[server_name].setup {
                capabilities = capabilities,
            }
        end,
    }
end

-- Formatter
pcall(function()
    require('conform').setup({
        formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            json = { "prettier" },
            python = { "ruff_format" },
            lua = { "stylua" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    })
end)

-- Linter
pcall(function()
    require('lint').setup({
        linters_by_ft = {
            javascript = { 'eslint' },
            typescript = { 'eslint' },
            python = { 'ruff' },
        },
    })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead", "InsertLeave" }, {
        callback = function()
            require("lint").try_lint()
        end,
    })
end)

-- Treesitter
pcall(function()
    require('nvim-treesitter.configs').setup({
        ensure_installed = { 'javascript', 'typescript', 'python', 'lua', 'html', 'css', 'json', 'vim', 'vimdoc', 'svelte', 'vue' },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
    })
end)

-- Autopairs
pcall(function()
    require('nvim-autopairs').setup({})
end)

-- GitSigns
pcall(function()
    require('gitsigns').setup()
end)

-- NvimTree
pcall(function()
    require('nvim-tree').setup({
        sort_by = 'case_sensitive',
        view = {
            adaptive_size = true,
            width = 30,
        },
        renderer = { group_empty = true },
        filters = {
            dotfiles = false,
            respect_gitignore = false
        },
    })
end)

-- Lualine
pcall(function()
    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'catppuccin',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = { statusline = { "NvimTree", "dashboard", "noice" }, winbar = {} },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = { statusline = 1000, tabline = 1000, winbar = 1000 }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { "nvim_diagnostic" } } },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype', 'venv-selector' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {}, lualine_b = {}, lualine_c = { 'filename' },
            lualine_x = { 'location' }, lualine_y = {}, lualine_z = {}
        },
        tabline = {}, winbar = {}, inactive_winbar = {},
        extensions = { 'nvim-tree' }
    }
end)

-- Telescope
pcall(function()
    require('telescope').setup({
        defaults = {
            layout_strategy = 'horizontal',
            layout_config = {
                horizontal = { prompt_position = "top", preview_width = 0.55 },
                vertical = { mirror = false },
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
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'live_grep_args')
end)

-- Catppuccin
require("catppuccin").setup({
    flavour = "mocha",
    background = { light = "latte", dark = "mocha" },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = { enabled = false },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
        comments = { "italic" },
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
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = { enabled = true },
        dap = { enabled = true },
    },
})

-- Set colorscheme
vim.cmd.colorscheme "catppuccin"

