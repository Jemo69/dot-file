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
vim.opt.runtimepath:append("/projects/mytheme/Celestial-Echoes/nvim/Celestial-Echoes_Dark.lua")

require("lazy").setup({
  { 'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'neovim/nvim-lspconfig' }, -- Corrected repository name
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'L3MON4D3/LuaSnip' },
  { 'windwp/nvim-autopairs' },
  { 'lewis6991/gitsigns.nvim' },
  { 'nvim-tree/nvim-tree.lua' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'folke/tokyonight.nvim' }, -- Or any other base theme if you prefer
  -- { 'catppuccin/nvim', name = 'catppuccin' },
  { 'nvim-lualine/lualine.nvim' },
  { 'nvim-neorg/neorg' }, -- For note-taking (optional)
  { 'tpope/vim-surround' },
  { 'tpope/vim-commentary' },
  { 'tpope/vim-fugitive' },
  { 'mfussenegger/nvim-dap' }, -- Debugging (optional)
  { 'rcarriga/nvim-dap-ui' }, -- Debugging UI (optional)
  { 'jose-elias-alvarez/null-ls.nvim' }, -- For formatters and linters
  { 'williamboman/mason.nvim' }, -- Corrected repository name
  { 'jay-babu/mason-lspconfig.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- Faster fuzzy finder (optional)
  { 'nvim-telescope/telescope-live-grep-args.nvim' }, -- More powerful live grep (optional)
  -- { 'github/copilot.lua' }, -- GitHub Copilot plugin - Original line causing error
  { 'github/copilot.vim' }, -- Corrected GitHub Copilot plugin (official one)
  { dir = '/home/jemo/projects/mytheme/Celestial-Echoes/nvim', name = 'mytheme' },
}, {})
-- require('Celestial-Echoes.nvim.Celestial-Echoes_Dark').colorscheme() -- Commented out missing theme
vim.cmd.colorscheme 'tokyonight' -- Use tokyonight as fallback

-- General Neovim settings (similar to VS Code defaults)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark" -- Or "light" depending on your Catppuccin preference
vim.opt.showmode = false -- Don't need to show mode in the statusline
vim.opt.signcolumn = "auto"
vim.opt.clipboard = "unnamedplus" -- Copy/paste with system clipboard
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

-- Keymappings (common VS Code-like mappings)
vim.g.mapleader = ' ' -- Set leader key to space
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open current file in explorer' })
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<C-S-f>', ':Telescope live_grep<CR>', { desc = 'Find text' }) -- Changed to C-S-f to avoid conflict
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>h', ':Telescope help_tags<CR>', { desc = 'Find help' })
vim.keymap.set('n', '<leader>r', ':Telescope oldfiles<CR>', { desc = 'Find recent files' })
vim.keymap.set('n', '<leader>gg', ':G<CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' }) -- Changed leader mapping
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' }) -- Changed leader mapping
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' }) -- Changed leader mapping
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find references' }) -- Changed leader mapping
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer (VSCode style)' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = 'Format code (LSP)' }) -- Use async format
vim.keymap.set('i', '<C-Space>', 'cmp.mapping.complete()', { expr = true, desc = 'Trigger completion' }) -- Use cmp mapping directly

-- VSCode-like keybindings
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { desc = 'Save file (insert mode)' })
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })
vim.keymap.set('n', '<C-y>', '<C-r>', { desc = 'Redo' })
vim.keymap.set('n', '<C-/>', 'gcc', { desc = 'Toggle comment', remap = true })
vim.keymap.set('v', '<C-/>', 'gc', { desc = 'Toggle comment', remap = true })
vim.keymap.set('i', '<C-/>', '<Esc>gcca', { desc = 'Toggle comment', remap = true })

-- Search functionality (VSCode-like)
vim.keymap.set('n', '<C-f>', '/', { desc = 'Find/search in current file' })
vim.keymap.set('n', '<C-S-h>', ':%s/', { desc = 'Find and replace' })

-- Multi-cursor like functionality (using visual block mode)
vim.keymap.set('n', '<C-d>', 'viw', { desc = 'Select word' })
vim.keymap.set('v', '<C-d>', 'y/<C-r>"<CR>n', { desc = 'Find next occurrence' })

-- Window/Tab navigation
vim.keymap.set('n', '<C-w>', ':bd<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<C-Tab>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-S-Tab>', ':bprev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<C-n>', ':enew<CR>', { desc = 'New file' })

-- Line manipulation (VSCode Alt+Up/Down)
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

-- Duplicate line (VSCode Alt+Shift+Up/Down)
vim.keymap.set('n', '<A-S-Up>', ':t .-1<CR>', { desc = 'Duplicate line up' })
vim.keymap.set('n', '<A-S-Down>', ':t .<CR>', { desc = 'Duplicate line down' })
vim.keymap.set('v', '<A-S-Up>', "y'<P", { desc = 'Duplicate selection up' })
vim.keymap.set('v', '<A-S-Down>', "y'>p", { desc = 'Duplicate selection down' })

