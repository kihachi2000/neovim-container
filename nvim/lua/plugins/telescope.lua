vim.keymap.set(
    "n",
    "<C-p>",
    "<cmd>Telescope find_files theme=dropdown<CR>",
    { noremap = false }
)
vim.keymap.set(
    "n",
    "<C-g>",
    "<cmd>Telescope live_grep theme=dropdown<CR>",
    { noremap = false }
)
vim.keymap.set(
    "n",
    "<C-b>",
    "<cmd>Telescope buffers theme=dropdown<CR>",
    { noremap = false }
)

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    depencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local actions = require("telescope.actions")
        local fb_actions = require("telescope").extensions.file_browser.actions

        require("telescope").setup({
            defaults = {
                theme = require("telescope.themes").get_dropdown(),
                preview = false,
                prompt_prefix = "  ",
                initial_mode = "insert",
                mappings = {
                    ["i"] = {
                        ["<CR>"] = { "<ESC>", type = "command" },
                        ["<S-CR>"] = actions.select_default,
                    },
                    ["n"] = {
                        ["<Tab>"] = false,
                        ["<S-Tab>"] = false,
                        ["l"] = actions.select_default,
                        ["<CR>"] = actions.select_vertical,
                    },
                },
            },
            pickers = {
                find_files = {
                    mappings = {
                        ["n"] = {
                            ["C-p"] = actions.close,
                        },
                    },
                },
                live_grep = {
                    mappings = {
                        ["n"] = {
                            ["C-g"] = actions.close,
                        },
                    },
                },
                buffers = {
                    mappings = {
                        ["n"] = {
                            ["C-b"] = actions.close,
                        },
                    },
                },
            },
            extensions = {
                file_browser = {
                    path = "%:p:h",
                    theme = "dropdown",
                    initial_mode = "normal",
                    hide_parent_dir = true,
                    hijack_netrw = true,
                    display_stat = { mode = true, size = false, date = true },
                    --git_status = false,
                    mappings = {
                        ["i"] = {
                            ["<Tab>"] = actions.close,
                        },
                        ["n"] = {
                            ["<Tab>"] = actions.close,
                            ["h"] = fb_actions.goto_parent_dir,
                            ["l"] = actions.select_default,
                            ["m"] = fb_actions.change_cwd,
                            ["M"] = fb_actions.goto_cwd,
                            ["."] = fb_actions.toggle_hidden,
                            ["<S-Tab>"] = false,
                            ["<CR>"] = actions.select_vertical,
                        },
                    },
                },
            },
        })

        require("telescope").load_extension("file_browser")
    end,
}
