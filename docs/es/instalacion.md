# Guía de Instalación

Esta guía te ayudará a instalar y configurar todas las dependencias necesarias para que tu configuración de Neovim funcione correctamente.

## 📋 Requisitos Previos

### Sistema Operativo
- **Linux** (Arch Linux recomendado, compatible con otras distribuciones)
- **Neovim 0.10.0+** con soporte Lua (requerido para blink.cmp)

### Herramientas Externas Requeridas

#### 1. Node.js & npm
```bash
# Arch Linux
sudo pacman -S nodejs npm

# Verificar instalación
node --version
npm --version

# Alternativas:
# Ubuntu/Debian: sudo apt install nodejs npm
# Fedora: sudo dnf install nodejs npm
# macOS: brew install node
```

#### 2. Go
```bash
# Arch Linux
sudo pacman -S go

# Verificar instalación
go version

# Alternativas:
# Ubuntu/Debian: sudo apt install golang
# Fedora: sudo dnf install golang
# macOS: brew install go
```

#### 3. Git
```bash
# Arch Linux
sudo pacman -S git

# Verificar instalación
git --version

# Alternativas:
# Ubuntu/Debian: sudo apt install git
# Fedora: sudo dnf install git
# macOS: brew install git
```

#### 4. Rust & Cargo (para blink.cmp)
```bash
# Arch Linux
sudo pacman -S rust

# O vía rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Verificar instalación
cargo --version
```

#### 5. Herramientas de Formateo

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

# O con go
go install mvdan.cc/sh/v3/cmd/shfmt@latest
```

##### Stylua (Lua)
```bash
# Opción 1: Con Cargo (Rust)
cargo install stylua

# Opción 2: Arch Linux
sudo pacman -S stylua

# Verificar instalación
stylua --version
```

#### 6. .NET SDK (para C#)
```bash
# Arch Linux
sudo pacman -S dotnet-sdk

# Verificar instalación
dotnet --version

# Alternativas:
# Ubuntu/Debian: sudo apt install dotnet-sdk
# Fedora: sudo dnf install dotnet-sdk
# macOS: brew install dotnet
```

##### CSharpier (formateo de C#)
```bash
dotnet tool install --global csharpier
```

## 🔧 Instalación de la Configuración

### Paso 1: Clonar el Repositorio
```bash
# Backup de configuración existente (si tienes una)
mv ~/.config/nvim ~/.config/nvim.backup

# Clonar esta configuración
git clone <tu-repositorio> ~/.config/nvim
```

### Paso 2: Instalar Go Language Server
```bash
# gopls (LSP oficial de Go)
go install golang.org/x/tools/gopls@latest

# Verificar que esté en tu PATH
which gopls
# Debe mostrar: ~/go/bin/gopls
```

### Paso 3: Iniciar Neovim
```bash
nvim
```

Lazy.nvim se instalará automáticamente y descargará todos los plugins configurados. **Nota**: blink.cmp compilará sus componentes Rust en la primera instalación, lo cual puede tomar un momento.

## ✅ Verificación

### Verificar LSPs
```bash
# Dentro de Neovim, ejecuta:
:LspInfo
```

Deberías ver los siguientes LSPs instalados:
- **gopls** (Go - instalado en sistema)
- **vtsls** (TypeScript/JavaScript - vía Mason)
- **lua_ls** (Lua - vía Mason)
- **roslyn** (C# - vía roslyn.nvim)
- **html** (HTML - vía Mason)
- **css** (CSS - vía Mason)
- **marksman** (Markdown - vía Mason)

### Verificar Plugins
```bash
# Dentro de Neovim, ejecuta:
:Lazy
```

Todos los plugins deberían estar instalados y listos.

## 🐛 Solución de Problemas

### Problemas Comunes

#### 1. gopls no encontrado
```bash
# Asegúrate de que ~/go/bin esté en tu PATH
echo 'export PATH=$PATH:~/go/bin' >> ~/.bashrc
# o ~/.zshrc si usas zsh
source ~/.bashrc
```

#### 2. Plugins no se instalan
```bash
# Elimina el directorio de lazy y reinicia
rm -rf ~/.local/share/nvim/lazy
nvim
```

#### 3. LSP no se activa
```bash
# Verifica que el LSP esté instalado
:Mason
# Instala manualmente si falta
```

#### 4. Formateo no funciona
```bash
# Verifica que las herramientas estén instaladas
which prettier black stylua shfmt csharpier
```

#### 5. Falla la compilación de blink.cmp
```bash
# Asegúrate de que Rust/Cargo esté instalado y en PATH
cargo --version
# Reinstala blink.cmp vía Lazy
:Lazy update saghen/blink.cmp
```

## 🔄 Actualización

### Actualizar Plugins
```bash
# Dentro de Neovim:
:Lazy update
```

### Actualizar Configuración
```bash
cd ~/.config/nvim
git pull origin main
```

## 🆚 Configuración de la Extensión VS Code Neovim

### Paso 1: Instalar la Extensión
Instala la [extensión VS Code Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim) en VS Code.

### Paso 2: Configurar VS Code Settings
Abre la configuración de VS Code (`Ctrl+,`) y añade:
```json
{
  "vscode-neovim.neovimExecutablePaths.linux": "/usr/bin/nvim",
  "vscode-neovim.logLevel": "error"
}
```

### Paso 3: Configurar Keybindings Colemak
Crea o edita `~/.config/Code/User/keybindings.json`:
```json
[
  // Navegación en listas (explorador, resultados de búsqueda, etc.)
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

  // Aceptar/abrir item en quick open con 'o'
  {
    "key": "o",
    "command": "workbench.action.acceptSelectedQuickOpenItem",
    "when": "inQuickOpen"
  },

  // Cerrar sidebar y paneles con Alt+Q
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

### Qué Funciona en VS Code
- ✅ Navegación Colemak (`n/e/i/o`)
- ✅ Flash, Spider, Surround, Autopairs
- ✅ Resaltado de Treesitter
- ✅ Which-key, Yanky
- ✅ LSP nativo de VS Code (no necesita Mason)
- ✅ Búsqueda nativa de VS Code (`<leader>sg`)
- ✅ Git nativo de VS Code (`<leader>ig`)

### Qué No Funciona en VS Code
- ❌ Pickers flotantes (fzf-lua, telescope) — usa la búsqueda de VS Code
- ❌ Terminal (toggleterm) — usa el terminal integrado de VS Code
- ❌ Undotree — usa la línea temporal de VS Code
- ❌ Oil — usa el explorador de archivos de VS Code
- ❌ Lualine, Noice — VS Code tiene su propia UI

## 📚 Recursos Adicionales

- [Documentación de Neovim](https://neovim.io/doc/)
- [Guía de Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [Documentación de blink.cmp](https://cmp.saghen.dev/)
- [Extensión VS Code Neovim](https://github.com/vscode-neovim/vscode-neovim)

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Installation Guide](../en/installation.md)

---

*Si encuentras algún problema durante la instalación, no dudes en abrir un issue en el repositorio.*
