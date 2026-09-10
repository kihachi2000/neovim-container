return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "OddIndent", { bg = "#11162c", nocombine = true })
            vim.api.nvim_set_hl(0, "EvenIndent", { bg = "#181f3e", nocombine = true })
        end)

        local highlight_list = {
            "OddIndent",
            "EvenIndent",
        }

        require("ibl").setup({
            indent = { highlight = highlight_list, char = "" },
            whitespace = { highlight = highlight_list, remove_blankline_trail = false },
            scope = { enabled = false },
        })
    end,
}
