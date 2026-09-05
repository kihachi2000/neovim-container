#!/usr/bin/env bash
set -euo pipefail

# Environment:
#   TREE_SITTER_CLI_VERSION

clone_and_build() {
    local parser_name="$1"
    local repository="$2"
    local repository_path="/tmp/tree-sitter-${parser_name}"
    local parser_path="${repository_path}"

    git clone "${repository}" "${repository_path}"
    if [[ -d "${repository_path}/${parser_name}" ]]; then
        parser_path="${repository_path}/${parser_name}"
    fi

    tree-sitter build -o "/parser/${parser_name}.so" "${parser_path}"

    if [[ -d "${parser_path}/queries" ]]; then
        mv "${parser_path}/queries" "/queries/${parser_name}"
    else
        # fallback for typescript and tsx
        mv "${repository_path}/queries" "/queries/${parser_name}"
    fi

    rm -rf "${repository_path}"
}

# Preparation
curl \
    -L \
    --proto "=https" \
    --tlsv1.2 \
    -sSf \
    https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall tree-sitter-cli --version "${TREE_SITTER_CLI_VERSION}"
mkdir /parser
mkdir /queries


# Build
clone_and_build bash        https://github.com/tree-sitter/tree-sitter-bash.git
clone_and_build c           https://github.com/tree-sitter/tree-sitter-c.git
clone_and_build capnp       https://github.com/tree-sitter-grammars/tree-sitter-capnp.git
clone_and_build cmake       https://github.com/uyha/tree-sitter-cmake.git
clone_and_build cpp         https://github.com/tree-sitter/tree-sitter-cpp.git
clone_and_build css         https://github.com/tree-sitter/tree-sitter-css.git
clone_and_build csv         https://github.com/tree-sitter-grammars/tree-sitter-csv.git
clone_and_build dart        https://github.com/UserNobody14/tree-sitter-dart.git
clone_and_build dockerfile  https://github.com/camdencheek/tree-sitter-dockerfile.git
clone_and_build gitcommit   https://github.com/gbprod/tree-sitter-gitcommit.git
clone_and_build haskell     https://github.com/tree-sitter-grammars/tree-sitter-haskell.git
clone_and_build html        https://github.com/tree-sitter/tree-sitter-html.git
clone_and_build javascript  https://github.com/tree-sitter/tree-sitter-javascript.git
clone_and_build json        https://github.com/tree-sitter/tree-sitter-json.git
clone_and_build json5       https://github.com/Joakker/tree-sitter-json5.git
clone_and_build just        https://github.com/IndianBoy42/tree-sitter-just.git
clone_and_build luadoc      https://github.com/tree-sitter-grammars/tree-sitter-luadoc.git
clone_and_build make        https://github.com/tree-sitter-grammars/tree-sitter-make.git
clone_and_build python      https://github.com/tree-sitter/tree-sitter-python.git
clone_and_build regex       https://github.com/tree-sitter/tree-sitter-regex.git
clone_and_build rust        https://github.com/tree-sitter/tree-sitter-rust.git
clone_and_build toml        https://github.com/tree-sitter-grammars/tree-sitter-toml.git
clone_and_build tsx         https://github.com/tree-sitter/tree-sitter-typescript.git
clone_and_build typescript  https://github.com/tree-sitter/tree-sitter-typescript.git
clone_and_build vim         https://github.com/tree-sitter-grammars/tree-sitter-vim.git
clone_and_build vimdoc      https://github.com/neovim/tree-sitter-vimdoc.git
clone_and_build yaml        https://github.com/tree-sitter-grammars/tree-sitter-yaml.git
