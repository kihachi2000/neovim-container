#!/usr/bin/env bash
set -euo pipefail

# Environment:
#   NVIM_VERSION
#   NVIM_SHA256_X86_64
#   NVIM_SHA256_ARM64
#   TARGETARCH

case "${TARGETARCH}" in
    amd64) NVIM_ARCH="x86_64"; SHA256="${NVIM_SHA256_X86_64}" ;;
    arm64) NVIM_ARCH="arm64";  SHA256="${NVIM_SHA256_ARM64}" ;;
    *)     echo "Unsupported architecture: ${TARGETARCH}" >&2; exit 1 ;;
esac
curl -fsSL "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz" \
    -o /tmp/nvim.tar.gz
echo "${SHA256}  /tmp/nvim.tar.gz" | sha256sum -c
tar -xzf /tmp/nvim.tar.gz -C /usr/local --strip-components=1
rm /tmp/nvim.tar.gz
