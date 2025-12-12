--[[ 

Neovim configuration for a VSCode-like experience.
This configuration is managed by lazy.nvim, a modern plugin manager for Neovim.

]]

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

-- [[ Basic Neovim settings ]]

-- Set leader key to space
vim.g.mapleader = ' '

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark" -- Or "light" depending on your Catppuccin preference
vim.opt.showmode = false -- Don't need to show mode in the statusline
vim.opt.signcolumn = "yes"
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

-- Enable virtual text for diagnostics
vim.diagnostic.config({
  virtual_text = true,
})

-- [[ Plugin Manager Setup ]]
require("lazy").setup({
  -- [[ Theme ]]
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "tokyonight" -- Default theme
    end,
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 }, -- Uncomment to use Catppuccin
  { 'Jemo69/celestial-echoes-nvim', priority = 1000 }, -- Uncomment to use Celestial Echoes

  -- [[ Core Plugins ]]
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },

  -- [[ Telescope for fuzzy finding ]]
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", "target", ".git" },
        },
      })
      -- Add fzf native extension
      pcall(telescope.load_extension, 'fzf')
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope-live-grep-args.nvim',
    config = function()
      require('telescope').load_extension('live_grep_args')
    end
  },

  -- [[ Treesitter for syntax highlighting ]]
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python", "html", "css", "json", "dart" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- [[ LSP, Completion and Snippets ]]
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  {
    'L3MON4D3/LuaSnip',
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- NOTE: LSP servers are not automatically installed.
  -- You need to install the language servers for the languages you use manually.
  -- For example, for Python, you can install pyright with: `npm i -g pyright`
  -- For TypeScript/JavaScript: `npm i -g typescript-language-server`
  -- For Lua: `brew install lua-language-server` (on macOS) or build from source.
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local servers = { "lua_ls", "pyright", "tsserver", "jsonls", "html", "cssls", "dartls" }
      for _, server_name in ipairs(servers) do
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end
    end
  },

  -- [[ Formatting and Linting ]]
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
          python = { "ruff_format" },
          lua = { "stylua" },
          dart = { "dart_format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        python = { 'ruff' },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  },

  -- [[ Git Integration ]]
  { 'tpope/vim-fugitive' },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  { "APZelos/blamer.nvim", config = function() vim.g.blamer_enabled = true end },


  -- [[ UI Enhancements ]]
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'tokyonight'
        }
      })
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup()
    end
  },
  { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
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
      })
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        ERROR = { icon = " ", color = "error" },
        TODO = { icon = " ", color = "info" },
        WARNING = { icon = " ", color = "warning" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- [[ Debugging ]]
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },

  -- [[ Other Utility Plugins ]]
  { 'tpope/vim-surround' },
  { 'tpope/vim-commentary' },
  { 'numToStr/Comment.nvim', opts = {} },
  { "christoomey/vim-tmux-navigator" },
  { "chenasraf/text-transform.nvim", version = "*" },
  { "mistricky/codesnap.nvim", build = "make build_generator" },
  { 'mattn/emmet-vim' },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    ft = "python",
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
    opts = {},
  },

  -- [[ AI & Completion ]]
  { "e3oroush/askCode", config = function() require("askCode").setup() end },
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function() require("neocodeium").setup() end
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function() require("supermaven-nvim").setup({})
    end,
  },
  { 'github/copilot.vim' },

}, {})

-- [[ Keymappings ]]

-- File operations
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open current file in explorer' })
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n','<leader>g', ':Telescope live_grep<CR>', { desc = 'Find text' })
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>h', ':Telescope help_tags<CR>', { desc = 'Find help' })
vim.keymap.set('n', '<leader>r', ':Telescope oldfiles<CR>', { desc = 'Find recent files' })
vim.keymap.set('n', '<leader>s', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { desc = 'Save file (insert mode)' })

-- Git
vim.keymap.set('n', '<leader>gg', ':G<CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })

-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find references' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = 'Format code (LSP)' })

-- Diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })

-- Debugging
vim.keymap.set('n', '<leader>dt', function() require('dapui').toggle() end, { desc = 'Toggle DAP UI' })
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'DAP Continue' })
vim.keymap.set('n', '<leader>do', function() require('dap').step_over() end, { desc = 'DAP Step Over' })
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = 'DAP Step Into' })
vim.keymap.set('n', '<leader>du', function() require('dap').step_out() end, { desc = 'DAP Step Out' })
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'DAP Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.toggle() end, { desc = 'DAP Toggle REPL' })

-- Other
vim.keymap.set("n", "<leader>cA", function()
    require("text-transform").actions.change_case_telescope()
end, { desc = "Change Case" })
vim.keymap.set("v", "<leader>ae", ":AskCodeExplain<CR>")
vim.keymap.set("v", "<leader>ab", ":AskCode \"Find potential bugs\"<CR>")
vim.keymap.set("v", "<leader>ad", ":AskCodeAddDocstring<CR>")
vim.keymap.set("v", "<leader>ar", ":AskCodeReplace \"Refactor this code\"<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
vim.keymap.set('v', '<leader>cs', '<cmd>CodeSnap<cr>', { desc = 'Code snap' })
vim.keymap.set('n', '<leader>m', ':MarkdownPreviewToggle<CR>', { desc = 'Toggle markdown preview' })
vim.keymap.set('n', '<leader>nl', ':nohl<CR>', { desc = 'Clear search highlights' })

-- VSCode-like keybindings
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })
vim.keymap.set('n', '<C-y>', '<C-r>', { desc = 'Redo' })

-- Completion setup
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args) 
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})
