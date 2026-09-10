return {
	"neovim/nvim-lspconfig",
 cond = false,
	config = function()
		-- キーコンフィグ
		vim.keymap.set("n", "<Leader>i", vim.lsp.buf.hover, { noremap = true, silent = true })
		vim.keymap.set("n", "<Leader>d", vim.lsp.buf.definition, { noremap = true, silent = true })
		vim.keymap.set("n", "<Leader>D", vim.lsp.buf.declaration, { noremap = true, silent = true })
		vim.keymap.set("n", "<Leader>m", vim.lsp.buf.format, { noremap = true, silent = true })
		--vim.api.nvim_set_keymap("n", "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true})
		--vim.api.nvim_set_keymap("n", "<Leader>e", "<cmd>lua vim.lsp.buf.diagnostic.show_line_diagnostics()<CR>", {noremap = true, silent = true})

		-- カラースキーム上書き
		--sign define DiagnosticSignError text= texthl= linehl=DiagnosticLineError numhl=DiagnosticLineNrError
		--sign define DiagnosticSignWarn text= texthl= linehl=DiagnosticLineWarn numhl=DiagnosticLineNrWarn
		--sign define DiagnosticSignHint text= texthl= linehl=DiagnosticLineHint numhl=DiagnosticLineNrHint
		--sign define DiagnosticSignInfo text= texthl= linehl=DiagnosticLineInfo numhl=DiagnosticLineNrInfo

		-- lsp本体の設定
		local nvim_lsp = vim.lspconfig
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		local opts = {}
		opts.capabilities = capabilities

		-- LSPのhighlight機能を無効化する
		-- treesitterを使うため必要ない
		opts.on_attach = function(client, _)
			client.server_capabilities.semanticTokensProvider = nil
		end

		--[[
        mason_lspconfig.setup_handlers({
            function(server_name)
                local opts = {}
                opts.capabilities = capabilities

                -- LSPのhighlight機能を無効化する
                -- treesitterを使うため必要ない
                opts.on_attach = function(client, _)
                    client.server_capabilities.semanticTokensProvider = nil
                end

                if server_name == "jdtls" and false then
                    opts.cmd = {
                        "java",
                        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                        "-Dosgi.bundles.defaultStartLevel=4",
                        "-Declipse.product=org.eclipse.jdt.ls.core.product",
                        "-Dlog.protocol=true",
                        "-Dlog.level=ALL",
                        "-Xms1g",
                        "--add-modules=ALL-SYSTEM",
                        "--add-opens",
                        "java.base/java.util=ALL-UNNAMED",
                        "--add-opens",
                        "java.base/java.lang=ALL-UNNAMED",
                        "-jar",
                        "C:\\Java\\jdt-language-server-1.14.0\\plugins\\org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
                        "-configuration",
                        "C:\\Java\\jdt-language-server-1.14.0\\config_win",
                        "-data",
                        vim.loop.os_homedir() .. "\\workspace",
                    }
                end

                if server_name == "lua_ls" then
                    opts.settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    }
                end

                nvim_lsp[server_name].setup(opts)
            end,
        })
        ]]

		--nvim_lsp.sourcekit.setup({ capabilities = capabilities })
		nvim_lsp.ccls.setup(opts)
		nvim_lsp.rust_analyzer.setup(opts)
		nvim_lsp.jdtls.setup(opts)
		nvim_lsp.lua_ls.setup({
			capabilities = opts.capabilities,
			on_attach = opts.on_attach,
			setting = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
		nvim_lsp.rust_analyzer.setup(opts)
		nvim_lsp.ts_ls.setup(opts)
		nvim_lsp.hls.setup(opts)
		--nvim_lsp.gopls.setup({capabilities = capabilities})
		--nvim_lsp.html.setup({capabilities = capabilities})
		--nvim_lsp.cssls.setup({capabilities = capabilities})
		--nvim_lsp.jsonls.setup({capabilities = capabilities})
	end,
}
