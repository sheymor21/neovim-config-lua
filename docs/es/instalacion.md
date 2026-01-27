# Guía de Instalación

Esta guía te ayudará a instalar y configurar todas las dependencias necesarias para que tu configuración de Neovim funcione correctamente.

## 📋 Requisitos Previos

### Sistema Operativo
- **Linux** (Arch Linux recomendado, compatible con otras distribuciones)
- **Neovim 0.9.0+** con soporte Lua

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

#### 4. Herramientas de Formateo

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

##### Stylua (Lua)
```bash
# Opción 1: Con Cargo (Rust)
cargo install stylua

# Opción 2: Arch Linux
sudo pacman -S stylua

# Verificar instalación
stylua --version
```

#### 5. .NET SDK (para C#)
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

Lazy.nvim se instalará automáticamente y descargará todos los plugins configurados.

## ✅ Verificación

### Verificar LSPs
```bash
# Dentro de Neovim, ejecuta:
:LspInfo
```

Deberías ver los siguientes LSPs instalados:
- **gopls** (Go)
- **vtsls** (TypeScript/JavaScript)
- **lua_ls** (Lua)
- **omnisharp** (C#)
- **html** (HTML)
- **css** (CSS)
- **marksman** (Markdown)

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
which prettier black stylua
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

## 📚 Recursos Adicionales

- [Documentación de Neovim](https://neovim.io/doc/)
- [Guía de Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)

## 🌐 Idiomas

- 🇪🇷 **Español**: Esta documentación
- 🇺🇸 **English**: [English Installation Guide](../en/installation.md)

---

*Si encuentras algún problema durante la instalación, no dudes en abrir un issue en el repositorio.*