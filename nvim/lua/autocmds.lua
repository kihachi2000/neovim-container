-- CursorHoldが発火するまでの時間
vim.opt.updatetime = 200
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        if not require("cmp").visible() then
            vim.diagnostic.open_float(0, { scope = "cursor", focus = false })
        end
    end,
})

-- ターミナルを開いたらinsertモードに入る
vim.api.nvim_create_autocmd(
    "TermOpen",
    {
        pattern = "*",
        command = "startinsert",
    }
)

-- ターミナルモードでは行番号を非表示
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.api.nvim_buf_set_option(0, "number", false)
        vim.api.nvim_buf_set_option(0, "relativenumber", false)
    end
})
