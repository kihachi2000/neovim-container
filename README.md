# neovim-container

Neovim 実行専用の Docker コンテナ。  
Neovim の設定ファイルは [kihachi2000/dotfiles](https://github.com/kihachi2000/dotfiles) のものを利用。

## 使い方

`bin/` にパスを通し、以下のコマンドを実行する。

```sh
nvim [オプション] [対象ファイル]
```

デバッグ用途で別の Neovim 設定ディレクトリを利用する場合は、`nv-debug` を使う。

```sh
nv-debug --config-dir "$HOME/git/dotfiles/nvim" [neovim対象ディレクトリ]
```
