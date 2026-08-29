# Copilot 向け指示

## リポジトリ概要

Neovim 実行用コンテナを生成する Dockerfile と、その周辺ツールを管理するリポジトリ。

## 更新時の規約

- 日本語で対応すること。
- Dockerfile は軽量さを優先した構成にすること。
- Dockerfile 更新時は、CI も更新すること。

## CI 確認項目

CI では以下を確認すること。

- neovim を起動できること（`nvim --headless '+qa'` が成功すること）。
- neovim が依存するソフトウェアを起動できること。
  - `〇〇 --version` 等で起動確認を行うこと。

## コミットメッセージのルール（Conventional Commits 準拠）

コミットメッセージは以下の形式に従うこと。

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### type（必須）

| type | 用途 |
|------|------|
| `feat` | 新機能の追加 |
| `fix` | バグ修正 |
| `docs` | ドキュメントのみの変更 |
| `style` | コードの動作に影響しない変更（空白、フォーマット等） |
| `refactor` | バグ修正でも新機能追加でもないコードの変更 |
| `test` | テストの追加・修正 |
| `chore` | ビルドプロセスや補助ツールの変更 |
| `ci` | CI 設定ファイルの変更 |
| `perf` | パフォーマンス改善 |
| `revert` | 以前のコミットの取り消し |

### ルール

- `description` は小文字で始め、末尾にピリオドを付けない。
- 破壊的変更がある場合は `type` の後に `!` を付ける（例: `feat!: ...`）、または footer に `BREAKING CHANGE: <説明>` を記載する。
- `scope` はオプションで、変更対象のモジュールや範囲を括弧内に記述する（例: `fix(docker): ...`）。
- `body` はオプションで、変更の背景や理由を記述する。
- `footer` はオプションで、`BREAKING CHANGE` や Issue 参照（`Closes #123` 等）を記述する。

### 例

```
feat(docker): add neovim nightly build support

Closes #10
```

```
fix: correct base image tag

Previously used an outdated tag that caused build failures.
```

```
chore!: drop support for ubuntu 20.04

BREAKING CHANGE: minimum supported base image is now ubuntu 22.04
```