-- Add Copilot keymaps (optional, customize as needed)
-- Note: copilot.lua uses different functions than copilot.vim
-- Check copilot.lua documentation for correct keymap functions if you switch back
-- Example for copilot.vim (adjust if using copilot.lua)
vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', { expr = true, silent = true, script = true, replace_keycodes = false, noremap = true })
-- vim.g.copilot_no_tab_map = true -- Disable default Tab mapping if you use Tab for completion

-- Autocompletion (nvim-cmp)
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(), -- Keep C-k
    ['<C-j>'] = cmp.mapping.select_next_item(), -- Keep C-j
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'copilot' }, -- Add Copilot as a source (works with copilot.vim too)
  }),
})

-- LSP Configuration (nvim-lspconfig)
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup LSP servers using mason-lspconfig
require("mason-lspconfig").setup_handlers {
    -- Default handler: Setup server with capabilities
    function (server_name)
        lspconfig[server_name].setup {
            capabilities = capabilities,
        }
    end,
    -- Custom handlers for specific servers if needed
    -- ["pylsp"] = function ()
    --     lspconfig.pylsp.setup {
    --         capabilities = capabilities,
    --         settings = { pylsp = { plugins = { ... } } }
    --     }
    -- end,
}

-- Treesitter Configuration
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'javascript', 'typescript', 'python', 'lua', 'html', 'css', 'json', 'vim', 'vimdoc' }, -- Added vim, vimdoc
  highlight = { enable = true },
  indent = { enable = true },
  auto_install = true, -- Automatically install missing parsers
})

-- Autopairs Configuration
require('nvim-autopairs').setup({})

-- GitSigns Configuration
require('gitsigns').setup()

-- NvimTree Configuration
require('nvim-tree').setup({
  sort_by = 'case_sensitive',
  view = {
    adaptive_size = true,
    width = 30, -- Set a fixed width or keep adaptive_size
  },
  renderer = {
    group_empty = true, -- Show empty folders
    icons = {
        glyphs = {
            default = "",
            symlink = "",
            folder = {
                arrow_open = "",
                arrow_closed = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
            },
            git = {
                unstaged = "",
                staged = "S",
                unmerged = "",
                renamed = "➜",
                untracked = "U",
                deleted = "",
                ignored = "◌",
            },
        },
    },
  },
  filters = {
    dotfiles = false, -- Show dotfiles
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Default mappings. See :help nvim-tree-mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
    -- Add more custom keymappings here if needed
  end,
})

-- Theme Configuration (Catppuccin)
-- vim.g.catppuccin_flavour = "mocha" -- or latte, frappe, macchiato
-- vim.cmd.colorscheme 'catppuccin'


-- Lualine Configuration
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto', -- Use auto theme detection
    component_separators = { left = '', right = ''}, -- Updated separators
    section_separators = { left = '', right = ''},   -- Updated separators
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false, -- Set to true if you want a global statusline
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', { 'diagnostics', sources = { "nvim_diagnostic" } } }, -- Use nvim_diagnostic
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {'nvim-tree', 'toggleterm'} -- Add nvim-tree and other extensions if needed
}

-- Mason Configuration (for managing LSP servers, linters, formatters)
require("mason").setup({
    ui = {
        border = "rounded",
    },
})
require("mason-lspconfig").setup({
  ensure_installed = {
    'ts_ls', -- Updated from deprecated 'tsserver'
    'pyright',
    'lua_ls', -- Added Lua LSP
    -- Add more language servers as needed
  },
  automatic_installation = true, -- Automatically install ensured servers
})

-- Null-ls Configuration (for formatters and linters not directly supported by LSP)
-- Note: null-ls is archived. Consider alternatives like conform.nvim or nvim-lint.
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier, -- Use formatting instead of formatters
    null_ls.builtins.diagnostics.eslint, -- Use diagnostics instead of linters
    -- Add more formatters and linters as needed
  },
  -- Format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = "lsp_format_on_save", buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = "lsp_format_on_save",
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = false }) -- Use sync format on save
        end,
      })
    end
  end,
})

-- Telescope Configuration
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
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    live_grep_args = {
      auto_prompt = true, -- Automatically prompt for args like -i, -w, etc.
      mappings = {
        i = {
          -- ["<C-u>"] = false, -- Disable default Ctrl-u mapping if needed
          -- ["<C-r>"] = require("telescope.actions").smart_insert_replace,
        },
      },
    },
  },
})
-- Load the fzf extension (if installed)
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'live_grep_args')

-- Copilot Configuration (using copilot.vim)
-- No specific Lua setup needed for copilot.vim, but ensure it's installed via lazy.nvim
-- You might need to run :Copilot setup or similar if authentication is required.

-- Debugging (optional) - Placeholder, requires setup
-- require("nvim-dap-ui").setup()
-- local dap = require("dap")
-- dap.adapters.codelldb = { ... }
-- dap.configurations.cpp = { ... }
-- dap.configurations.rust = { ... }

-- Optional: Neorg configuration (for note-taking)
-- require('neorg').setup {
--   load = {
--     ["core.defaults"] = {}, -- Load default behaviour
--     ["core.concealer"] = {}, -- Adds pretty icons to your documents
--     ["core.dirman"] = { -- Manages Neorg workspaces
--       config = {
--         workspaces = {
--           notes = "~/notes",
--         },
--       },
--     },
--   },
-- }
