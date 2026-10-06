# Installation Guide

This guide will help you install and configure all necessary dependencies for your Neovim configuration to work correctly.

## ⚡ Automated Setup (recommended)

```bash
git clone <your-repository> ~/.config/nvim
~/.config/nvim/scripts/bootstrap.sh          # base + mise (node/go) + Go tools + providers
~/.config/nvim/scripts/bootstrap.sh --all    # also .NET SDK, Rust and tectonic
```

The script installs system packages (Arch/Omarchy), runtimes via **mise**, the Go tools (`gopls`, `gofumpt`, `goimports`), host providers, and then runs a one-shot headless `:Lazy! sync`. Formatters (`stylua`, `shfmt`, `prettier`, `black`) and every LSP/DAP server are installed by Mason on first start. The manual steps below are kept as reference for other distributions.

## 📋 Prerequisites

### Operating System
- **Linux** (Arch Linux recommended, compatible with other distributions)
- **Neovim 0.10.0+** with Lua support (required for blink.cmp)

### Required External Tools

> Storyboard is **optional**. If you don't need the kanban backend you can skip `go` and `curl`; :checkhealth reports each independently.

#### 1. Node.js & npm
```bash
# Arch Linux
sudo pacman -S nodejs npm

# Verify installation
node --version
npm --version

# Alternatives:
# Ubuntu/Debian: sudo apt install nodejs npm
# Fedora: sudo dnf install nodejs npm
# macOS: brew install node
```

#### 2. Go
```bash
# Arch Linux
sudo pacman -S go

# Verify installation
go version

# Alternatives:
# Ubuntu/Debian: sudo apt install golang
# Fedora: sudo dnf install golang
# macOS: brew install go
```

#### 3. Git
```bash
# Arch Linux
sudo pacman -S git

# Verify installation
git --version

# Alternatives:
# Ubuntu/Debian: sudo apt install git
# Fedora: sudo dnf install git
# macOS: brew install git
```

#### 4. Rust & Cargo (for blink.cmp)
```bash
# Arch Linux
sudo pacman -S rust

# Or via rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Verify installation
cargo --version
```

#### 5. Formatting Tools

> Formatters are managed by **Mason** (`mason-tool-installer.nvim`): `stylua`, `shfmt`, `prettier`, `black` (and `csharpier` when the .NET SDK is present) install automatically on first start. The manual instructions below are alternatives for non-Arch setups or for tools you prefer to manage globally.

##### Prettier (JavaScript/TypeScript)
```bash
npm install -g prettier
prettier --version
```

##### Python 3
```bash
# Arch Linux
sudo pacman -S python

# Verify installation
python3 --version

# Alternatives:
# Ubuntu/Debian: sudo apt install python3
# Fedora: sudo dnf install python3
# macOS: brew install python3
```

##### Black (Python)
```bash
pip install black
black --version
```

##### shfmt (Shell)
```bash
# Arch Linux
sudo pacman -S shfmt

# Or with go
go install mvdan.cc/sh/v3/cmd/shfmt@latest
```

##### Stylua (Lua)
```bash
# Option 1: With Cargo (Rust)
cargo install stylua

# Option 2: Arch Linux
sudo pacman -S stylua

# Verify installation
stylua --version
```

#### 6. .NET SDK (for C#)
```bash
# Arch Linux
sudo pacman -S dotnet-sdk

# Verify installation
dotnet --version

# Alternatives:
# Ubuntu/Debian: sudo apt install dotnet-sdk
# Fedora: sudo dnf install dotnet-sdk
# macOS: brew install dotnet
```

##### CSharpier (C# formatting)
```bash
dotnet tool install --global csharpier

# Make sure ~/.dotnet/tools is in your PATH
echo 'export PATH=$PATH:$HOME/.dotnet/tools' >> ~/.bashrc
# or ~/.zshrc if you use zsh
source ~/.bashrc
```

## 🔧 Configuration Installation

### Step 1: Clone Repository
```bash
# Backup existing configuration (if you have one)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone <your-repository> ~/.config/nvim
```

