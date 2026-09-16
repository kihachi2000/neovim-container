return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "hrsh7th/vim-vsnip-integ",
    },
    config = function()
        local cmp = require("cmp")
        local project_path_source = {}
        local project_path_cache = {}
        local project_path_pending_callbacks = {}

        local function get_project_root(bufnr)
            local buffer_name = vim.api.nvim_buf_get_name(bufnr)
            local start_path = buffer_name ~= "" and vim.fs.dirname(buffer_name) or vim.fn.getcwd()
            local git_dir = vim.fs.find(".git", { path = start_path, upward = true })[1]

            if git_dir then
                return vim.fs.dirname(git_dir)
            end

            return vim.fn.getcwd()
        end

        local function build_project_path_items(stdout)
            local items = {}
            local seen_directories = {}

            local function add_directory_items(path)
                local directory = ""

                for segment in path:gmatch("([^/]+)/") do
                    directory = directory .. segment .. "/"

                    if not seen_directories[directory] then
                        seen_directories[directory] = true
                        table.insert(items, {
                            label = directory,
                            filterText = directory,
                            insertText = directory,
                            kind = cmp.lsp.CompletionItemKind.Folder,
                        })
                    end
                end
            end

            for path in stdout:gmatch("[^\r\n]+") do
                add_directory_items(path)
                table.insert(items, {
                    label = path,
                    filterText = path,
                    insertText = path,
                    kind = cmp.lsp.CompletionItemKind.File,
                })
            end

            table.sort(items, function(left, right)
                return left.label < right.label
            end)

            return items
        end

        local function get_project_path_items(root, callback)
            if project_path_cache[root] then
                callback(project_path_cache[root])
                return
            end

            if project_path_pending_callbacks[root] then
                table.insert(project_path_pending_callbacks[root], callback)
                return
            end

            project_path_pending_callbacks[root] = { callback }

            vim.system({ "rg", "--files", "--hidden", "--glob", "!.git" }, { cwd = root, text = true }, function(result)
                local items = {}

                if result.code == 0 then
                    items = build_project_path_items(result.stdout)
                end

                project_path_cache[root] = items

                for _, pending_callback in ipairs(project_path_pending_callbacks[root]) do
                    pending_callback(items)
                end

                project_path_pending_callbacks[root] = nil
            end)
        end

        function project_path_source.new()
            return setmetatable({}, { __index = project_path_source })
        end

        function project_path_source.get_keyword_pattern()
            return "[^[:blank:]]\\+"
        end

        function project_path_source.complete(_, params, callback)
            if vim.fn.executable("rg") ~= 1 then
                return callback({ items = {} })
            end

            local cursor_before_line = params.context.cursor_before_line
            if not cursor_before_line:match("^%s*%S+%s+") then
                return callback({ items = {} })
            end

            get_project_path_items(get_project_root(params.context.bufnr), function(items)
                callback({
                    items = items,
                    isIncomplete = false,
                })
            })
        end

        cmp.register_source("project_path", project_path_source.new())

        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),

            sources = cmp.config.sources({
                { name = "vsnip" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
            }, {
                { name = "buffer" },
            }),
        })

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "project_path" },
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
    end,
}
