# Atajos de Teclado (Keybindings)

Esta guía de referencia cubre todos los keybindings principales configurados en esta distribución de Neovim, incluyendo el layout Colemak-DH optimizado.

> Los keymaps están repartidos entre `lua/keymaps/core.lua` (compartidos: Colemak, guardar/salir, puntuación inteligente, flash) y `lua/keymaps/nvim.lua` (keymaps de plugins y utilidades). Cada plugin añade además su `lua/plugins-keymaps/<nombre>-keymaps.lua`.

## 🎯 Layout Colemak-DH

Esta configuración usa Colemak-DH (consulta `colemak-dh.md` para la guía de reversión).

### Navegación Básica
| Tecla Original | Tecla Colemak-DH | Función |
|----------------|------------------|---------|
| h | n | Mover izquierda |
| j | e | Mover abajo |
| k | i | Mover arriba |
| l | o | Mover derecha |

### Navegación en Modo Visual
| Tecla Original | Tecla Colemak-DH | Función |
|----------------|------------------|---------|
| J | E | Mover abajo (visual) |
| K | I | Mover arriba (visual) |

### Navegación Extendida
| Tecla | Función |
|-------|---------|
| N | Inicio de línea |
| O | Fin de línea |
| E | Scroll abajo (Ctrl+d) |
| I | Scroll arriba (Ctrl+u) |
| h | Abrir línea debajo (preserva posición del cursor) |
| H | Abrir línea encima |
| k | Entrar en modo insert (preserva posición del cursor) |

### Folding (Colemak-friendly)
| Tecla | Función |
|-------|---------|
| `zn` | zc (cerrar fold) |
| `zN` | zM (cerrar todos los folds) |
| `zO` | zR (abrir todos los folds) |

> Teclas Colemak-safe para nuevas cadenas: cualquier letra excepto `n/e/i/o` y sus variantes mayúsculas. Los prefijos dadbod (`<leader>d<`) y storyboard (`<leader>ts<`) están elegidos para evitarlas.

## 🔧 Keybindings del Sistema

### Gestión de archivos
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>w` | `:w<CR>` | Guardar archivo |
| `<leader>q` | `:q<CR>` | Cerrar archivo |
| `<leader>W` | `:luafile %<CR>` | Cargar archivo Lua |
| `<leader>j` | `jump_to_line()` | Saltar a línea específica |
| `-` | `:Oil<CR>` | Abrir directorio padre (Oil) |
| `<leader>e` | `:Oil<CR>` (desde `plugins/oil.lua`) | Abrir Oil en el directorio del buffer |
| `<leader>E` | `:Oil .<CR>` | Abrir Oil en el cwd |
| `<leader>ff` | FzfLua files | Buscar archivos |
| `<leader>fb` | FzfLua buffers | Listar buffers |
| `<leader>fr` | `Snacks.picker.recent()` | Archivos recientes |
| `<leader>fp` | `NeovimProjectLoadRecent` | Proyecto reciente |
| `<leader>fP` | `NeovimProjectDiscover` | Descubrir proyectos |

> En Neovim standalone, `<leader>e`/`<leader>E`/`-` son keymaps de Oil; en VS Code `<leader>e` se remapea al explorador desde `keymaps/nvim_vscode.lua` y los otros dos siguen como Oil.

### Búsqueda
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>sgg` | FzfLua live_grep | Buscar texto en archivos |
| `<leader>sgf` | FzfLua live_grep (current file) | Buscar en `vim.fn.expand("%:p")` |
| `<leader>ss` | FzfLua lsp_document_symbols | Símbolos LSP |

### Ventanas / movement
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>iwp` | window_picker() | Seleccionar ventana |
| `f` / `F` | flash_jump / flash_treesitter | Flash motion (n/x/o) |

### Terminal / launcher externo
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>tt` | Snacks.terminal() | Alternar terminal flotante |
| `<leader>to` | open_external_opencode() | Abrir OpenCode en el project root |

### Puntuación inteligente
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `;` | `add_dot()` | `;` inteligente al final de línea |
| `,` | `add_coma()` | `,` inteligente al final de línea |

