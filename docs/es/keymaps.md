# Keybindings

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
| H | N | Mover izquierda (visual) |
| J | E | Mover abajo (visual) |
| K | I | Mover arriba (visual) |
| L | O | Mover derecha (visual) |

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
| `<leader>ff` | Telescope find_files | Buscar archivos |
| `<leader>fb` | Telescope buffers | Listar buffers |
| `<leader>fr` | Telescope oldfiles | Archivos recientes |
| `<leader>fp` | Telescope neovim-project history | Historial de proyectos |
| `<leader>fP` | Telescope neovim-project discover | Descubrir proyectos |
| `-` | Oil | Abrir directorio padre |

### Búsqueda y Navegación
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>sg` | Telescope live_grep | Buscar texto en archivos |
| `<leader>ss` | Telescope aerial | Buscar símbolos |
| `<leader>e` | `:Neotree toggle<CR>` | Toggle Neo-tree |
| `<leader>E` | `:Oil<CR>` | Abrir Oil en ruta actual |
| `<leader>re` | `:Neotree reveal_force_cwd<CR>` | Abrir Neo-tree en ruta actual |

### Terminal y Ejecución
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>tt` | ToggleTerm | Toggle terminal flotante |
| `<leader>cn` | run_project() | Ejecutar proyecto según filetype |
| `<leader>ck` | runner_cancel() | Cancelar proyecto en ejecución |
| `<leader>cN` | runner_select_run() | Seleccionar y ejecutar proyecto |
| `<leader>cc` | runner_config() | Añadir configuración de runner |
| `<leader>ch` | runner_history() | Mostrar historial de runner |
| `<leader>iwt` | runner_go_terminal() | Ir a terminal del runner |

### Ventanas y Navegación
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>iwp` | window_picker() | Seleccionar ventana |

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

### Harpoon 2.0
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>aa` | harpoon:list():add() | Añadir archivo actual |
| `<leader>ah` | harpoon:toggle_quick_menu() | Menú rápido de bookmarks |
| `<C-1>` | harpoon:list():select(1) | Ir a bookmark 1 |
| `<C-2>` | harpoon:list():select(2) | Ir a bookmark 2 |
| `<C-3>` | harpoon:list():select(3) | Ir a bookmark 3 |
| `<C-4>` | harpoon:list():select(4) | Ir a bookmark 4 |
| `<leader>as` | telescope harpoon marks | Buscar bookmarks con Telescope |

### Debug Adapter Protocol (DAP)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<F5>` | dap.continue() | Iniciar/continuar debugging |
| `<F10>` | dap.step_over() | Step over |
| `<F11>` | dap.step_into() | Step into |
| `<F12>` | dap.step_out() | Step out |
| `<leader>ib` | toggle_breakpoint_or_debugger() | Toggle breakpoint |
| `<leader>iB` | dap.set_breakpoint() | Breakpoint condicional |
| `<leader>dr` | dap.repl.open() | Abrir REPL |
| `<leader>du` | dapui.toggle() | Toggle UI de debugging |
| `<leader>dx` | dap.terminate() | Terminar debugging |

### LazyGit
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>ig` | lazygit | Abrir LazyGit |

### LazyDocker
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>id` | lazydocker | Abrir LazyDocker |

### Telekasten (Notas)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>zp` | telekasten.panel() | Abrir panel de notas |
| `<leader>zn` | telekasten.new_templated_note() | Nueva nota con plantilla |
| `<leader>zf` | telekasten.find_notes() | Buscar notas |
| `<leader>zg` | telekasten.search_notes() | Buscar en notas |
| `<leader>zd` | telekasten.goto_today() | Ir a nota de hoy |
| `<leader>zv` | telekasten.switch_vault() | Cambiar vault |

### Yanky (Yank/Paste)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `p` | yanky.put() | Pegar después |
| `P` | yanky.put() | Pegar antes |
| `]p` | yanky.put() | Pegar con indentación |
| `[p` | yanky.put() | Pegar con indentación (antes) |
| `>p` | yanky.put() | Ciclar hacia adelante en historial |
| `<p` | yanky.put() | Ciclar hacia atrás en historial |
| `<leader>yh` | telescope yank_history | Historial de yank |

