# neovim-config-lua

# Dependencias externas para Neovim

Este documento lista **todo lo que debe estar instalado fuera de Neovim**
para que funcione correctamente tu configuración de **LSP, autocompletado,
formateo y tooling**.

---

## Reglas generales

- Go → usar toolchain del sistema (NO Mason)
- HTML / CSS / JS / TS → usar Mason
- C# → OmniSharp vía Mason
- Formateo → herramientas externas
- Autocompletado → nvim-cmp + cmp-nvim-lsp

---

# Setup de herramientas de desarrollo (Arch Linux)

## Node.js & npm

Instalación (Arch):

```bash
sudo pacman -S nodejs npm
```

Verificar:

```bash
node --version
npm --version
```

Si no está instalado:
https://nodejs.org/en/download/

---

## Go

Instalación (Arch):

```bash
sudo pacman -S go
```

Verificar:

```bash
go version
```

Si no está instalado:
https://go.dev/dl/

---

## Git

Instalación (Arch):

```bash
sudo pacman -S git
```

Verificar:

```bash
git --version
```

Si no está instalado:
https://git-scm.com/downloads

---

## Go tooling (fuera de Neovim)

gopls (LSP oficial de Go):

```bash
go install golang.org/x/tools/gopls@latest
```

Verificar:

```bash
which gopls
```

Debe apuntar a:

```text
~/go/bin/gopls
```

Documentación oficial:
https://pkg.go.dev/golang.org/x/tools/gopls

---

## Node tooling global (recomendado)

Prettier:

```bash
npm install -g prettier
```

Verificar:

```bash
prettier --version
```

Sitio oficial:
https://prettier.io/docs/en/install.html

---

## Python tooling

Black:

```bash
pip install black
```

Verificar:

```bash
black --version
```

Sitio oficial:
https://black.readthedocs.io/en/stable/

---

## Lua tooling

Stylua (con Cargo):

```bash
cargo install stylua
```

O (Arch):

```bash
sudo pacman -S stylua
```

Sitio oficial:
https://github.com/JohnnyMorganz/StyLua

---

## C# tooling

.NET SDK

Verificar:

```bash
dotnet --version
```

Instalación (Arch):

```bash
sudo pacman -S dotnet-sdk
```

Si no está instalado:
https://dotnet.microsoft.com/download

