# neovim-container

Neovim 実行専用の Docker コンテナ。  
Neovim の設定ファイルは `nvim/` で管理している。

## 使い方

`bin/` にパスを通し、以下のコマンドを実行する。

```sh
nv [オプション] [編集対象ファイル]
```

`NVIM_CONTAINER_TAG` 環境変数を設定すると、`ghcr.io/kihachi2000/neovim-container:<tag>` を利用できる。未設定時は `latest` を使う。

コンテナ内でデバッグ用途の `bash` を起動する場合は、`nv-debug` を使う。

```sh
nv-debug [bashオプション]
```

## Neovimについて

### ソフトウェア情報

| ソフトウェア | 情報 |
| ---------- | ---- |
| Neovim | v0.12.5 |
| ベースイメージ | debian:trixie-slim |
| 同梱コマンド | `git` / `curl` / `rg` |

### プラグイン

| リポジトリ | バージョン |
| ---------- | ---------- |
| folke/lazy.nvim | stable |
| cohama/lexima.vim | latest |
| nvim-lualine/lualine.nvim | latest |
| nvim-tree/nvim-web-devicons | latest |
| nvim-telescope/telescope.nvim | 0.1.8 |
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
