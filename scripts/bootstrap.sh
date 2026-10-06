#!/usr/bin/env bash
set -euo pipefail

# Bootstrap host dependencies for this Neovim configuration.
# Idempotent: safe to run multiple times. Arch/Omarchy oriented, mise-based runtimes.

DO_CSHARP=0
DO_RUST=0
DO_LATEX=0

usage() {
    cat <<'EOF'
Usage: scripts/bootstrap.sh [options]

  --csharp   Install the .NET SDK (dotnet-sdk) for Roslyn / csharpier
  --rust     Install Rust (rustup) for cargo-based tooling
  --latex    Install tectonic for LaTeX rendering in snacks.image
  --all      Enable all optional components above
  -h, --help Show this help
EOF
}

for arg in "$@"; do
    case "$arg" in
        --csharp) DO_CSHARP=1 ;;
        --rust) DO_RUST=1 ;;
        --latex) DO_LATEX=1 ;;
        --all) DO_CSHARP=1; DO_RUST=1; DO_LATEX=1 ;;
        -h|--help) usage; exit 0 ;;
        *) echo "Unknown option: $arg" >&2; usage >&2; exit 1 ;;
    esac
done

log() { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$*" >&2; }
have() { command -v "$1" >/dev/null 2>&1; }

if have pacman; then
    log "Installing base system packages"
    sudo pacman -S --needed --noconfirm \
        git curl unzip wget tree-sitter ripgrep fd lazygit python python-pip
else
    warn "pacman not found; install manually: git curl unzip wget tree-sitter ripgrep fd lazygit python python-pip"
fi

log "Ensuring mise is available"
if ! have mise; then
    if have pacman; then
        sudo pacman -S --needed --noconfirm mise
    else
        curl -fsSL https://mise.run | sh
        export PATH="$HOME/.local/bin:$PATH"
    fi
fi

log "Installing runtimes via mise (node, go)"
eval "$(mise activate bash)"
mise use -g node@latest go@latest

log "Installing Go language tools (gopls, gofumpt, goimports)"
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
mise reshim

log "Installing Neovim host providers (node, python)"
npm install -g neovim
if have pacman; then
    sudo pacman -S --needed --noconfirm python-pynvim
elif have pip; then
    pip install --user pynvim
fi

if [ "$DO_CSHARP" -eq 1 ]; then
    log "Installing .NET SDK"
    if have pacman; then
        sudo pacman -S --needed --noconfirm dotnet-sdk
    else
        warn "Install the .NET SDK manually: https://dotnet.microsoft.com/download"
    fi
fi

if [ "$DO_RUST" -eq 1 ]; then
    log "Installing Rust toolchain"
    if ! have rustup; then
        if have pacman; then
            sudo pacman -S --needed --noconfirm rustup
        else
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            export PATH="$HOME/.cargo/bin:$PATH"
        fi
    fi
    rustup default stable
fi

if [ "$DO_LATEX" -eq 1 ]; then
    log "Installing tectonic"
    if have pacman; then
        sudo pacman -S --needed --noconfirm tectonic
    else
        warn "Install tectonic manually: https://tectonic-typesetting.github.io"
    fi
fi

if have nvim; then
    log "Installing Lazy plugins and Mason tools"
    nvim --headless "+Lazy! sync" +qa || warn "headless sync failed; open nvim and run :Lazy sync"
else
    warn "nvim not found; install it and run: nvim --headless '+Lazy! sync' +qa"
fi

log "Bootstrap complete"
