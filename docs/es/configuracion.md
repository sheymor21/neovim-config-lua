# Configuración

Esta guía cubre la configuración general de Neovim, incluyendo opciones básicas, configuraciones de LSP, y aspectos clave de personalización.

## 📁 Estructura de Archivos

```
~/.config/nvim/
├── init.lua                    # Punto de entrada principal
├── README.md                   # Documentación de dependencias
├── LICENSE                     # Licencia MIT
├── lazy-lock.json              # Lockfile de versiones de plugins
└── lua/
    ├── general-config.lua      # Configuración general y autocmds
    ├── keymaps.lua             # Keybindings globales
    ├── function-keymaps.lua    # Funciones personalizadas y keymaps LSP
    ├── health.lua              # Health checks
    ├── utils.lua               # Funciones utilitarias
    ├── config/                 # Módulos de configuración
    │   ├── theme.lua           # Sistema de temas
    │   ├── filetype-theme.lua  # Temas específicos por filetype
    │   ├── lazy.lua            # Configuración de Lazy.nvim
    │   ├── dap-config.lua      # Configuración de DAP
    │   ├── lazygit.lua         # Configuración de LazyGit
    │   ├── lazy-docker.lua     # Configuración de LazyDocker
    │   ├── indent.lua          # Configuración de indentación
    │   ├── telekasten-config.lua # Configuración de Telekasten
    │   ├── csharp-accessors.lua # Accessors de C#
    │   ├── csharp-editorconfig.lua # Editorconfig de C#
    │   ├── plugin-health.lua   # Health checks de plugins
    │   ├── profiler.lua        # Profiler de rendimiento
    │   ├── reloader.lua        # Recargador de configuración
    ├── plugins/                # Especificaciones de plugins
    │   ├── 99.lua              # Cargador de plugins core
    │   ├── telescope.lua       # Configuración de Telescope
    │   ├── fzf-lua.lua         # Configuración de Fzf-lua
    │   ├── treesitter.lua      # Configuración de Treesitter
    │   ├── blink-cmp.lua       # Autocompletado (blink.cmp)
    │   ├── grapple.lua         # Marcadores de navegación
    │   ├── conform.lua         # Formateo de código
    │   ├── aerial.lua          # Outline de símbolos
    │   ├── lualine.lua         # Status line
    │   ├── toggle-term.lua     # Gestión de terminales
    │   ├── which-key.lua       # Ayuda de keybindings
    │   ├── gitsigns.lua        # Integración Git
    │   ├── noice.lua           # Notificaciones UI
    │   ├── snacks.lua          # Funciones de Snacks.nvim
    │   ├── flash.lua           # Navegación rápida
    │   ├── undotree.lua        # Visualización de undo
    │   ├── surround.lua        # Texto surrounding
    │   ├── autopairs.lua       # Auto cierre de brackets
    │   ├── indent.lua          # Guías de indentación
    │   ├── oil.lua             # Edición de filesystem
    │   ├── yanky.lua           # Yank/paste mejorado
    │   ├── luasnipet.lua       # Snippets
    │   ├── cellular.lua        # Efectos visuales
    │   ├── faster.lua          # Optimización de rendimiento
    │   ├── colors.lua          # Esquemas de color
    │   ├── markdown-render.lua # Renderizado de Markdown
    │   ├── multicursor.lua     # Múltiples cursores
    │   ├── neotest.lua         # Framework de testing
    │   ├── dap-ui.lua          # UI de debugging
    │   ├── neovim-session-manager.lua # Gestión de sesiones
    │   ├── projects.lua        # Gestión de proyectos
    │   ├── lazydev.lua         # Desarrollo Lua
    │   ├── configurationless.lua # Funciones utilitarias
    │   ├── windows-picker.lua  # Selección de ventanas
    │   ├── mini-nvim.lua       # Suite Mini.nvim
    │   ├── roslyn.lua          # LSP Roslyn
    │   ├── unirunner.lua       # Runner unificado
    │   ├── unipackage.lua      # Gestor de paquetes
    │   ├── unidiagnostic.lua   # Gestión de diagnósticos
    │   ├── wakatime.lua        # Integración Wakatime
    │   ├── telekasten.lua      # Notas Zettelkasten
    │   ├── reloader.lua        # Recargador de configuración
    │   └── nvim-web-devicons.lua # Iconos de archivos
    ├── plugins-off/            # Plugins deshabilitados
    │   ├── alpha.lua
    │   ├── dressing.lua
    │   ├── overseer.lua
    │   └── sessions.lua
    ├── plugins-keymaps/        # Keymaps específicos de plugins
    │   ├── 99-keymaps.lua
    │   ├── grapple-keymaps.lua
    │   ├── snacks-keymaps.lua
    │   ├── lazydocker-keymaps.lua
    │   ├── dap-keymaps.lua
    │   ├── yanky-keymaps.lua
    │   ├── telekasten-keymaps.lua
    │   ├── conform-keymaps.lua
    │   ├── fzf-lua-keymaps.lua
    │   ├── snacks-keymaps.lua
    │   └── grapple-keymaps.lua
    └── lsp/                    # Configuraciones de Language Servers
        ├── gopls.lua           # Go language server
        ├── vtsls.lua           # TypeScript/JavaScript LSP
        ├── lua-lsp.lua         # Lua language server
        ├── html.lua            # HTML LSP
        ├── css.lua             # CSS LSP
        ├── markdown.lua        # Markdown LSP
        ├── on_attach.lua       # Función LSP attach
        └── utils.lua           # Utilidades LSP
```

