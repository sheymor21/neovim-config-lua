# Atajos de Teclado (Keybindings)

Esta guía de referencia cubre todos los keybindings principales configurados en esta distribución de Neovim, incluyendo el layout Colemak-DH optimizado.

## 🎯 Layout Colemak-DH

Esta configuración utiliza el layout Colemak-DH para una navegación más ergonómica:

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
| E | Scroll hacia abajo (Ctrl+d) |
| I | Scroll hacia arriba (Ctrl+u) |

## 🔧 Keybindings del Sistema

### Archivos y Gestión
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>w` | `:w<CR>` | Guardar archivo |
| `<leader>q` | `:q<CR>` | Cerrar archivo |
| `<leader>W` | `:luafile %<CR>` | Ejecutar archivo Lua actual |
| `<leader>ff` | FzfLua files | Buscar archivos |
| `<leader>fb` | FzfLua buffers | Listar buffers |
| `<leader>fr` | Snacks picker recent | Archivos recientes |
| `<leader>fp` | NeovimProjectLoadRecent | Proyecto reciente |
| `<leader>fP` | NeovimProjectDiscover | Descubrir proyectos |
| `<leader>j` | jump_to_line() | Saltar a línea específica |
| `-` | Oil | Abrir directorio padre |

### Búsqueda
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>sgg` | FzfLua live_grep | Buscar texto en archivos (global) |
| `<leader>sgf` | FzfLua live_grep | Buscar texto en archivo actual |
| `<leader>ss` | FzfLua lsp_document_symbols | Buscar símbolos |

### Navegación
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>e` | `:Oil<CR>` | Abrir Oil file manager |
| `<leader>E` | `:Oil .<CR>` | Abrir Oil en directorio de trabajo |
| `-` | `:Oil<CR>` | Abrir directorio padre |
| `<leader>iwp` | window_picker() | Seleccionar ventana |

### Terminal y Ejecución
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>cn` | runner_run() | Ejecutar proyecto según filetype |
| `<leader>ck` | runner_cancel() | Cancelar proyecto en ejecución |
| `<leader>cN` | runner_select_run() | Seleccionar y ejecutar proyecto |
| `<leader>co` | runner_open_url() | Abrir URL del runner |
| `<leader>cO` | runner_url_select() | Seleccionar URL del runner |
| `<leader>cc` | runner_config() | Añadir configuración de runner |
| `<leader>ch` | runner_history() | Mostrar historial de runner |
| `<leader>iwt` | runner_go_terminal() | Ir a terminal del runner |

### Funciones Inteligentes
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `;` | add_dot() | Insertar `;` inteligente al final |
| `,` | add_coma() | Insertar `,` inteligente al final |

### Zettelkasten (Folding)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `zn` | zc | Cerrar fold |
| `zN` | zM | Cerrar todos los folds |
| `zO` | zR | Abrir todos los folds |

## 🎨 Keybindings de Plugins

### Grapple (Bookmarks)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>aa` | grapple.toggle() | Toggle bookmark de archivo |
| `<leader>ah` | grapple.open_tags() | Abrir menú de bookmarks |
| `<C-1>` | grapple.select({index=1}) | Ir a bookmark 1 |
| `<C-2>` | grapple.select({index=2}) | Ir a bookmark 2 |
| `<C-3>` | grapple.select({index=3}) | Ir a bookmark 3 |
| `<C-4>` | grapple.select({index=4}) | Ir a bookmark 4 |
| `<leader>as` | grapple.open_tags() | Buscar bookmarks |

