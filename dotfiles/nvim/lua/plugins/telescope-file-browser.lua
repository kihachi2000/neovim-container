return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        -- キー設定
        vim.api.nvim_set_keymap(
            "n",
            "<Tab>",
            "<cmd>Telescope file_browser<CR>",
            { noremap = true }
        )
    end,
}