### Step 2: Install Go Language Tools

If you use **mise** (recommended, matches `scripts/bootstrap.sh`):

```bash
mise use -g go@latest
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
mise reshim
```

With mise, `GOBIN` points at the mise Go install, so `mise reshim` exposes the binaries on `PATH`. If you installed Go system-wide instead, they land in `~/go/bin`, which must be on `PATH`.

```bash
# Verify
which gopls gofumpt goimports
```

### Step 3: Start Neovim
```bash
nvim
```

Lazy.nvim will automatically install and download all configured plugins. **Note**: blink.cmp will compile its Rust components on first install, which may take a moment.

## ✅ Verification

### Verify LSPs
```bash
# Inside Neovim, run:
:LspInfo
```

You should see following LSPs wired up by the custom `lsp/servers.lua` pipeline:
- **gopls** (Go - system installed)
- **vtsls** (TypeScript/JavaScript - via Mason)
- **lua_ls** (Lua - via Mason)
- **html** (HTML - via Mason)
- **cssls** (CSS - via Mason)
- **marksman** (Markdown - via Mason)

**C#** is handled separately by `roslyn.nvim` from `lua/plugins/roslyn.lua` — it doesn't go through the custom LSP pipeline. Roslyn auto-downloads its language server binaries.

All LSPs above are wired through the custom `lua/lsp/servers.lua` pipeline, including `jsonls` (`lua/lsp/json.lua`). `mason-lspconfig`'s `automatic_enable` is disabled so servers are not started twice. Add new servers by registering them in `lua/lsp/servers.lua` with their module under `lua/lsp/`.

### Verify Plugins
```bash
# Inside Neovim, run:
:Lazy
```

All plugins should be installed and ready.

### Verify Health
```bash
# Inside Neovim, run:
:checkhealth
```

This runs the custom health check that verifies startup time, external dependencies, LSP servers, plugin health, notes vault and the Story Board (DiaProject) backend (clone state, binary, and run state).

### Optional: Story Board (DiaProject) backend

The Story Board integration is a **custom Go backend** hosted at `https://github.com/sheymor21/DiaProject.git`. It is **not** required by Neovim itself but the goal keys (`<leader>ts<key>`) won't work without it.

```bash
# Required host tools (already listed above): go + curl
go version
curl --version
```

The first time you press `<leader>tsd` (start), Neovim clones the repo to `~/.local/share/nvim/storyboard`, builds the `server` binary, and starts it on a free port. The clone + build + run pipeline is exposed in `lua/config/storyboard.lua` and verified by `:checkhealth`.

### Optional: Dadbod (SQL workflow)

Dadbod is bundled with `tpope/vim-dadbod`, `vim-dadbod-ui`, and `vim-dadbod-completion`. **No LSP server or extra binary is required** for the workflow itself; SQL completion comes from `vim-dadbod-completion` via blink.cmp. The one exception is **Oracle**: connecting to an `oracle://` database requires Oracle's `sqlplus` CLI on the host (e.g. AUR `oracle-instantclient-sqlplus` + `oracle-instantclient-basic` + `libaio`, with `ORACLE_HOME`/`LD_LIBRARY_PATH`/`PATH` set). Without it you get `DB: 'sqlplus' executable not found`.

```bash
# Add connections interactively (stored at ~/.local/share/nvim/dadbod_ui/):
:DBUIAddConnection
# Toggle the sidebar:
<leader>db
# Build a connection URI and copy it to the clipboard:
<leader>du
```

### Install LSP Servers via Mason
```bash
# Inside Neovim, run:
:Mason
```

Install any missing LSP servers from the list above. Mason provides a UI to install/uninstall LSP servers.

## 🐛 Troubleshooting

### Common Issues

#### 1. gopls not found
```bash
# If Go is managed by mise, regenerate the shims after installing tools
mise reshim
which gopls

# If Go is installed system-wide, make sure ~/go/bin is on PATH
echo 'export PATH=$PATH:~/go/bin' >> ~/.bashrc
# or ~/.zshrc if you use zsh
source ~/.bashrc
```