### Runners (`<leader>c<key>`)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>cn` | runner_run() | Ejecutar proyecto por filetype (unirunner) |
| `<leader>ck` | runner_cancel() | Cancelar ejecución en vivo |
| `<leader>cN` | runner_select_run() | Seleccionar + ejecutar |
| `<leader>co` | runner_open_url() | Abrir URL del runner (ej. launchSettings) |
| `<leader>cO` | runner_url_select() | Seleccionar URL del runner |
| `<leader>cc` | runner_config() | Añadir config de runner |
| `<leader>ch` | runner_history() | Historial de salida |
| `<leader>iwt` | runner_go_terminal() | Ir a terminal del runner |

### Neotest (`<leader>iu<key>`)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>iur` | `neotest.run.run()` | Ejecutar test bajo cursor |
| `<leader>iuR` | `neotest.run.run({ suite = true })` | Ejecutar todos los tests del suite |
| `<leader>ius` | `neotest.summary.toggle()` | Alternar resumen de tests |
| `<leader>iud` | `neotest.run.run({ strategy = "dap" })` | Debug test bajo cursor |

### ZealSearch (`<leader>i<z>`)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>iz` | zeal_search_input() | Abrir diálogo Zeal |
| `<leader>iZ` | zeal_search_repeat() | Repetir última query |

### Unipackage / Dashboard URL
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>ip` | unipackage_menu() | Menú de Unipackage |
| `<leader>iou` | dashboard_open_url() | Abrir URL desde `lua/config/dashboard-urls.lua` |

### Estado / reload / health
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>nr` | DevReload | Reload completo del pipeline LSP |
| `<leader>nl` | LspReload | Reload LSP sólo |
| `<leader>ns` | StartupTime | Mostrar tiempo de inicio |
| `<leader>nS` | SlowPlugins | Mostrar plugins lentos |
| `<leader>nh` | checkhealth | Health check |
| `<leader>nn` | `<cmd>Noice all<cr>` | Mostrar historial de Noice (cuando está activo) |
| `<leader>np` | `%bd!\|e#` | Purgar buffers |

### Cellular Automaton
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>!` | `CellularAutomaton make_it_rain` | Make it rain |

## 🎨 Keybindings de Plugins

### Grapple (bookmarks) — `lua/plugins-keymaps/grapple-keymaps.lua`
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>aa` | `grapple.toggle()` | Toggle bookmark |
| `<leader>ah` | `grapple.open_tags()` | Abrir menú de bookmarks |
| `<leader>as` | `grapple.open_tags()` | Buscar bookmarks (alias del menú) |
| `<C-1>` … `<C-4>` | `grapple.select({ index = N })` | Saltar a bookmark N |

### Multicursor — `lua/keymaps/nvim.lua`
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<C-n>` | `mc_add_cursor_next()` | Cursor en siguiente match |
| `<C-p>` | `mc_add_cursor_prev()` | Cursor en match anterior |
| `<leader>ma` | `mc_match_all_cursors()` | Cursor en todos los matches |
| `<esc>` | `mc_clear_or_enable_cursors()` | Alternar multicursor |

### DAP — `lua/plugins-keymaps/dap-keymaps.lua`
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<F5>` | dap.continue (con auto-detección de config "Current File") | Iniciar debug |
| `<F10>` / `<F11>` / `<F12>` | `dap.step_over` / `step_into` / `step_out` | |
| `<leader>ib` | `toggle_breakpoint_or_debugger()` | Toggle breakpoint (inserta `debugger;` en JS/TS) |
| `<leader>iB` | `dap.set_breakpoint(condition)` | Breakpoint condicional |
| `<leader>cdr` | `dap.repl.open()` | Abrir REPL |
| `<leader>cdu` | `dapui.toggle()` | Toggle UI de debug |
| `<leader>cdx` | `dap.terminate()` | Detener sesión |
| `<leader>cdd` | `auto_detect_debug()` | Auto-detectar tipo de proyecto |
| `<leader>cdt` | NUnit test (current file) | Debug NUnit test del archivo actual |
| `<leader>cdT` | All NUnit tests | Debug todos los NUnit tests del solution |

