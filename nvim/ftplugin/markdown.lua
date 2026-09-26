local lexima_cr = "<C-r>=lexima#expand('<LT>CR>', 'i')<CR>"

local function continue_list()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]

    if col ~= #line then
        return lexima_cr
    end

    if line:match("^%s*[-+*]%s+.+$") then
        local marker = line:match("^%s*([-+*])%s+")
        return lexima_cr .. marker .. " "
    end

    local number, delimiter = line:match("^%s*(%d+)([.)])%s+.+$")
    if number ~= nil then
        return lexima_cr .. tostring(tonumber(number) + 1) .. delimiter .. " "
    end

    return lexima_cr
end

vim.keymap.set("i", "<CR>", continue_list, { buffer = true, expr = true })
