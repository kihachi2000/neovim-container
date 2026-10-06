local lexima_cr = "<C-r>=lexima#expand('<LT>CR>', 'i')<CR>"

vim.keymap.set("i", "<CR>", function()
    return lexima_cr .. "<cmd>AutolistNewBullet<cr>"
end, { buffer = true, expr = true })