### Conform (Formateo)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>cf` | conform.format() | Formatear archivo |
| `<leader>cf` | conform.format() | Formatear selección (visual)

### Multicursor
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<C-n>` | mc_add_cursor_next() | Añadir cursor en siguiente coincidencia |
| `<C-p>` | mc_add_cursor_prev() | Añadir cursor en coincidencia anterior |
| `<leader>ma` | mc_match_all_cursors() | Añadir cursor a todas las coincidencias |
| `<Esc>` | mc_clear_or_enable_cursors() | Limpiar o habilitar cursores |

## 📝 Keybindings LSP

### Navegación LSP
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `gd` | snacks.picker.lsp_definitions() | Ir a definición |
| `gD` | snacks.picker.lsp_references() | Ver referencias |
| `gi` | snacks.picker.lsp_implementations() | Ir a implementación |
| `gt` | snacks.picker.lsp_type_definitions() | Ir a definición de tipo |
| `K` | vim.lsp.buf.hover() | Documentación en hover |
| `.` | vim.lsp.buf.code_action() | Acciones de código |
| `<leader>rn` | vim.lsp.buf.rename() | Renombrar símbolo |
| `<leader>ca` | vim.lsp.buf.code_action() | Acción de código |
| `<leader>cl` | vim.lsp.codelens.run() | Ejecutar CodeLens |
| `<leader>th` | toggle_inlay_hints() | Toggle inlay hints |

### Diagnósticos LSP
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `[d` | vim.diagnostic.goto_prev() | Ir a diagnóstico anterior |
| `]d` | vim.diagnostic.goto_next() | Ir a siguiente diagnóstico |
| `[i` | Lspsaga diagnostic_jump_prev() | Diagnóstico anterior (Lspsaga) |
| `]i` | Lspsaga diagnostic_jump_next() | Siguiente diagnóstico (Lspsaga) |
| `ge` | Lspsaga show_line_diagnostics() | Mostrar diagnósticos de línea |
| `<leader>td` | toggle_diagnostics_display() | Toggle visualización de diagnósticos |
| `<leader>isp` | Lspsaga show_workspace_diagnostics() | Toggle panel de diagnósticos |

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
| `<leader>mp` | toggle_peek_preview() | Preview de Markdown |

## 🔄 Colemak-DH Reversión

Para revertir al layout estándar de Vim, consulta la guía [colemak-dh.md](colemak-dh.md).

## 📚 Referencia Rápida

### Atajos Más Usados
- **Navegación**: n,e,i,o (izquierda, abajo, arriba, derecha)
- **Archivos**: `<leader>ff` (buscar), `<leader>w` (guardar)
- **LSP**: `gd` (definición), `K` (documentación), `<leader>th` (inlay hints)
- **Git**: `<leader>ig` (LazyGit)
- **Testing**: `<leader>iur` (ejecutar tests)
- **Multicursor**: `<C-n>` (añadir cursor), `<Esc>` (limpiar)
- **Flash**: `f` (saltar), `F` (treesitter)

### 99 Plugin (IA)
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
| `<leader>9r` | 99.search() | Buscar trabajo restante |

### Nvim Status (Recarga y Salud)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>nr` | DevReload | Recarga completa LSP & CMP |
| `<leader>nl` | LspReload | Recargar solo LSP |
| `<leader>nc` | CmpReload | Recargar solo CMP |
| `<leader>ns` | StartupTime | Mostrar tiempo de inicio |
| `<leader>nS` | SlowPlugins | Mostrar plugins lentos |
| `<leader>nh` | checkhealth | Health check |
| `<leader>nn` | Noice | Mostrar Noice |
| `<leader>np` | %bd!\|e# | Purgar Buffers |

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Keybindings](../en/keymaps.md)

---

*Para una guía completa sobre cómo revertir el layout Colemak-DH al estándar, consulta [colemak-dh.md](colemak-dh.md).*