# Características

Esta configuración de Neovim incluye un conjunto completo de características diseñadas para un entorno de desarrollo moderno y productivo.

## 🎯 Características Principales

### 1. Soporte de Lenguajes y LSP

#### Go
- **gopls**: LSP oficial de Go (instalado en sistema)
- **DAP**: Debugging con delve, configuraciones auto-detectadas
- **Neotest**: Framework de testing integrado
- **Unirunner**: Ejecución rápida con detección por root markers

#### TypeScript/JavaScript
- **vtsls**: LSP moderno TS/JS (vía Mason)
- **Prettier**: Formateo automático
- **DAP**: js-debug-adapter con auto-detección de `npm`/`pnpm`/`yarn`/`bun`
- **Unirunner**: Selecciona automáticamente el package manager para `tsx`

#### C#
- **Roslyn**: LSP oficial de Microsoft (vía `seblyng/roslyn.nvim`)
- **CSharpier**: Formateo
- **DAP**: netcoredbg vía Mason (auto-install), inyección de URL de launchSettings, soporte NUnit
- **dotnet run**: Ejecución integrada vía unirunner

#### Lua
- **lua-language-server**: LSP oficial de Lua
- **lazydev.nvim**: Mejoras para desarrollo de configs
- **Stylua**: Formateo (4 espacios, 100 columnas)
- **LuaSnip**: Motor de snippets

#### Python
- **black**: Formateo (100 caracteres)

#### Web / Markdown / Shell
- **HTML/CSS**: LSPs con autocompletado
- **Markdown**: marksman + rendering
- **Shell/Bash**: shfmt con indentación de 4 espacios

#### SQL
- **vim-dadbod** para gestión de conexiones
- **vim-dadbod-ui** para explorar esquema y lanzar queries
- **vim-dadbod-completion** integrado como source en blink.cmp para `sql`/`mysql`/`plsql`
- Constructor interactivo de URIs (`<leader>du`)

### 2. Navegación

#### Fzf-lua
- Archivos (`<leader>ff`)
- Buffers (`<leader>fb`)
- Live grep (`<leader>sgg`, `<leader>sgf`)
- Símbolos LSP (`<leader>ss`)

#### Snacks Picker
- Archivos recientes (`<leader>fr`)
- Marks / Help / Keymaps / Commands / Undo / Quickfix / Loclist / Resume
- Notas markdown: `find_notes`, `grep_notes`, `show_backlinks`, `show_tags`

#### Grapple
- Bookmarks rápidos (`<leader>aa`)
- Ctrl-1/2/3/4 directo; menú (`<leader>ah`), búsqueda (`<leader>as`)

#### Flash
- Salto rápido con highlighting (`f`/`F`)

#### Snap / motion
- **Spider** (movimiento semántico w/e/b)
- **Window picker** (`<leader>iwp`)
- **Multicursor** (`<C-n>`/`<C-p>`/`<leader>ma`)

### 3. Edición y Productividad

#### blink.cmp
- Sources: `lsp`, `lazydev`, `snippets`, `buffer`, `path` (+ `dadbod` para SQL)
- Fuzzy en Rust
- Commandline completion
- Signature help
- Snippet trigger: `<C-s>`

#### LuaSnip
- Cooperativo con Tab / S-Tab jump
- Cargador VSCode se difiere a VeryLazy

#### nvim-autopairs
- Cierre automático de brackets / quotes, etc.

#### Yanky
- Historial de yank/paste con cycling y paste con indentación

#### Conform
- Formateo async y sync (`<leader>mf`/`<leader>mF`), formateo de selección en visual

#### UFO
- Folding en C rápido, aliases Colemak-DH `z<key>` en `keymaps/core.lua`

### 4. UI y Apariencia

#### Temas Adaptativos por Filetype
- **Ayu** se carga eagerly al inicio desde `lua/plugins/colors.lua`
- Auto-switch por filetype (`lua/config/filetype-theme.lua`):
  - `lua` → ayu, `go` → onedark_dark, `cs` → gruvbox, `html` → tokyodark, `css` → gruvbox, `javascript`/`typescript` → onedark_dark
- Fallback: `kanagawa`