### Multicursor
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<C-n>` | mc_add_cursor_next() | Añadir cursor en siguiente coincidencia |
| `<C-p>` | mc_add_cursor_prev() | Añadir cursor en coincidencia anterior |
| `<leader>ma` | mc_match_all_cursors() | Añadir cursor a todas las coincidencias |
| `<Esc>` | mc_clear_or_enable_cursors() | Limpiar o habilitar cursores |

### Flash (folke/flash.nvim)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `f` | flash_jump() | Flash jump a carácter |
| `F` | flash_treesitter() | Flash treesitter node |

### Aerial (stevearc/aerial.nvim)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `{` | AerialPrev | Símbolo aerial anterior |
| `}` | AerialNext | Siguiente símbolo aerial |

### Debug Adapter Protocol (DAP)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<F5>` | dap.continue() | Iniciar/continuar debugging |
| `<F10>` | dap.step_over() | Step over |
| `<F11>` | dap.step_into() | Step into |
| `<F12>` | dap.step_out() | Step out |
| `<leader>ib` | toggle_breakpoint_or_debugger() | Toggle breakpoint / Insertar debugger (JS/TS) |
| `<leader>iB` | dap.set_breakpoint() | Breakpoint condicional |
| `<leader>cdr` | dap.repl.open() | Abrir REPL |
| `<leader>cdu` | dapui.toggle() | Toggle UI de debugging |
| `<leader>cdx` | dap.terminate() | Terminar debugging |

### DAP C# (Específico)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>cdd` | auto_detect_debug() | Debug proyecto (auto-detect) |
| `<leader>cdt` | dap.run() | Debug Test NUnit (archivo actual) |
| `<leader>cdT` | dap.run() | Debug Todos los Tests NUnit |

### Integración (LazyGit & LazyDocker via Snacks)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>ig` | Snacks.lazygit() | Abrir LazyGit |
| `<leader>id` | LazyDocker (custom) | Abrir LazyDocker |
| `<leader>tt` | Snacks.terminal() | Toggle terminal flotante |

### Snacks Picker
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>sm` | Snacks.picker.marks() | Marks |
| `<leader>sh` | Snacks.picker.help() | Páginas de ayuda |
| `<leader>sk` | Snacks.picker.keymaps() | Keymaps |
| `<leader>sc` | Snacks.picker.commands() | Comandos |
| `<leader>su` | Snacks.picker.undo() | Historial de undo |
| `<leader>sq` | Snacks.picker.qflist() | Quickfix list |
| `<leader>sl` | Snacks.picker.loclist() | Location list |
| `<leader>sr` | Snacks.picker.resume() | Reanudar último picker |

### Telekasten (Notas)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>on` | new_note_with_folder() | Nueva nota en carpeta |
| `<leader>od` | telekasten.goto_today() | Abrir nota diaria de hoy |
| `<leader>oD` | telekasten.goto_yesterday() | Abrir nota diaria de ayer |
| `<leader>ot` | telekasten.goto_tomorrow() | Abrir nota diaria de mañana |
| `<leader>os` | telekasten.search_notes() | Buscar notas |
| `<leader>of` | telekasten.find_notes() | Buscar notas |
| `<leader>ob` | telekasten.show_backlinks() | Mostrar backlinks |
| `<leader>og` | telekasten.show_tags() | Mostrar tags |
| `<leader>or` | telekasten.rename_note() | Renombrar nota |
| `<leader>op` | telekasten.paste_img_and_link() | Pegar imagen desde clipboard |
| `<leader>oc` | telekasten.toggle_todo() | Toggle checkbox / todo |
| `<leader>oT` | telekasten.show_calendar() | Mostrar calendario |
| `<leader>ok` | telekasten.follow_link() | Seguir enlace |
| `<leader>oC` | telekasten.capture() | Capturar nota rápida |
| `<leader>oo` | telekasten.panel() | Abrir panel de Telekasten |



### Markdown
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>mp` | toggle_peek_preview() | Toggle preview de Markdown |

### Surround (nvim-surround)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `ys` | `<Plug>(nvim-surround-normal)` | Añadir par surrounding alrededor de motion |
| `yS` | `<Plug>(nvim-surround-normal-line)` | Añadir par surrounding alrededor de línea |
| `ds` | `<Plug>(nvim-surround-delete)` | Eliminar par surrounding |
| `cs` | `<Plug>(nvim-surround-change)` | Cambiar par surrounding |
| `<leader>yw` | ysiw | Surround word shortcut |

### Yanky (Yank/Paste)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>yh` | yank_history | Historial de yank |

