-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
}

-- cland config
lspconfig.clangd.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
        "--all-scopes-completion",
        "--suggest-missing-includes",
        "--completion-style=detailed",
        "--offset-encoding=utf-16",
        "--header-insertion=never",
    },
}