#### Temas Disponibles
- Ayu (default), Kanagawa, Gruvbox (con overrides C# y multicursor), Onedark / Onedark Dark, Tokyodark

#### Lualine
- Status line personalizada, sincronizada con el colorscheme activo

#### Snacks.notifier
- Reemplaza `vim.notify` vía `config/snacks.lua`

#### Indent / Rainbow
- Snacks `indent` (diferido a VeryLazy) y `rainbow-delimiters`

### 5. Herramientas de Desarrollo

#### DAP
- Multi-lenguaje con breakpoints condicionales, REPL integrado
- Auto-install de `netcoredbg`, `js-debug-adapter`, `delve` vía Mason

#### Neotest
- Framework unificado con integración DAP

#### LazyGit (vía Snacks)
- Respeta `~/.config/lazygit/config.yml`
- Único punto de entrada: `<leader>ig`

#### LazyDocker
- Wrapper Toggleterm (`config/lazy-docker.lua`) + launcher vía Snacks (`<leader>id`)

#### DiffView
- Side-by-side / file history; wired en `plugins-keymaps/diffview-keymaps.lua`
- LSP `gd`/`gD` siguen ganando en buffer-local

#### Snacks.terminal
- Terminal flotante con `<leader>tt` e integración con runners

#### ToggleTerm (legacy)
- Mantenido para los wrappers de `unirunner`/`lazygit`/`lazy-docker`

#### OpenCode
- Launcher externo (`<leader>to`), respeta `vim.g.external_terminal`

### 6. Sesiones y Proyectos

#### neovim-session-manager (`Shatur/neovim-session-manager`)
- Persistencia y auto-guardado de sesiones

#### Neovim Project
- Auto-descubrimiento (`<leader>fP`) y recientes (`<leader>fp`)

#### Dashboard (Snacks)
- Teclas: `f` (find), `p` (projects), `v` (vault), `n` (today), `N` (new), `l` (Lazy), `u` (URL), `g` (git clone), `m` (Mason), `q` (quit)

#### Undotree
- `<leader>u` para alternar undo tree

### 7. Utilidades Avanzadas

#### Which-key, Unidiagnostic, nvim-navic, Snacks.nvim, Oil.nvim
- Ayudas de keybindings, panel de diagnósticos (toggle + current), breadcrumbs LSP (sólo si el servidor soporta `documentSymbolProvider`)
- Snacks: dashboard/picker/notifier/indent/lazygit/terminal/words/input

### 8. Herramientas Adicionales

#### Multicursor / Faster / Window picker / ZealSearch
- (Ver configuración para detalles)

#### Dadbod / Dadbod-UI
- Gestión de conexiones vía `:DBUIAddConnection` (almacenadas en `~/.local/share/nvim/dadbod_ui/`)
- Sidebar UI (`<leader>db`)
- Completion SQL a través de blink.cmp
- Constructor de URL (`<leader>du`) que codifica RFC 3986 y copia al portapapeles

### 9. Storyboard (DiaProject) — Backend kanban custom

Sheymor mantiene un backend Go custom en `https://github.com/sheymor21/DiaProject`. El módulo `lua/config/storyboard.lua` lo clona en `vim.fn.stdpath("data")/storyboard`, compila el binario `server` bajo demanda y lo ejecuta en un puerto libre.

Keymaps del prefijo `<leader>ts<key>`:

| Keymap | Acción |
|--------|--------|
| `<leader>tsd` | Iniciar servidor (clonar + build + run si hace falta) |
| `<leader>tsD` | Detener servidor |
| `<leader>tso` | Abrir dashboard en el navegador |
| `<leader>tsl` | Ver log del servidor |
| `<leader>tsp` | Listar / inspeccionar proyectos |
| `<leader>tsn` | Crear proyecto |
| `<leader>tsc` | Listar columnas de un proyecto |
| `<leader>tsk` | Listar cards (proyecto → columna → cards) |

Storyboard se reporta en `:checkhealth` y requiere `go` y `curl` en el host.

### 10. Características Únicas

#### Colemak-DH Layout
- `h,j,k,l` → `n,e,i,o`. Revisión en `colemak-dh.md`

#### Funciones Inteligentes
- Inserción de `;`, `,`
- Formateo con un comando (`<leader>mf`/`<leader>mF`)
- Búsqueda de tareas pendientes en notas (`<leader>it`)
- Limpieza automática de buffers en DirChanged
- Rename LSP cross-file con auto-save (`<leader>rn`)
- Snippets helper: listas aleatorias copiables (queries SQL, …) vía `<leader>hs`, editadas con `<leader>hl`

#### Optimizaciones de Rendimiento
- Lazy loading agresivo
- Configuración dirigida por eventos (`User VeryLazy`)
- Gestión inteligente de buffers
- Tree-sitter auto-reattachment

## 🆚 Compatibilidad con VS Code Neovim

Capa de compatibilidad (`lua/nvim_vscode/` + `lua/keymaps/nvim_vscode.lua`) que detecta cuando se ejecuta dentro de la extensión [VS Code Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim) y desactiva plugins conflictivos.

### Cómo Funciona
- **Detección**: `vim.g.vscode`
- **Filtrado**: `config/lazy.lua` lee `nvim_vscode.disabled_plugins` y omite esos specs. El resto se sigue cargando — desactívalo también con `lua/plugins-off/` si entra en conflicto
- **Remapeo**: `<leader>w`, `<leader>q`, etc. → `VSCodeNotify()`
- **Undo silencioso**: `u`/`U` ejecutan `<cmd>silent undo<CR>`/`<cmd>silent redo<CR>` para evitar spam de "Already at oldest change" en OUTPUT

### Plugins activos en VS Code
| Plugin | Propósito |
|--------|-----------|
| nvim-treesitter | Sintaxis |
| nvim-autopairs | Cierre de brackets |
| flash.nvim | Navegación rápida |
| spider.nvim | Movimiento CamelCase |
| which-key.nvim | Ayuda de keybindings |
| yanky.nvim | Historial de yank/paste |
| reloader.nvim | Recarga de config |
| colors | Esquemas de color |

### Plugins deshabilitados por defecto en VS Code
- **UI**: lualine, noice, snacks.nvim dashboard/picker/notifier
- **LSP**: mason.nvim, blink-cmp, todos los servidores LSP
- **Pickers**: fzf-lua
- **Git**: gitsigns, lazygit
- **Terminal**: Snacks.terminal / toggleterm
- **Notas**: archivos markdown
- **Debug**: nvim-dap, neotest

(La lista autoritativa es `nvim_vscode.disabled_plugins`.)

### Configuración de VS Code
- `vscode-neovim.neovimExecutablePaths.linux`: `nvim`
- `vscode-neovim.logLevel`: `"error"`
- `keybindings.json`: Mapeos Colemak (`e`/`i` arriba/abajo en listas, `Alt+Q` cierra paneles)

Consulta la [Guía de Instalación](instalacion.md#extensión-vs-code-neovim) para más detalles.

## 📊 Matriz de Características

| Característica | Categoría | Soporte de Lenguajes | Estado |
|----------------|------------|----------------------|--------|
| LSP | Soporte de Lenguajes | Go, TS/JS, C#, Lua, Python, HTML/CSS, Markdown | ✅ Activo |
| DAP | Herramientas de Desarrollo | Go, TS/JS, C# | ✅ Activo |
| blink.cmp | Edición | Todos (SQL añade source `dadbod`) | ✅ Activo |
| fzf-lua | Navegación | Todos | ✅ Activo |
| Grapple | Navegación | Todos | ✅ Activo |
| Oil | Gestión de Archivos | Todos | ✅ Activo |
| Snacks.nvim | UI/Dashboard | Todos | ✅ Activo |
| Markdown Notes | Toma de Notas | Markdown | ✅ Activo |
| Multicursor | Edición | Todos | ✅ Activo |
| Session Manager | Gestión de Proyectos | Todos | ✅ Activo |
| LazyGit | Herramientas de Desarrollo | Todos | ✅ Activo |
| Conform | Formateo | Todos | ✅ Activo |
| Faster | Rendimiento | Todos | ✅ Activo |
| DiffView | Git/Diff | Todos | ✅ Activo |
| Dadbod | Datos/SQL | SQL (mysql/postgres/sqlserver) | ✅ Activo |
| Storyboard | Backend custom | Binario Go | ✅ Activo |
| Snippets helper | Edición | Todos | ✅ Activo |

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Features Documentation](../en/features.md)

---

*Esta configuración está diseñada para ser modular y extensible, permitiéndote personalizarla según tus necesidades específicas.*