### LazyGit / LazyDocker / Terminal (`<leader>i<key>`)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>ig` | `Snacks.lazygit()` | LazyGit (vía Snacks) |
| `<leader>id` | `Snacks.terminal({ "lazydocker" })` | LazyDocker (binario `lazydocker` requerido) |
| `<leader>tt` | `Snacks.terminal()` | Toggle terminal flotante |

### DiffView — `lua/plugins-keymaps/diffview-keymaps.lua`
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>gd` | `Diffview.open()` | DiffView (cambios del working tree; alterna si ya está abierto) |
| `<leader>gD` | `Diffview.open({ files_only = true })` | DiffView vs HEAD, sólo archivos |
| `<leader>gh` | `Diffview.file_history()` | Historial de un archivo |
| `<leader>gH` | `Diffview.file_history({ rev = { "HEAD" } })` | Historial de rama |
| `<leader>gt` | `Diffview.toggle_files()` | Alternar panel de archivos |

> Nota: `<leader>gd`/`<leader>gD` aquí son mappings **globales**, mientras `gd`/`gD` desde `lsp/on_attach.lua` son **buffer-local**. Cuando hay LSPAttached, el LSP gana dentro de ese buffer.

### Snacks Picker (`<leader>s<key>`)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>sm` | `Snacks.picker.marks()` | Marks |
| `<leader>sh` | `Snacks.picker.help()` | Páginas de ayuda |
| `<leader>sk` | `Snacks.picker.keymaps()` | Keymaps |
| `<leader>sc` | `Snacks.picker.commands()` | Comandos |
| `<leader>su` | `Snacks.picker.undo()` | Historial undo |
| `<leader>sq` | `Snacks.picker.qflist()` | Quickfix list |
| `<leader>sl` | `Snacks.picker.loclist()` | Location list |
| `<leader>sr` | `Snacks.picker.resume()` | Reanudar último picker |

### Notas (vault Markdown) — `lua/plugins-keymaps/notes-keymaps.lua`
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>on` | new_note_with_folder() | Crear nota en carpeta del vault |
| `<leader>oC` | capture_note() | Nota rápida (sin elegir carpeta) |
| `<leader>od` | open_daily_note(0) | Daily note de hoy |
| `<leader>oD` | open_daily_note(-1) | Daily note de ayer |
| `<leader>ot` | open_daily_note(1) | Daily note de mañana |
| `<leader>os` | grep_notes() | Grep en el vault |
| `<leader>of` | find_notes() | File picker del vault |
| `<leader>ob` | show_backlinks() | Snacks grep por nombre de nota |
| `<leader>og` | show_tags() | Snacks grep por `#tag` |
| `<leader>or` | rename_note() | Renombrar nota actual |
| `<leader>oc` | toggle_checkbox() | Toggle `- [ ]` ⇄ `- [x]` |
| `<leader>ok` | follow_link() | Seguir `[[wiki]]` o `[text](path)` |

En buffers markdown, `gf` también está mapeado a buffer-local a `follow_link`.

### Markdown preview
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>mp` | toggle_peek_preview() | Toggle preview de `peek.nvim` |

### Yanky — `lua/plugins-keymaps/yanky-keymaps.lua`
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>yh` | yank_history | Historial de yank |

> Yanky también mejora `p`/`P` con cycle history (`>p`/`<p`), pegado con indentación (`]p`/`[p`) e integración con clipboard del sistema.

### Conform — `lua/plugins-keymaps/conform-keymaps.lua`
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>mf` | conform.format() (async) | Formatear buffer |
| `<leader>mF` | conform.format() (sync) | Formatear buffer de forma síncrona |
| `<leader>mf` (visual) | conform.format() | Formatear selección |

### Unidiagnostic / Undotree / Diagnósticos built-in — `lua/keymaps/nvim.lua`
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>isp` | `UnidiagnosticToggle` | Alternar panel de diagnósticos |
| `<leader>isc` | `UnidiagnosticCurrent` | Diagnósticos del archivo actual |
| `<leader>u` | `UndotreeToggle` | Alternar undo tree |
| `[d` / `]d` | `vim.diagnostic.jump({ count = ±1 })` | Diagnóstico anterior / siguiente |
| `<leader>isd` | `vim.diagnostic.open_float` | Diagnóstico de línea (float) |
| `<leader>isq` / `<leader>isl` | `vim.diagnostic.setqflist` / `setloclist` | Mover a quickfix / loclist |

