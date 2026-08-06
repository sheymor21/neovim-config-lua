# Configuración

Esta guía cubre la configuración general de Neovim, incluyendo opciones básicas, configuraciones de LSP y personalización.

## 📁 Estructura de Archivos

```
~/.config/nvim/
├── init.lua                       # Punto de entrada (rama a init/nvim o init/nvim_vscode)
├── AGENTS.md                      # Guía del agente (LLM)
├── README.md                      # Documentación principal
├── LICENSE                        # Licencia MIT
├── lazy-lock.json                 # Lockfile de versiones de plugins (gitignored)
├── docs/                          # Documentación para usuarios (en/ + es/)
├── optional-guides/               # Guías auxiliares (Azure DevOps, Git credential manager)
└── lua/
    ├── init/                      # Puntos de entrada por entorno
    │   ├── nvim.lua               # Inicio Neovim standalone
    │   └── nvim_vscode.lua        # Inicio VS Code
    ├── general-config.lua         # Autocmds y configuraciones compartidas
    ├── general-config/            # Configuraciones específicas por entorno
    │   └── nvim.lua               # Autocmds solo Neovim
    ├── keymaps.lua                # Entrada de keymaps (rama a keymaps/core + keymaps/{nvim,nvim_vscode})
    ├── keymaps/                   # Módulos de keymaps
    │   ├── core.lua               # Keymaps compartidos (Colemak, básicos, flash)
    │   ├── nvim.lua               # Keymaps solo Neovim
    │   └── nvim_vscode.lua        # Keymaps VS Code
    ├── function-keymaps.lua       # Funciones personalizadas y comportamientos LSP
    ├── health.lua                 # Health checks
    ├── utils.lua                  # Helpers de utilidad
    ├── config/                    # Módulos de setup
    │   ├── theme.lua              # Cambiador de temas
    │   ├── filetype-theme.lua     # Tema auto por filetype
    │   ├── lazy.lua               # Bootstrap de Lazy.nvim + filtro VS Code
    │   ├── dap-config.lua         # Adaptadores y configuraciones DAP
    │   ├── lazygit.lua            # Wrapper toggle LazyGit (toggleterm)
    │   ├── lazy-docker.lua        # Wrapper toggle LazyDocker
    │   ├── indent.lua             # Configuración de indentación
    │   ├── dadbod.lua             # Setup de vim-dadbod-ui
    │   ├── dashboard-urls.lua     # Lista de URLs del dashboard (gitignored)
    │   ├── dashboard-urls.example.lua
    │   ├── paths.lua              # Vault y constantes de rutas
    │   ├── helpers.lua            # Listas de snippets helper (SQL, …)
    │   ├── snacks.lua             # Override de Snacks (vim.notify)
    │   ├── csharp-accessors.lua   # Overrides de accessors C#
    │   ├── csharp-editorconfig.lua # Helper editorconfig C#
    │   ├── plugin-health.lua      # Health checks de plugins
    │   ├── profiler.lua           # Captura de errores en startup
    │   ├── reloader.lua           # :reload manual
    │   ├── diffview.lua           # Setup Diffview
    │   └── storyboard.lua         # Backend Story Board (DiaProject)
    ├── plugins/                   # Especificaciones de plugins
    │   ├── autopairs.lua, blink-cmp.lua, cellular.lua, colors.lua,
    │   │   configurationless.lua, conform.lua, dadbod.lua, dap-ui.lua,
    │   │   diffview.lua, faster.lua, flash.lua, fzf-lua.lua, gitsigns.lua,
    │   │   grapple.lua, lazydev.lua, lualine.lua, luasnipet.lua,
    │   │   markdown-render.lua, mason.lua, multicursor.lua, neotest.lua,
    │   │   neovim-session-manager.lua, noice.lua, nvim-navic.lua,
    │   │   nvim-web-devicons.lua, oil.lua, projects.lua,
    │   │   rainbow-delimiters.lua, reloader.lua, roslyn.lua, snacks.lua,
    │   │   spider.lua, toggle-term.lua, treesitter.lua, ufo.lua,
    │   │   undotree.lua, unidiagnostic.lua, unipackage.lua, unirunner.lua,
    │   │   wakatime.lua, which-key.lua, windows-picker.lua, yanky.lua,
    │   │   zealsearch.lua
    ├── nvim_vscode/               # Capa VS Code (archivo externo)
    │   └── init.lua               # Aporta la tabla `disabled_plugins`
    ├── plugins-off/               # Plugins deshabilitados (no-op specs)
    │   ├── 99.lua / 99-keymaps.lua
    │   ├── dressing.lua
    │   ├── harpoon2.lua / harpoon2-keymaps.lua
    │   ├── obsidian.lua
    │   ├── overseer.lua
    │   ├── sessions.lua
    │   └── tiny-inline-diagnostic.lua
    ├── plugins-keymaps/           # Keymaps específicos de plugins
    │   ├── conform-keymaps.lua, dadbod-keymaps.lua, dap-keymaps.lua,
    │   │   diffview-keymaps.lua, fzf-lua-keymaps.lua, grapple-keymaps.lua,
    │   │   lazydocker-keymaps.lua, lazygit-keymaps.lua, notes-keymaps.lua,
    │   │   snacks-keymaps.lua, spider-keymaps.lua, storyboard-keymaps.lua,
    │   │   yanky-keymaps.lua
    └── lsp/                       # Setup de LSP
        ├── gopls.lua              # Go LSP
        ├── vtsls.lua              # TS/JS LSP
        ├── lua-lsp.lua            # Lua LSP
        ├── html.lua, css.lua, markdown.lua
        ├── on_attach.lua          # Handler LspAttach
        ├── setup.lua              # Pipeline de registro de servidores
        ├── servers.lua            # Lista única de servidores
        └── utils.lua              # Utilidades LSP (wrapper de vim.lsp.start)
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

-- Virtualedit desactivado (cursor estricto)
vim.o.virtualedit = ""

-- Timeoutlen ajustado para Snacks UX
vim.opt.timeoutlen = 700

-- Terminal externo por defecto para launcher de opencode
vim.g.external_terminal = "alacritty"
```

