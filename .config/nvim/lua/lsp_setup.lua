-- LSP settings
-- local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Helper function to setup LSP servers
local function setup_server(server_name)
        require('lspconfig')[server_name].setup {
        capabilities = capabilities,
    }
end

-- Language servers to be installed
local servers = {
    -- Rust
    'rust_analyzer',
    -- Python
    'pyright',
    -- Java
    'jdtls',
    -- JavaScript/TypeScript
    'ts_ls',
    -- Dart
    'dartls',
    -- Go
    'gopls',
    -- Other useful servers
    'cssls', 
    'html', 
    'jsonls', 
    'tailwindcss',
    'svelte',
    'volar',
    'lua_ls', 
    'bashls', 
    'dockerls', 
    'ruff'
}

-- Setup the servers
for _, server_name in ipairs(servers) do
    setup_server(server_name)
end