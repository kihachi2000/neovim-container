if vim.fn.has("win64") == 1 then
    vim.g.python3_host_prog = os.getenv("HOME")
        .. "/AppData/Local/Programs/Python/Python39/python.exe"
end

if vim.fn.has("unix") == 1 then
    vim.g.python3_host_prog = "/usr/bin/python3"
end
