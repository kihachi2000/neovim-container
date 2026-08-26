# neovim-container

Neovim 実行専用の Docker コンテナ。  
Neovim の設定ファイルは [kihachi2000/dotfiles](https://github.com/kihachi2000/dotfiles) のものを利用。

## 使い方

`bin/` にパスを通し、以下のコマンドを実行する。

```sh
nvim [オプション] [対象ファイル]
```

### `--config-dir` オプション

Neovim の設定ディレクトリをホスト側のパスで上書きできる。

```sh
nvim --config-dir $HOME/git/dotfiles/nvim [オプション] [対象ファイル]
```

指定したディレクトリはコンテナ内の Neovim 設定ディレクトリとしてマウントされる。
