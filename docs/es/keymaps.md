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
| `<leader>f` | Telescope find_files | Buscar archivos |
| `<leader>b` | Telescope buffers | Listar buffers |
| `<leader>r` | Telescope oldfiles | Archivos recientes |
| `<leader>P` | Telescope neovim-project discover | Descubrir proyectos |
| `<leader>p` | Telescope neovim-project history | Historial de proyectos |

### Búsqueda y Navegación
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>gp` | Telescope live_grep | Buscar texto en archivos |
| `<leader>s` | Telescope aerial | Buscar símbolos |
| `<leader>e` | `:Neotree toggle<CR>` | Toggle Neo-tree |
| `<leader>E` | `:Neotree reveal_force_cwd<CR>` | Abrir Neo-tree en ruta actual |

### Terminal y Ejecución
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>t` | ToggleTerm | Toggle terminal flotante |
| `<leader>cn` | run_project() | Ejecutar proyecto según filetype |
| `<leader>mf` | format() | Formatear buffer actual |

### Ventanas y Navegación
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>iw` | window_picker() | Seleccionar ventana |
| h | `o` | Crear nueva línea abajo |
| H | `O` | Crear nueva línea arriba |
| k | `i` | Entrar en modo insert |

### Funciones Inteligentes
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `;` | add_dot() | Insertar `;` inteligente al final |
| `,` | add_coma() | Insertar `,` inteligente al final |

## 🎨 Keybindings de Plugins

### Harpoon 2.0
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>a` | harpoon:list():add() | Añadir archivo actual |
| `<leader>h` | harpoon:toggle_quick_menu() | Menu rápido de bookmarks |
| `<C-1>` | harpoon:list():select(1) | Ir a bookmark 1 |
| `<C-2>` | harpoon:list():select(2) | Ir a bookmark 2 |
| `<C-3>` | harpoon:list():select(3) | Ir a bookmark 3 |
| `<C-4>` | harpoon:list():select(4) | Ir a bookmark 4 |
| `<leader>F` | telescope harpoon marks | Buscar bookmarks con Telescope |

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
| `<leader>gg` | lazygit | Abrir LazyGit |

### LazyDocker
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>dk` | lazydocker | Abrir LazyDocker |

### Telekasten (Notas)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>zn` | telekasten.new_note() | Nueva nota |
| `<leader>zf` | telekasten.find_notes() | Buscar notas |
| `<leader>zg` | telekasten.search_notes() | Buscar en notas |
| `<leader>zd` | telekasten.goto_today() | Ir a nota de hoy |
| `<leader>zt` | telekasten.show_todo() | Mostrar tareas |
| `<leader>zc` | telekasten.calendar() | Calendario de notas |

### Yanky (Yank/Paste)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `p` | yanky.put() | Pegar después |
| `P` | yanky.put() | Pegar antes |
| `]p` | yanky.put() | Pegar con indentación |
| `[p` | yanky.put() | Pegar con indentación (antes) |
| `>p` | yanky.put() | Ciclar hacia adelante en historial |
| `<p` | yanky.put() | Ciclar hacia atrás en historial |

### Conform (Formateo)
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>cf` | conform.format() | Formatear archivo |
| `<leader>cf` | conform.format() | Formatear selección (visual) |

### Vim-Multicursor
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<C-n>` | vim-multicursor.match_add() | Añadir cursor en coincidencia |
| `<C-x>` | vim-multicursor.match_skip() | Saltar coincidencia |
| `<C-p>` | vim-multicursor.match_prev() | Cursor anterior |
| `<Esc>` | vim-multicursor.escape() | Salir de multicursor |

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

### Diagnósticos LSP
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `[d` | vim.diagnostic.goto_prev() | Ir a diagnóstico anterior |
| `]d` | vim.diagnostic.goto_next() | Ir a siguiente diagnóstico |

## 🧪 Keybindings de Testing

### Neotest
| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>iur` | neotest.run.run() | Ejecutar test |
| `<leader>ius` | neotest.summary.toggle() | Toggle resumen de tests |
| `<leader>iud` | neotest.run.run({strategy = "dap"}) | Debug test |

## 📋 Keybindings de Búsqueda de Notas

| Keybinding | Función | Descripción |
|------------|---------|-------------|
| `<leader>it` | search_notes() | Buscar tareas pendientes en notas |

## 🔄 Colemak-DH Reversión

Para revertir al layout estándar de Vim, consulta la guía [colemak-dh.md](colemak-dh.md).

## 📚 Referencia Rápida

### Atajos Más Usados
- **Navegación**: n,e,i,o (izquierda, abajo, arriba, derecha)
- **Archivos**: `<leader>f` (buscar), `<leader>w` (guardar)
- **LSP**: `gd` (definición), `K` (documentación)
- **Git**: `<leader>gg` (LazyGit)
- **Testing**: `<leader>iur` (ejecutar tests)

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Keybindings](../en/keymaps.md)

---

*Para una guía completa sobre cómo revertir el layout Colemak-DH al estándar, consulta [colemak-dh.md](colemak-dh.md).*