## ⚙️ Configuración General

### Opciones Básicas (init.lua)
```lua
-- Números relativos
vim.opt.relativenumber = true

-- Configuración de tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Colores y UI
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Leader key
vim.g.mapleader = " "

-- Undo persistente
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Clipboard
vim.opt.clipboard = "unnamedplus"
```

### Autocommands (general-config.lua)

**Highlight en yank**
```lua
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 200,
        })
    end,
})
```

**Re-attach de Tree-sitter**
```lua
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft ~= "" then
            pcall(vim.treesitter.start, args.buf)
        end
    end,
})
```

**Limpieza de buffers al cambiar de directorio**
```lua
vim.api.nvim_create_autocmd("DirChanged", {
    desc = "Limpiar buffers fuera del proyecto actual",
    callback = function()
        local cwd = vim.uv.cwd()
        -- Lógica de limpieza de buffers
    end,
})
```

## 🎨 Sistema de Temas

### Configuración de Temas (config/theme.lua)
- **Tema predeterminado**: Kanagawa
- **Temas disponibles**: Catppuccin, Gruvbox, Onedark, Cyberdream
- **Cambio dinámico**: Comandos para cambiar temas al vuelo

### Temas Específicos por Filetype (config/filetype-theme.lua)
- Configuración de temas según el tipo de archivo
- Optimización para diferentes lenguajes

## 🔧 Configuración de LSP

### Función de Attach General
```lua
local function lsp_on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local map = vim.keymap.set

    client.server_capabilities.semanticTokensProvider = nil

    map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
    map("n", "gD", Snacks.picker.lsp_references, { buffer = bufnr, desc = "Go to Declaration" })
    map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Implementation" })
    map("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
    map("n", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
end
```

### Configuraciones Específicas por Lenguaje

**Go (lsp/gopls.lua)**
- Usa gopls del sistema (no Mason)
- Configuración optimizada para desarrollo Go

**TypeScript/JavaScript (lsp/vtsls.lua)**
- vtsls vía Mason
- Configuración para proyectos modernos TS/JS

**C# (plugins/roslyn.lua)**
- Roslyn.nvim - LSP oficial de Microsoft para C#
- Soporte de formateo CSharpier
- Integración con .NET SDK

**Lua (lsp/lua-lsp.lua)**
- lua-language-server con lazydev.nvim
- Optimizado para desarrollo de configuraciones Neovim