## 📝 Keybindings LSP (en `lua/lsp/on_attach.lua`)

### Navegación LSP
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `gd` | `fzf-lua.lsp_definitions({ jump1 = true })` | Ir a definición |
| `gD` | `fzf-lua.lsp_references({ jump1 = true })` | Buscar referencias |
| `gi` | `fzf-lua.lsp_implementations({ jump1 = true })` | Implementaciones |
| `gt` | `fzf-lua.lsp_typedefs({ jump1 = true })` | Ir a definición de tipo |
| `K` | `vim.lsp.buf.hover` | Hover de documentación |
| `.` | `vim.lsp.buf.code_action` | Code actions |
| `<leader>rn` | `function-keymaps.lsp_rename_and_save` | Rename (escribe cada buffer normal modificado) |
| `<leader>ca` | `vim.lsp.buf.code_action` | Code action |
| `<leader>cl` | `vim.lsp.codelens.run` | Ejecutar CodeLens |

### Características LSP
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>th` | `toggle_inlay_hints` | Toggle inlay hints |
| `<leader>td` | `toggle_diagnostics_display` | Toggle virtual text / virtual lines |
| `Navic` | `nvim-navic.attach` | Breadcrumbs en statusline (sólo si el servidor soporta `documentSymbolProvider`) |

> Los semantic tokens se deshabilitan a propósito para **todos** los clientes en `lsp/on_attach.lua` (`client.server_capabilities.semanticTokensProvider = nil`) — los warnings/errors de Tree-sitter llevan los highlights.

## 🗃️ Dadbod / SQL — `lua/plugins-keymaps/dadbod-keymaps.lua`

| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>db` | `:DBUIToggle` | Toggle del sidebar DB UI |
| `<leader>du` | `dadbod.dadbod_build_url` | Construye URL `mysql`/`sqlserver`/`postgres` y la copia a `+` y `"` |
| `<leader>dC` | `:DBUICloseTab` | Cerrar tab de resultado |
| `<leader>dr` | `:DBUIRenameBuffer` | Renombrar buffer de resultado |
| `<leader>dL` | `:DBCompletionClearCache` | Limpiar cache de schema de `vim-dadbod-completion` |

Los buffers SQL (`sql`/`mysql`/`plsql`) también reciben `dadbod` como source de blink.cmp via `lua/plugins/blink-cmp.lua`.

## 🪪 Storyboard (DiaProject) — `lua/plugins-keymaps/storyboard-keymaps.lua`

Backend kanban custom en `lua/config/storyboard.lua`. Requiere `go` + `curl`.

| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>tsd` | `dia_start` | Clonar (si hace falta) + build + arrancar el servidor |
| `<leader>tsD` | `dia_stop` | Detener el servidor |
| `<leader>tso` | `dia_open` | Abrir `http://localhost:<puerto>` en el navegador |
| `<leader>tsl` | `dia_logs` | Abrir log de storyboard en vsplit |
| `<leader>tsp` | `dia_projects` | Listar proyectos (REST `/api/projects`) |
| `<leader>tsn` | `dia_create_project` | Crear proyecto (POST `/api/projects`) |
| `<leader>tsc` | `dia_columns` | Listar columnas de un proyecto |
| `<leader>tsk` | `dia_cards` | Listar cards (project → column → cards) |

## 📋 Snippets (blink.cmp + LuaSnip)

