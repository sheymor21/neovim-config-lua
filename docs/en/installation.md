# Installation Guide

This guide will help you install and configure all necessary dependencies for your Neovim configuration to work correctly.

## 📋 Prerequisites

### Operating System
- **Linux** (Arch Linux recommended, compatible with other distributions)
- **Neovim 0.9.0+** with Lua support

### Required External Tools

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

#### 4. Formatting Tools

##### Prettier (JavaScript/TypeScript)
```bash
npm install -g prettier
prettier --version
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

#### 5. .NET SDK (for C#)
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
```

## 🔧 Configuration Installation

### Step 1: Clone Repository
```bash
# Backup existing configuration (if you have one)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone <your-repository> ~/.config/nvim
```

### Step 2: Install Go Language Server
```bash
# gopls (official Go LSP)
go install golang.org/x/tools/gopls@latest

# Verify it's in your PATH
which gopls
# Should show: ~/go/bin/gopls
```

### Step 3: Start Neovim
```bash
nvim
```

Lazy.nvim will automatically install and download all configured plugins.

## ✅ Verification

### Verify LSPs
```bash
# Inside Neovim, run:
:LspInfo
```

You should see following LSPs installed:
- **gopls** (Go - system installed)
- **vtsls** (TypeScript/JavaScript - via Mason)
- **lua_ls** (Lua - via Mason)
- **roslyn** (C# - via roslyn.nvim)
- **html** (HTML - via Mason)
- **css** (CSS - via Mason)
- **marksman** (Markdown - via Mason)

### Verify Plugins
```bash
# Inside Neovim, run:
:Lazy
```

All plugins should be installed and ready.

## 🐛 Troubleshooting

### Common Issues

#### 1. gopls not found
```bash
# Make sure ~/go/bin is in your PATH
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
which prettier black stylua shfmt csharpier
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

## 📚 Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Guide](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)

## 🌐 Languages

- 🇺🇸 **English**: This documentation
- 🇪🇸 **Español**: [Guía de Instalación en Español](../es/instalacion.md)

---

*If you encounter any issues during installation, don't hesitate to open an issue in the repository.*