## 🛠️ Configuración de Plugins

### Lazy.nvim (config/lazy.lua)
```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
```

### Configuraciones Destacadas

**blink.cmp (plugins/blink-cmp.lua)**
- Fuentes: LSP, lazydev, snippets, buffer, path
- Búsqueda fuzzy potenciada por Rust
- Autocompletado en línea de comandos
- Ayuda de firmas con parameter hints
- Integración con LuaSnip

**Telescope (plugins/telescope.lua)**
- Extensiones: file_browser, live_grep, neovim-project
- Integración con snacks.picker

**fzf-lua (plugins/fzf-lua.lua)**
- Búsqueda fuzzy rápida con rendimiento nativo de fzf
- Selectores de archivos, buffers, grep y símbolos
- Layout de vista previa horizontal

**Treesitter (plugins/treesitter.lua)**
- Highlight para múltiples lenguajes
- Auto-install de parsers

**DAP (config/dap-config.lua)**
- Soporte para Go, TypeScript/JavaScript, C#
- Configuración de adaptadores y configuraciones

## 🎯 Funciones Personalizadas

### Funciones de Utilidad (function-keymaps.lua)

**Inserción Inteligente de Puntuación**
```lua
function M.add_dot()
    local line = vim.api.nvim_get_current_line()
    if line:match(";%s*$") then
        return
    end
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A;")
    vim.api.nvim_win_set_cursor(0, pos)
end
```

**Runner de Proyectos**
```lua
function M.runner_run()
    require("unirunner").run()
end

function M.runner_select_run()
    require("unirunner").run_select()
end
```

**Búsqueda de Notas**
```lua
function M.search_notes()
    require("telescope.builtin").grep_string({
        search = "- [ ]",
        cwd = vim.fn.expand("~/notes"),
        prompt_title = "Pending tasks",
    })
end
```

**Salto a Línea**
```lua
function M.jump_to_line()
    local line_count = vim.api.nvim_buf_line_count(0)
    local line = vim.fn.input("Jump to line (1-" .. line_count .. "): ")
    if line and line ~= "" then
        local num = tonumber((line:gsub("%D", "")))
        if num then
            if num >= 1 and num <= line_count then
                vim.api.nvim_win_set_cursor(0, { num, 0 })
            else
                vim.notify("Line out of range (1-" .. line_count .. ")", vim.log.levels.WARN)
            end
        else
            vim.notify("Invalid line number", vim.log.levels.WARN)
        end
    end
end
```

## 📊 Configuración de Diagnósticos

```lua
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        spacing = 2,
        severity = {
            min = vim.diagnostic.severity.ERROR,
        },
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
```

## 🔄 Configuración de Rendimiento

### Lazy Loading
- Plugins cargados bajo demanda
- Event-driven configuration
- Optimización de startup time

### Buffer Management
- Limpieza automática de buffers
- Tree-sitter auto-reattachment
- Smart garbage collection

## 🔧 Guía de Personalización

### Añadir Nuevos Plugins
1. Crea archivo en `lua/plugins/`
2. Configura con `require("lazy").setup()`
3. Añade keymaps en `lua/plugins-keymaps/`

### Modificar LSPs
1. Edita archivos en `lua/lsp/`
2. Actualiza `lsp_on_attach` si es necesario
3. Reinicia Neovim o ejecuta `:LspRestart`

### Cambiar Temas
1. Modifica `lua/config/theme.lua`
2. Añade nuevos temas en `lua/plugins/colors.lua`

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Configuration](../en/configuration.md)

## 📚 Recursos Adicionales

- [Documentación de Neovim Lua API](https://neovim.io/doc/user/lua.html)
- [Documentación de Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Guía de Configuración LSP](https://github.com/neovim/nvim-lspconfig)

---

*Esta configuración está diseñada para ser modular y fácil de personalizar. Siéntete libre de adaptarla a tus necesidades específicas.*
