ARG NVIM_VERSION=v0.12.5
ARG NVIM_SHA256_X86_64=bce0f56eda1f1b1db6eee8f4133d7a38813ea07933837dd1777411ca384c6875
ARG NVIM_SHA256_ARM64=1aa5ca085249580ae0f91eb14f27ec0919773ff2d99a163d03f3d6c21ac29725
ARG TREE_SITTER_CLI_VERSION=0.27.0

FROM rust:slim-trixie AS tree-sitter-builder

ARG TREE_SITTER_CLI_VERSION

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends curl; \
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash; \
    cargo binstall tree-sitter-cli --version "${TREE_SITTER_CLI_VERSION}" --root /out

FROM debian:trixie-slim

ARG NVIM_VERSION
ARG NVIM_SHA256_X86_64
ARG NVIM_SHA256_ARM64
ARG TARGETARCH

ENV HOME=/tmp/nvim-home \
    XDG_CONFIG_HOME=/tmp/nvim-home/.config

COPY scripts/install_neovim.sh /usr/local/bin/install_neovim.sh

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        ripgrep; \
    rm -rf /var/lib/apt/lists/*; \
    bash /usr/local/bin/install_neovim.sh

COPY --from=tree-sitter-builder /out/bin/tree-sitter /usr/local/bin/tree-sitter

COPY dotfiles/nvim ${XDG_CONFIG_HOME}/nvim

RUN nvim --headless "+Lazy! sync" "+TSInstall all" "+qa"; \
    chmod 1777 -R "${HOME}"

ENTRYPOINT ["nvim"]