### Autocommands (general-config.lua)

El `general-config.lua` compartido define:

**Configuración de diagnósticos** (sólo errores, prefijo `●`)
```lua
vim.diagnostic.config({
    virtual_text = { prefix = "●", spacing = 2, severity = { min = vim.diagnostic.severity.ERROR } },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
```

**Highlight en yank**
```lua
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = vim.api.nvim_create_augroup("UserConfig", { clear = false }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})
```

**Handler BufEnter combinado**: salta buffers de tipo `prompt` (snacks picker/input), ejecuta `filetype detect` cuando el filetype está vacío y reactiva treesitter.

**Conversión CRLF → LF** automática al abrir vía `BufReadPost`.

**Fold defaults**: `foldlevel = 99`, `foldlevelstart = 99`, `foldenable = true` (ufo se encarga de `foldmethod`/`foldexpr` en tiempo de ejecución).

### Nvim-only autogroup (`lua/general-config/nvim.lua`)

Cargado solo en Neovim standalone, no en VS Code.

**Limpieza de buffers en `DirChanged`** — los buffers fuera del nuevo cwd se eliminan al cambiar de directorio.

**Auto-insert** para filetypes `snacks_input` / `snacks_picker_input` para que los prompts acepten texto inmediatamente.

## 🎨 Sistema de Temas

### Configuración (`config/theme.lua`)
- **Tema por defecto**: `ayu` (cargado con `priority = 1000` en `lua/plugins/colors.lua`)
- **Temas disponibles**: ayu, kanagawa, tokyodark, gruvbox, onedark, onedark_dark
- **Cambio**: dinámico; `refresh_devicons` restaura colores de iconos que algunos temas puedan limpiar
- **Lualine sync**: la variante correspondiente del tema se aplica a lualine al cambiar de colorscheme
- **Blink.cmp highlights**: `BlinkCmpMenuSelection` se enlaza a `PmenuSel` y `BlinkCmpLabelMatch` a `Search` para que el estilo de completion se mantenga entre temas

### Temas por filetype (`config/filetype-theme.lua`)
- Omite buftypes especiales (lazy, mason, notify, …)
- El cache por último filetype evita reaplicar el tema en cada `BufEnter`
- Mapeo:
  - `lua` → `ayu`
  - `go` → `onedark_dark`
  - `cs` → `gruvbox`
  - `html` → `tokyodark`
  - `css` → `gruvbox`
  - `javascript` / `typescript` → `onedark_dark`
- Fallback para cualquier otro filetype: `kanagawa`

## 🔧 Configuración de LSP

### Pipeline propio (no usa nvim-lspconfig)
1. `lsp/servers.lua` declara la lista de servidores (`{ name, module }`)
2. `lsp/setup.lua` registra cada uno como autocmd `FileType` que invoca `lsp/utils.start_lsp_client`
3. El mismo módulo registra un autocmd global `LspAttach` que delega en `lsp/on_attach.lua`
4. `:DevReload` y `:LspReload` reciclan todo este pipeline