#### 2. Plugins not installing
```bash
# Remove lazy directory and restart
rm -rf ~/.local/share/nvim/lazy
nvim
```

#### 3. LSP not activating
```bash
# Verify LSP is installed
:Mason
# Install manually if missing
```

#### 4. Formatting not working
```bash
# Verify tools are installed
which prettier black stylua shfmt gofumpt goimports csharpier

# If csharpier is not found, check that ~/.dotnet/tools is in your PATH
echo $PATH | grep -q dotnet && echo "dotnet found" || echo "dotnet NOT in PATH"
```

#### 5. blink.cmp build fails
```bash
# Ensure Rust/Cargo is installed and on PATH
cargo --version
# Reinstall blink.cmp via Lazy
:Lazy update saghen/blink.cmp
```

## 🔄 Updates

### Update Plugins
```bash
# Inside Neovim:
:Lazy update
```

### Update Configuration
```bash
cd ~/.config/nvim
git pull origin main
```

## 🆚 VS Code Neovim Extension Setup

### Step 1: Install Extension
Install the [VS Code Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim) extension in VS Code.

### Step 2: Configure VS Code Settings
Open VS Code settings (`Ctrl+,`) and add:
```json
{
  "vscode-neovim.neovimExecutablePaths.linux": "/usr/bin/nvim",
  "vscode-neovim.logLevel": "error"
}
```

### Step 3: Configure Colemak Keybindings
Create or edit `~/.config/Code/User/keybindings.json`:
```json
[
  // Navigation in lists (explorer, search results, etc.)
  {
    "key": "e",
    "command": "list.focusDown",
    "when": "listFocus && !inputFocus"
  },
  {
    "key": "i",
    "command": "list.focusUp",
    "when": "listFocus && !inputFocus"
  },
  {
    "key": "n",
    "command": "list.collapse",
    "when": "listFocus && !inputFocus"
  },
  {
    "key": "o",
    "command": "list.expand",
    "when": "listFocus && !inputFocus"
  },

  // Accept/open item in quick open with 'o'
  {
    "key": "o",
    "command": "workbench.action.acceptSelectedQuickOpenItem",
    "when": "inQuickOpen && !listFocus"
  },

  // Close sidebar and panels with Alt+Q
  {
    "key": "alt+q",
    "command": "workbench.action.closeSidebar",
    "when": "sideBarFocus"
  },
  {
    "key": "alt+q",
    "command": "workbench.action.closePanel",
    "when": "panelFocus"
  },
  {
    "key": "alt+q",
    "command": "workbench.action.closeAuxiliaryBar",
    "when": "auxiliaryBarFocus"
  }
]
```

### What Works in VS Code
- ✅ Colemak navigation (`n/e/i/o`)
- ✅ Flash, Spider, Surround, Autopairs
- ✅ Treesitter highlighting
- ✅ Which-key, Yanky
- ✅ VS Code native LSP (no need for Mason)
- ✅ VS Code native search (`<leader>sg`)
- ✅ VS Code native Git (`<leader>ig`)

### What Doesn't Work in VS Code
- ❌ Floating pickers (fzf-lua, telescope) — use VS Code search
- ❌ Terminal (Snacks.terminal / toggleterm) — use VS Code integrated terminal
- ❌ Undotree — use VS Code timeline
- ❌ Oil — use VS Code file explorer
- ❌ Lualine, Noice — VS Code has its own UI

## 📚 Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Guide](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [blink.cmp Documentation](https://cmp.saghen.dev/)
- [VS Code Neovim Extension](https://github.com/vscode-neovim/vscode-neovim)

## 🌐 Languages

- 🇺🇸 **English**: This documentation
- 🇪🇸 **Español**: [Guía de Instalación en Español](../es/instalacion.md)

---

*If you encounter any issues during installation, don't hesitate to open an issue in the repository.*