> **Nota**: Yanky también mejora `p`/`P` con ciclo de historial (`>p` / `<p`), pegado con indentación (`]p` / `[p`), e integración con clipboard del sistema mediante su comportamiento predeterminado.

### Trouble / Unidiagnostic
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>isp` | UnidiagnosticToggle | Toggle panel de diagnósticos |
| `<leader>isc` | UnidiagnosticCurrent | Mostrar diagnósticos del archivo actual |

### Undotree (mbbill/undotree)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>u` | UndotreeToggle | Toggle undo tree |

### Conform (Formateo)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>mf` | conform.format() | Formatear buffer (async) |
| `<leader>mF` | conform.format() | Formatear buffer (sync) |
| `<leader>mf` (visual) | conform.format() | Formatear selección |

### Cellular Automaton (eandrju/cellular-automaton.nvim)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>!` | CellularAutomaton make_it_rain | Make it rain |

## 📝 Keybindings LSP

### Navegación LSP
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `gd` | fzf-lua.lsp_definitions() | Ir a definición |
| `gD` | fzf-lua.lsp_references() | Ver referencias |
| `gi` | fzf-lua.lsp_implementations() | Ir a implementación |
| `gt` | fzf-lua.lsp_typedefs() | Ir a definición de tipo |
| `K` | vim.lsp.buf.hover() | Documentación en hover |
| `.` | vim.lsp.buf.code_action() | Acciones de código |
| `<leader>rn` | vim.lsp.buf.rename() | Renombrar símbolo |
| `<leader>ca` | vim.lsp.buf.code_action() | Acción de código |
| `<leader>cl` | vim.lsp.codelens.run() | Ejecutar CodeLens |

### Diagnósticos LSP
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `[d` | vim.diagnostic.jump({count=-1}) | Ir a diagnóstico anterior |
| `]d` | vim.diagnostic.jump({count=1}) | Ir a siguiente diagnóstico |
| `<leader>isd` | vim.diagnostic.open_float() | Diagnósticos de línea (float) |
| `<leader>isq` | vim.diagnostic.setqflist() | Diagnósticos a quickfix |
| `<leader>isl` | vim.diagnostic.setloclist() | Diagnósticos a loclist |
| `<leader>td` | toggle_diagnostics_display() | Toggle virtual text/lines |

### Características LSP
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>th` | toggle_inlay_hints() | Toggle inlay hints |

## 🧪 Keybindings de Testing

### Neotest
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>iur` | neotest.run.run() | Ejecutar test |
| `<leader>iuR` | neotest.run.run({suite = true}) | Ejecutar todos los tests |
| `<leader>ius` | neotest.summary.toggle() | Toggle resumen de tests |
| `<leader>iud` | neotest.run.run({strategy = "dap"}) | Debug test |

## 📋 Notas y Tareas

| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>it` | search_notes() | Buscar tareas pendientes en notas |
| `<leader>ip` | unipackage_menu() | Menú de Unipackage |
| `<leader>iou` | dashboard_open_url() | Abrir URL del dashboard |

### ZealSearch
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>iz` | zeal_search_input() | Zeal search input |
| `<leader>iZ` | zeal_search_repeat() | Zeal search repetir última |

### Plugin 99 (IA)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>9v` | 99.visual() | IA reemplazar selección visual |
| `<leader>9s` | 99.search() | Búsqueda con IA |
| `<leader>9a` | 99.vibe() | Asistente IA (vibe) |
| `<leader>9x` | 99.stop_all_requests() | Detener todas las peticiones |
| `<leader>9l` | 99.view_logs() | Ver logs |
| `<leader>9o` | 99.open() | Abrir última interacción |
| `<leader>9c` | 99.clear_previous_requests() | Limpiar peticiones anteriores |
| `<leader>9w` | 99.set_work() | Establecer work item |
| `<leader>9r` | 99.Extensions.Worker.search() | Buscar trabajo restante |