### `lsp/utils.lua`
```lua
function M.start_lsp_client(server_name, bufnr, config)
    config.capabilities = require("blink.cmp").get_lsp_capabilities()
    return vim.lsp.start(config, {
        bufnr = bufnr,
        reuse_client = function(client, conf) return client.name == conf.name end,
    })
end
```

### `lsp/on_attach.lua` (extracto)
```lua
client.server_capabilities.semanticTokensProvider = nil

map("n", "gd", function() require("fzf-lua").lsp_definitions({ jump1 = true }) end, { ... })
map("n", "gD", function() require("fzf-lua").lsp_references({ jump1 = true }) end, { ... })
map("n", "gi", function() require("fzf-lua").lsp_implementations({ jump1 = true }) end, { ... })
map("n", "gt", function() require("fzf-lua").lsp_typedefs({ jump1 = true }) end, { ... })
map("n", "K", vim.lsp.buf.hover, { ... })
map("n", ".", vim.lsp.buf.code_action, { ... })
map("n", "<leader>rn", require("function-keymaps").lsp_rename_and_save, { ... })
map("n", "<leader>ca", vim.lsp.buf.code_action, { ... })

-- breadcrumbs via nvim-navic, sólo si el servidor expone documentSymbolProvider
if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
end

-- inlay hints y code lens se activan sólo si el servidor los soporta
```

