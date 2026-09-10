return {
    "Kenbayashi/retrieve.nvim",
    config = function()
        require("retrieve").setup()
        vim.keymap.set("n", "m", "<Plug>retrieve-set", { noremap = false })
        vim.keymap.set("n", "M", "<Plug>retrieve-return", { noremap = false })
    end,
}