### Nvim Status (Recarga y Salud)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>nr` | DevReload | Recarga completa LSP |
| `<leader>nl` | LspReload | Recargar solo LSP |
| `<leader>ns` | StartupTime | Mostrar tiempo de inicio |
| `<leader>nS` | SlowPlugins | Mostrar plugins lentos |
| `<leader>nh` | checkhealth | Health check |
| `<leader>nn` | Noice | Mostrar Noice |
| `<leader>np` | %bd!\|e# | Purgar Buffers |

## 🆚 Keymaps de VS Code Neovim

Al ejecutarse dentro de la [extensión VS Code Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim), varios keymaps se remapean a comandos nativos de VS Code:

### Keybindings Remapeados
| Keybinding | Comando VS Code | Descripción |
|------------|-----------------|-------------|
| `<leader>w` | `workbench.action.files.save` | Guardar archivo |
| `<leader>q` | `workbench.action.closeActiveEditor` | Cerrar editor |
| `<leader>sg` | `workbench.action.findInFiles` | Buscar en archivos |
| `<leader>ff` | `workbench.action.quickOpen` | Abrir rápido archivo |
| `<leader>fb` | `workbench.action.showAllEditors` | Mostrar todos los editores |
| `<leader>fr` | `workbench.action.openRecent` | Archivos recientes |
| `<leader>aa` | `bookmarks.toggle` | Toggle bookmark |
| `<leader>ig` | `workbench.view.scm` | Control de fuente / Git |
| `<leader>tt` | `workbench.action.terminal.toggleTerminal` | Toggle terminal |
| `<leader>z` | `workbench.action.toggleZenMode` | Modo zen |

### Navegación de Paneles (VS Code `keybindings.json`)
Los paneles de VS Code (resultados de búsqueda, explorador) usan keybindings nativos de VS Code:
| Tecla | Acción |
|-------|--------|
| `e` | Mover abajo en lista |
| `i` | Mover arriba en lista |
| `n` | Colapsar carpeta |
| `o` | Expandir carpeta / Abrir archivo |
| `Alt+Q` | Cerrar sidebar/panel |

> **Nota**: La navegación Colemak (`n/e/i/o`) funciona en paneles de VS Code vía `~/.config/Code/User/keybindings.json` ya que la UI de VS Code no hereda los remaps de Neovim.

### Desactivados en VS Code
- **Undotree**: `<leader>u` no está disponible (plugin undotree desactivado)
- **Pickers LSP**: `gd`, `gD` usan el Go to Definition nativo de VS Code
- **Fzf-lua/Telescope**: Todos los keymaps de pickers usan equivalentes de VS Code
- **Oil**: `<leader>e` y `-` desactivados (usa el explorador de VS Code)

## 🔄 Reversión Colemak-DH

Para revertir al layout estándar de Vim, consulta la guía [colemak-dh.md](colemak-dh.md).

## 📚 Referencia Rápida

### Atajos Más Usados
- **Navegación**: n,e,i,o (izquierda, abajo, arriba, derecha)
- **Archivos**: `<leader>ff` (buscar), `<leader>w` (guardar)
- **LSP**: `gd` (definición), `K` (documentación), `<leader>th` (inlay hints)
- **Git**: `<leader>ig` (LazyGit)
- **Testing**: `<leader>iur` (ejecutar tests)
- **Búsqueda**: `<leader>sgg` (live grep), `<leader>sgf` (archivo actual), `<leader>ss` (símbolos)
- **Multicursor**: `<C-n>` (añadir cursor), `<Esc>` (limpiar)
- **Flash**: `f` (saltar), `F` (treesitter)

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Keybindings](../en/keymaps.md)

---

*Para una guía completa sobre cómo revertir el layout Colemak-DH al estándar, consulta [colemak-dh.md](colemak-dh.md).*
