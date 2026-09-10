return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
        local options = {}
        options.theme = "yash"

        local diagnostics = { "diagnostics" }
        diagnostics.sources = { "nvim_diagnostic" }
        diagnostics.sections = { "error", "warn" }
        diagnostics.diagnostics_color = {}
        diagnostics.diagnostics_color.error = "LualineError"
        diagnostics.diagnostics_color.warn = "LualineWarning"
        diagnostics.symbols = {}
        diagnostics.symbols.error = "E"
        diagnostics.symbols.warn = "W"
        diagnostics.colored = true
        diagnostics.update_in_insert = false
        diagnostics.always_visible = false

        local sections = {}
        sections.lualine_a = { "mode" }
        sections.lualine_b = { "branch", diagnostics }
        sections.lualine_c = { "filename" }
        sections.lualine_x = { "encoding" }
        sections.lualine_y = { "progress" }
        sections.lualine_z = { "location" }

        local error_fg = "#f72922"
        local warn_fg = "#f98022"
        local light_gray = "#d0d0d0"
        vim.api.nvim_set_hl(0, "LualineError", { fg = error_fg, bg = light_gray })
        vim.api.nvim_set_hl(0, "LualineWarning", { fg = warn_fg, bg = light_gray })

        require("lualine").setup({
            options = options,
            sections = sections,
        })
    end,
}
