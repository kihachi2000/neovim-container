-- yash読み込み
vim.opt.runtimepath:append("$HOME/git/yash")

local function set_colorscheme(name)
    if vim.g.colors_name == name then
        return
    end
    vim.cmd.colorscheme(name)
end

set_colorscheme("yash")

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function(args)
        if vim.bo[args.buf].filetype == "markdown" then
            set_colorscheme("flexoki-light")
            return
        end
        set_colorscheme("yash")
    end,
})
