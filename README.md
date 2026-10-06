# neovim-container

Neovim 実行専用の Docker コンテナ。  
コンテナイメージを呼び出すためのスクリプトは [kihachi2000/nv](https://github.com/kihachi2000/nv) で管理されている。

## Neovimについて

### ソフトウェア情報

| ソフトウェア | 情報 |
| ---------- | ---- |
| Neovim | v0.12.5 |
| ベースイメージ | debian:trixie-slim |
| 同梱コマンド | `git` / `curl` / `rg` / `markdown-oxide` |

### プラグイン

| リポジトリ | バージョン |
| ---------- | ---------- |
| folke/lazy.nvim | stable |
| cohama/lexima.vim | latest |
| nvim-lualine/lualine.nvim | latest |
| nvim-tree/nvim-web-devicons | latest |
| nvim-telescope/telescope.nvim | v0.2.2 |
| nvim-lua/plenary.nvim | latest |
| MeanderingProgrammer/render-markdown.nvim | latest |
| nvim-treesitter/nvim-treesitter | latest |
| lukas-reineke/indent-blankline.nvim | latest |
| kihachi2000/yash.nvim | dev |
| neovim/nvim-lspconfig | latest |
| smoka7/hop.nvim | * |
| Kenbayashi/retrieve.nvim | latest |
| hrsh7th/nvim-cmp | latest |
| hrsh7th/cmp-nvim-lsp | latest |
| hrsh7th/cmp-buffer | latest |
| hrsh7th/cmp-path | latest |
| hrsh7th/cmp-cmdline | latest |
| hrsh7th/cmp-nvim-lua | latest |
| hrsh7th/cmp-vsnip | latest |
| hrsh7th/vim-vsnip | latest |
| hrsh7th/vim-vsnip-integ | latest |
| kylechui/nvim-surround | * |
| nvim-telescope/telescope-file-browser.nvim | latest |
| nvimtools/none-ls.nvim | latest |
| EdenEast/nightfox.nvim | latest |
