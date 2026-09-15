local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, {
    workspace = {
        didChangeWatchedFiles = {
            dynamicRegistration = true,
        },
    },
})

vim.lsp.config("markdown_oxide", {
    cmd = { "/usr/local/lib/nvim/lsp/markdown-oxide" },
    filetypes = { "markdown" },
    root_markers = { ".git", ".obsidian", ".moxide.toml" },
    capabilities = capabilities,
})
vim.lsp.enable("markdown_oxide")