`<leader>rn` está conectado a `function-keymaps.lsp_rename_and_save`, que ejecuta el rename y luego guarda **silenciosamente cada buffer normal modificado** para que renames cross-file (Roslyn C#, gopls Go) no se pierdan.

### Servidores activos (`lsp/servers.lua`)
- `gopls` — Go (instalado en sistema)
- `lua_ls` — Lua (Mason + lazydev)
- `vtsls` — TypeScript/JavaScript (Mason)
- `html`, `cssls` — Web (Mason)
- `marksman` — Markdown (Mason)

`jsonls` está en Mason `ensure_installed` y en `lua/health.lua`, pero **no** aparece en `servers.lua`. Instálalo manualmente con `:MasonInstall jsonls` si lo necesitas.

### Excepciones
- **C# (`roslyn`)**: gestionado por `seblyng/roslyn.nvim` en `lua/plugins/roslyn.lua` (con `vim.lsp.config("roslyn", ...)` y opciones específicas: `filewatching = "auto"`, `lock_target = true`, razor desactivado). **No** pasa por el pipeline propio.
- **VS Code**: los LSPs nativos de VS Code reemplazan a todos los configurados aquí.

## 🛠️ Configuración de Plugins

### Bootstrap Lazy.nvim (`config/lazy.lua`)
Clona `folke/lazy.nvim` en la primera ejecución (rama stable) y:
- **Neovim standalone**: `require("lazy").setup("plugins")` (carga todos los specs bajo `lua/plugins/`)
- **VS Code**: escanea `lua/plugins/*.lua` y filtra con `nvim_vscode.disabled_plugins`, así no se carga nada que entre en conflicto con VS Code

### Configuraciones destacadas

**blink.cmp (`plugins/blink-cmp.lua`)**
- Default sources: `lsp`, `lazydev`, `snippets`, `buffer`, `path`
- **Filetypes SQL** (`sql`, `mysql`, `plsql`) añaden `dadbod` mediante `per_filetype` y la entrada `providers.dadbod`
- Preset: `snippets.preset = "luasnip"`
- Atajo solo de snippets: `<C-s>`
- Tab/S-Tab navegan o llaman a `luasnip.expand_or_jump()` / `jump(-1)`
- Signature help y cmdline completion activos
- Fuzzy: `prefer_rust_with_warning`

**fzf-lua (`plugins/fzf-lua.lua`)**
- Rendimiento nativo de fzf; preview horizontal
- Pickers de archivos, buffers, grep y símbolos LSP. Se lanzan desde `plugins-keymaps/fzf-lua-keymaps.lua`

**Dadbod (`plugins/dadbod.lua`)**
- Compone `tpope/vim-dadbod`, `vim-dadbod-ui` y `vim-dadbod-completion`
- Lazy-load con comandos `:DB*` y filetype SQL
- Las conexiones se añaden con `:DBUIAddConnection` y se almacenan en `~/.local/share/nvim/dadbod_ui/`
- `config/dadbod.lua` solo ajusta `vim.g.db_ui_use_nerd_fonts = 1` y una ventana flotante redondeada

**Diffview (`plugins/diffview.lua`)**
- Configurado vía `config/diffview.lua` y keymaps globales `<leader>g*` en `plugins-keymaps/diffview-keymaps.lua`. `<leader>gd` alterna la vista de cambios del working tree

**Storyboard (sin spec de plugin)**
- El backend Go custom de `lua/config/storyboard.lua` clona `https://github.com/sheymor21/DiaProject.git` en `vim.fn.stdpath("data")/storyboard`, compila el binario `server` la primera vez y lo ejecuta en un puerto libre
- Su ciclo de vida es lazy: sólo se carga cuando llamas a `start/stop/api_*` y se controla íntegramente desde el prefijo `<leader>ts<key>` de `plugins-keymaps/storyboard-keymaps.lua`

**Snippets helper (sin spec de plugin)**
- Los datos viven en `lua/config/helpers.lua` como tablas `M.helpers.<clave>` con `label` y una lista `items` de strings (multilínea con `[[...]]`)
- Los keymaps viven en `plugins-keymaps/helpers-keymaps.lua` bajo el prefijo `<leader>h<key>` (`<leader>hs` = SQL, `<leader>hl` = editar el archivo de datos). Elegir un item lo copia al registro `+`

**DAP (`config/dap-config.lua`)**
- Go (delve vía Mason), C# (netcoredbg vía Mason con auto-install), JavaScript/TypeScript (js-debug-adapter vía Mason)
- Las configuraciones C# incluyen auto-detección desde `.sln`/`.csproj`, runners NUnit e inyección de URL desde launchSettings para ASP.NET
- El runner TS detecta `npm`/`pnpm`/`yarn`/`bun` automáticamente

**Unirunner (`plugins/unirunner.lua`)**
- Clon local en `~/Projects/unirunner.nvim` (el spec público `sheymor21/unirunner.nvim` está comentado)
- Las keymaps del panel ya están remapeadas para Colemak-DH (`e`/`i` para abajo/arriba)
- Root markers: `package.json`, `go.mod`, `*.sln`, `.git`

## 🎯 Funciones Personalizadas (`function-keymaps.lua`)

La tabla `M` de `function-keymaps.lua` envuelve cada helper no trivial; los archivos de keymaps consumen `M.<nombre>`.

### Helpers de puntuación
- `M.add_dot()` — Inserción inteligente de `;` (omite si la línea ya termina con `;`)
- `M.add_coma()` — Igual para `,`

### Helpers del vault de notas
- `M.search_notes()` — Snacks grep de `"- [ ]"` en el vault
- `M.new_note_with_folder()` — Elige carpeta del vault + título y crea nota usando `templates/new_note.md`
- `M.find_notes()`, `M.grep_notes()` — Pickers Snacks acotados al vault
- `M.open_daily_note(offset)` — Hoy/ayer/mañana (`daily/<fecha>.md`)
- `M.show_backlinks()` / `M.show_tags()` — Snacks grep del nombre de la nota / `#[%w_-]+`
- `M.rename_note()` — Renombrado interactivo dentro del vault
- `M.toggle_checkbox()` — Conmuta `- [ ]` ⇄ `- [x]` in-place
- `M.follow_link()` — Sigue `[[wiki]]` o `[text](path)` bajo el cursor (también mapeado a `gf` en markdown)
- `M.capture_note()` — Nota rápida sin elección de carpeta
- `M.open_notes_panel()` — Alias de `find_notes()`

### Helpers de editor / LSP
- `M.lsp_rename_and_save()` — Envuelve `textDocument/rename` y guarda silenciosamente cada buffer normal modificado (renames cross-file para Roslyn / gopls)
- `M.jump_to_line()` — Salto interactivo dentro del buffer actual
- `M.toggle_inlay_hints()` — Toggle global de `vim.lsp.inlay_hint`
- `M.toggle_diagnostics_display()` — Alterna `virtual_text` en línea por `virtual_lines`

### Helpers de vista
- `M.dashboard_git_clone()` — Clona un repo en `~/Projects` desde el dashboard
- `M.dashboard_open_url()` — Abre una URL desde el gitignored `lua/config/dashboard-urls.lua`
- `M.open_external_opencode()` — Lanza `opencode` en el project root con un terminal configurable

### Multi-cursor / Flash / preview
- `M.mc_add_cursor_next()`, `M.mc_add_cursor_prev()`, `M.mc_match_all_cursors()`, `M.mc_clear_or_enable_cursors()`
- `M.flash_jump()`, `M.flash_treesitter()`
- `M.toggle_peek_preview()` — Alterna el preview markdown de `peek.nvim`

### Helpers de test / runner
- `M.neotest_run()`, `M.neotest_run_all()`, `M.neotest_summary()`, `M.neotest_debug()`
- `M.runner_run()`, `M.runner_cancel()`, `M.runner_select_run()`, `M.runner_config()`, `M.runner_history()`, `M.runner_go_terminal()`
- `M.runner_open_url()`, `M.runner_url_select()`
- `M.unipackage_menu()`

### Helpers ZealSearch
- `M.zeal_search_input()` — Abre el diálogo de ZealSearch
- `M.zeal_search_repeat()` — Repite la última query
- Docset inteligente por filetype (`zealsearch_docset_map`): typescript → TypeScript, cs/csharp → C#, sh/bash → Bash, etc.

### Helpers Storyboard (DiaProject)
- `M.dia_start()`, `M.dia_stop()`, `M.dia_open()` — ciclo de vida + abrir navegador
- `M.dia_logs()` — Abre el log del storyboard en vsplit
- `M.dia_projects()`, `M.dia_create_project()`, `M.dia_columns()`, `M.dia_cards()` — Selectores basados en REST (`/api/projects`, `/api/columns`, `/api/cards`)

### Helpers Dadbod
- `M.dadbod_schemes` — Esquemas registrados (`mysql`, `sqlserver`, `postgres`) con puertos, usuarios y prompts extra
- `M.dadbod_build_url()` — Constructor de URI interactivo; el resultado va a los registros `+` y `"`

### Helpers de snippets
- `M.helpers_open(clave)` — `vim.ui.select` (Snacks) sobre `config.helpers[clave].items`; el snippet elegido se copia al registro `+` (avisa si la lista no existe o está vacía)
- `M.helpers_open_config()` — Abre `lua/config/helpers.lua` para añadir/editar/eliminar a mano

## 📊 Configuración de Diagnósticos

Definida globalmente en `lua/general-config.lua` (ver snippet arriba). El modo de display — virtual-text vs virtual-lines — se conmuta en runtime con `<leader>td` (`M.toggle_diagnostics_display`).

## 🔄 Configuración de Rendimiento

### Lazy Loading
- Plugins se cargan según filtros `cmd`/`ft`/`event` de lazy.nvim
- Módulos no críticos se difieren al evento `User VeryLazy` en `lua/init/nvim.lua`. Añade nuevos módulos diferidos ahí
- Módulos actualmente diferidos: `config.profiler`, `csharp-accessors`, `csharp-editorconfig`, `filetype-theme`, `indent`, `plugin-health`, `lazy-docker`, `lazygit`, `dap-config`, `lsp.setup`, y los submódulos `indent` + `words` de snacks

### Gestión de Buffers
- El handler BufEnter salta buffers de tipo `prompt`
- Treesitter se reactiva automáticamente cuando el filetype no está vacío
- `DirChanged` limpia buffers fuera del nuevo cwd (sólo en Neovim standalone)
- Inlay hints, code lens y signature help sólo se activan cuando el servidor los anuncia

## 🔧 Guía de Personalización

### Añadir un plugin nuevo
1. Crea el spec en `lua/plugins/foo.lua` (o extiende uno inline existente)
2. Si tiene `config = function() ... end` de lazy, apúntalo a `require("config.foo")`
3. Añade el módulo de setup en `lua/config/foo.lua`
4. Si necesitas keymaps, crea `lua/plugins-keymaps/foo-keymaps.lua` y requiérelo desde `lua/keymaps/nvim.lua`
5. Verifica con `:Lazy`, `:checkhealth` y `:luafile %` en cada archivo tocado

### Modificar LSPs
1. Edita el módulo del servidor en `lua/lsp/`
2. Añade el servidor a `lua/lsp/servers.lua` (lista única)
3. Ejecuta `:LspReload` o `:DevReload` para aplicar

### Cambiar temas
1. Añade la spec del colorscheme en `lua/plugins/colors.lua` (usa `priority >= 1000` si quieres que sea el default)
2. Mapea en `lua/config/filetype-theme.lua` para override por filetype
3. Usa `lua/config/theme.lua`'s `M.apply(name)` para cambiar en runtime

### Storyboard / backend kanban
El helper `lua/config/storyboard.lua` es un envoltorio de `vim.fn.jobstart` y `vim.system`. Añade nuevos helpers en `lua/function-keymaps.lua` y ata keymaps desde `lua/plugins-keymaps/storyboard-keymaps.lua`.

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Configuration](../en/configuration.md)

## 📚 Recursos Adicionales

- [Documentación de Neovim Lua API](https://neovim.io/doc/user/lua.html)
- [Documentación de Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Documentación de blink.cmp](https://cmp.saghen.dev/)
- [Roslyn.nvim](https://github.com/seblyng/roslyn.nvim)

---

*Esta configuración está diseñada para ser modular y fácil de personalizar. Siéntete libre de adaptarla a tus necesidades específicas.*
