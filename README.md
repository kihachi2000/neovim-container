# neovim-container

Neovim 実行専用の Docker コンテナ。  
Neovim の設定ファイルは `nvim/` で管理している。

## 使い方

`bin/` にパスを通し、以下のコマンドを実行する。

```sh
nv [オプション] [編集対象ファイル]
```

`NVIM_CONTAINER_TAG` 環境変数を設定すると、`ghcr.io/kihachi2000/neovim-container:<tag>` を利用できる。未設定時は `latest` を使う。

デバッグ用途で別の Neovim 設定ディレクトリを利用する場合は、`nv-debug` を使う。

```sh
nv-debug <init.luaのあるディレクトリ> [-- [neovimオプション] [編集対象ファイル]]
```
