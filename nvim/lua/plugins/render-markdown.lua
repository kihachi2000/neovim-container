return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        "nvim-tree/nvim-web-devicons",
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        heading = {
            enabled = true,
            sign = false,
            position = "inline",
            icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
            backgrounds = {
                "RenderMarkdownH1Bg",
                "RenderMarkdownH2Bg",
                "RenderMarkdownH3Bg",
                "RenderMarkdownH4Bg",
                "RenderMarkdownH5Bg",
                "RenderMarkdownH6Bg",
            },
        },
        code = {
            enabled = true,
            sign = false,
            style = "full",
            position = "left",
            width = "full",
            left_pad = 2,
            right_pad = 2,
            border = "thin",
            language_pad = 1,
        },
        bullet = {
            enabled = true,
            icons = { "●", "○", "◆", "◇" },
            left_pad = 0,
        },
        checkbox = {
            enabled = true,
            unchecked = {
                icon = "󰄱 ",
                highlight = "RenderMarkdownUnchecked",
            },
            checked = {
                icon = "󰱒 ",
                highlight = "RenderMarkdownChecked",
            },
        },
        quote = {
            enabled = true,
            icon = "▎",
            repeat_linebreak = true,
        },
        pipe_table = {
            enabled = true,
            preset = "round",
            style = "full",
        },
        link = {
            enabled = true,
            image = "󰥶 ",
            hyperlink = "󰌷 ",
        },
    },

}
