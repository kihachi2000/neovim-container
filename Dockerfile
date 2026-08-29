ARG NVIM_VERSION=v0.12.5
ARG NVIM_SHA256_X86_64=bce0f56eda1f1b1db6eee8f4133d7a38813ea07933837dd1777411ca384c6875
ARG NVIM_SHA256_ARM64=1aa5ca085249580ae0f91eb14f27ec0919773ff2d99a163d03f3d6c21ac29725

FROM debian:bookworm-slim

ARG NVIM_VERSION
ARG NVIM_SHA256_X86_64
ARG NVIM_SHA256_ARM64
ARG TARGETARCH

ENV HOME=/tmp/nvim-home \
    XDG_CONFIG_HOME=/tmp/nvim-home/.config

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        ripgrep; \
    case "${TARGETARCH}" in \
        amd64) NVIM_ARCH="x86_64"; SHA256="${NVIM_SHA256_X86_64}" ;; \
        arm64) NVIM_ARCH="arm64";  SHA256="${NVIM_SHA256_ARM64}" ;; \
        *)     echo "Unsupported architecture: ${TARGETARCH}" >&2; exit 1 ;; \
    esac; \
    curl -fsSL "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz" \
        -o /tmp/nvim.tar.gz; \
    echo "${SHA256}  /tmp/nvim.tar.gz" | sha256sum -c; \
    tar -xzf /tmp/nvim.tar.gz -C /usr/local --strip-components=1; \
    rm /tmp/nvim.tar.gz; \
    mkdir -p "${XDG_CONFIG_HOME}" "${HOME}/.local/share/nvim" "${HOME}/.local/state/nvim" "${HOME}/.cache/nvim"; \
    chmod 0755 "${HOME}" "${XDG_CONFIG_HOME}"; \
    chmod -R 0777 "${HOME}/.local" "${HOME}/.cache"; \
    apt-get purge -y curl; \
    apt-get autoremove -y; \
    rm -rf /var/lib/apt/lists/*

COPY dotfiles/nvim ${XDG_CONFIG_HOME}/nvim

ENTRYPOINT ["nvim"]
