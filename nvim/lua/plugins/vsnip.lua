return {
    "hrsh7th/vim-vsnip",
    config = function()
        local vsnip_tab = function()
            if vim.fn["vsnip#available"](1) == 1 then
                local key = vim.api.nvim_replace_termcodes(
                    "<Plug>(vsnip-jump-next)",
                    true,
                    true,
                    true
                )

                vim.api.nvim_feedkeys(key, "n", true)
            else
                local key = vim.api.nvim_replace_termcodes("<Tab>", true, true, true)

                vim.api.nvim_feedkeys(key, "n", true)
            end
        end

        local vsnip_shift_tab = function()
            if vim.fn["vsnip#available"](-1) == 1 then
                local key = vim.api.nvim_replace_termcodes(
                    "<Plug>(vsnip-jump-prev)",
                    true,
                    true,
                    true
                )

                vim.api.nvim_feedkeys(key, "n", true)
            else
                local key = vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)

                vim.api.nvim_feedkeys(key, "n", true)
            end
        end

        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        keymap("i", "<Tab>", vsnip_tab, opts)
        keymap("s", "<Tab>", vsnip_tab, opts)
        keymap("i", "<S-Tab>", vsnip_shift_tab, opts)
        keymap("s", "<TS-ab>", vsnip_shift_tab, opts)

        --vim.g.vsnip_filetypes = {}
        --vim.g.vsnip_filetypes.typescriptreact = {'typescript'}
    end,
}