| Keybinding | Modo | Función |
|------------|------|---------|
| `<Tab>` | n / i | Visible → siguiente; si no, expande LuaSnip / jump |
| `<S-Tab>` | n / i | Visible → anterior; si no, LuaSnip jump(-1) |
| `<CR>` | i | Aceptar item con `select_and_accept` / fallback |
| `<C-Space>` | i | Mostrar completion / toggle documentación |
| `<C-j>` / `<C-k>` | i | Select next / prev (o fallthrough) |
| `<C-s>` | i | Snippet-only (forza picker de snippets) |

## 🆚 Keymaps de VS Code Neovim

Cuando se ejecuta dentro de la [extensión VS Code Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim), varios keymaps se remapean a comandos nativos de VS Code vía `vim.fn.VSCodeNotify`:

### Keybindings remapeados
| Keybinding | Comando VS Code | Descripción |
|------------|-----------------|-------------|
| `<leader>ff` | `workbench.action.quickOpen` | Quick open |
| `<leader>fb` | `workbench.action.showAllEditors` | Mostrar todos los editores |
| `<leader>sg` | `workbench.action.findInFiles` | Buscar en archivos |
| `<leader>ss` | `workbench.action.gotoSymbol` | Ir a símbolo |
| `<leader>e` | `workbench.view.explorer` | Toggle explorer |
| `<leader>tt` | `workbench.action.terminal.toggleTerminal` | Toggle terminal |
| `<leader>mp` | `markdown.showPreview` | Markdown preview |
| `<leader>mf` | `editor.action.formatDocument` | Formatear documento |
| `gd` | `editor.action.revealDefinition` | Ir a definición |
| `K` | `editor.action.showHover` | Hover |
| `<leader>rn` | `editor.action.rename` | Renombrar |
| `<leader>ca` | `editor.action.quickFix` | Code action |
| `<F5>` / `<F10>` / `<F11>` / `<F12>` | acciones de debug | Start / step over / into / out |
| `<leader>ib` | `editor.debug.action.toggleBreakpoint` | Toggle breakpoint |
| `<leader>w` | `workbench.action.files.save` | Guardar |
| `<leader>q` | `workbench.action.closeActiveEditor` | Cerrar editor |

### Undo silencioso
`u` y `U` ejecutan `<cmd>silent undo<CR>`/`<cmd>silent redo<CR>` para evitar el spam de "Already at oldest change" en OUTPUT.

### Navegación de paneles (VS Code `keybindings.json`)
Los paneles de VS Code mantienen los mapeos Colemak vía `~/.config/Code/User/keybindings.json`:
| Tecla | Acción |
|-------|--------|
| `e` | Mover abajo en lista |
| `i` | Mover arriba en lista |
| `n` | Colapsar carpeta |
| `o` | Expandir carpeta / abrir archivo |
| `Alt+Q` | Cerrar sidebar/panel |

## 🔄 Reversión Colemak-DH

Para revertir al layout estándar de Vim, consulta [colemak-dh.md](colemak-dh.md).

## 📚 Referencia Rápida

### Atajos más usados
- **Navegación**: n,e,i,o (izquierda, abajo, arriba, derecha)
- **Archivos**: `<leader>ff` (buscar), `<leader>w` (guardar)
- **LSP**: `gd` (definición), `K` (documentación), `<leader>th` (inlay hints)
- **Git**: `<leader>ig` (LazyGit), `<leader>gd` (DiffView)
- **Testing**: `<leader>iur` (run tests)
- **Búsqueda**: `<leader>sgg` (live grep), `<leader>sgf` (current file), `<leader>ss` (symbols)
- **Multicursor**: `<C-n>` (add cursor), `<esc>` (clear)
- **Flash**: `f` (jump), `F` (treesitter)
- **Notas**: `<leader>od` (hoy), `<leader>of` (find), `<leader>og` (tags)
- **Storyboard**: `<leader>tsd` (start), `<leader>tso` (open), `<leader>tsl` (logs)
- **Dadbod**: `<leader>db` (UI), `<leader>du` (URI builder)

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Keybindings](../en/keymaps.md)

---

*Para una guía completa sobre cómo revertir el layout Colemak-DH al estándar, consulta [colemak-dh.md](colemak-dh.md).*
