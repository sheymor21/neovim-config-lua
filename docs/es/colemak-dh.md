# Colemak-DH

Esta guía explica el layout Colemak-DH implementado en esta configuración de Neovim y cómo revertirlo al layout estándar de Vim si lo deseas.

## 🎯 ¿Qué es Colemak-DH?

Colemak-DH es una variante del layout Colemak diseñada para mayor ergonomía y comodidad. En esta configuración de Neovim, se aplica específicamente a las teclas de navegación para reducir el movimiento de las manos y mejorar la velocidad.

## 📋 Implementación Actual

### Navegación Básica Remapeada
| Tecla Original | Tecla Colemak-DH | Función | Archivo |
|----------------|------------------|---------|---------|
| h | n | Mover izquierda | `lua/keymaps.lua:13` |
| j | e | Mover abajo | `lua/keymaps.lua:14` |
| k | i | Mover arriba | `lua/keymaps.lua:15` |
| l | o | Mover derecha | `lua/keymaps.lua:16` |

### Navegación en Modo Visual
| Tecla Original | Tecla Colemak-DH | Función | Archivo |
|----------------|------------------|---------|---------|
| H | N | Mover izquierda (visual) | `lua/keymaps.lua:18` |
| J | E | Mover abajo (visual) | `lua/keymaps.lua:19` |
| K | I | Mover arriba (visual) | `lua/keymaps.lua:20` |
| L | O | Mover derecha (visual) | `lua/keymaps.lua:21` |

### Desactivación de Teclas Originales
| Tecla | Estado | Archivo |
|-------|--------|---------|
| h, j, k, l | Desactivadas (`<nop>`) | `lua/keymaps.lua:24-27` |
| H, J, K, L | Desactivadas (`<nop>`) | `lua/keymaps.lua:29-32` |

### Navegación Extendida
| Tecla | Función | Archivo |
|-------|---------|---------|
| N | Inicio de línea (`^`) | `lua/keymaps.lua:35` |
| O | Fin de línea (`$`) | `lua/keymaps.lua:36` |
| E | Scroll abajo (`<C-d>`) | `lua/keymaps.lua:39` |
| I | Scroll arriba (`<C-u>`) | `lua/keymaps.lua:40` |

### Remapeos Adicionales
| Tecla | Función | Archivo |
|-------|---------|---------|
| h | `o` (crear línea abajo) | `lua/keymaps.lua:42` |
| H | `O` (crear línea arriba) | `lua/keymaps.lua:43` |
| k | `i` (entrar modo insert) | `lua/keymaps.lua:44` |

## 🔄 Guía Completa de Reversión

### Paso 1: Backup de Configuración
```bash
# Crear backup antes de modificar
cp -r ~/.config/nvim ~/.config/nvim-backup-$(date +%Y%m%d)
```

### Paso 2: Revertir Navegación Básica

**Editar `lua/keymaps.lua`:**

**Opción A: Comentar las líneas de Colemak-DH**
```lua
-- =========================
-- MOVIMIENTO COLEMAK-DH (COMENTADO)
-- =========================
-- map({ "n", "v" }, "n", "h") -- izquierda
-- map({ "n", "v" }, "e", "j") -- abajo
-- map({ "n", "v" }, "i", "k") -- arriba
-- map({ "n", "v" }, "o", "l") -- derecha

-- map({ "n", "v" }, "N", "H")
-- map({ "n", "v" }, "E", "J") -- abajo
-- map({ "n", "v" }, "I", "K") -- arriba
-- map({ "n", "v" }, "O", "L") -- derecha

-- Desactivar los originales (COMENTADO)
-- map({ "n", "v" }, "h", "<nop>")
-- map({ "n", "v" }, "j", "<nop>")
-- map({ "n", "v" }, "k", "<nop>")
-- map({ "n", "v" }, "l", "<nop>")

-- map({ "n", "v" }, "H", "<nop>")
-- map({ "n", "v" }, "J", "<nop>")
-- map({ "n", "v" }, "K", "<nop>")
-- map({ "n", "v" }, "L", "<nop>")
```

**Opción B: Eliminar completamente las líneas**
Elimina las líneas 13-32 del archivo `lua/keymaps.lua`.

### Paso 3: Revertir Navegación Extendida

**Comentar o eliminar estas líneas:**
```lua
-- Inicio / fin de línea (COMENTADO)
-- map({ "n", "v" }, "N", "^")
-- map({ "n", "v" }, "O", "$")

-- Scroll cómodo (COMENTADO)
-- map("n", "E", "<C-d>")
-- map("n", "I", "<C-u>")
```

### Paso 4: Revertir Remapeos Adicionales

**Comentar o eliminar estas líneas:**
```lua
-- Remapeos adicionales (COMENTADO)
-- map("n", "h", "o")
-- map("n", "H", "O")
-- map("n", "k", "i")
```

### Paso 5: Verificar LSP y Funciones

**Revisar `lua/function-keymaps.lua`:**
Asegúrate de que las funciones LSP no dependan del layout Colemak-DH. Las funciones actuales usan Snacks.picker y deberían funcionar correctamente.

### Paso 6: Verificar Plugins

**Revisar archivos en `lua/plugins-keymaps/`:**
- `harpoon2-keymaps.lua` - No usa teclas de navegación
- `dap-keymaps.lua` - Usa teclas de función, no afectado
- `lazygit-keymaps.lua` - No usa teclas de navegación
- `yanky-keymaps.lua` - Usa p/P estándar
- `telekasten-keymaps.lua` - No usa teclas de navegación

### Paso 7: Probar la Configuración

**Reiniciar Neovim:**
```bash
nvim
```

**Pruebas básicas:**
1. **Navegación**: Usa h,j,k,l para moverte
2. **Modo visual**: Selecciona con v y navega con h,j,k,l
3. **LSP**: Prueba gd, K, . para navegación LSP
4. **Plugins**: Verifica que todos los plugins funcionen

## 🎛️ Alternativas de Configuración

### Opción 1: Layout Condicional
Crea un sistema que detecte si quieres usar Colemak-DH:

```lua
-- En init.lua
local use_colemak = vim.env.COLEMAK_DH == "1"

if use_colemak then
    require("colemak-keymaps")
else
    require("standard-keymaps")
end
```

### Opción 2: Toggle Runtime
Crea un comando para cambiar entre layouts:

```lua
-- En lua/config/colemak-toggle.lua
local M = {}

function M.toggle_colemak()
    local current = vim.g.colemak_enabled or false
    vim.g.colemak_enabled = not current
    
    if current then
        -- Desactivar Colemak-DH
        vim.cmd("lua require('standard-keymaps')")
    else
        -- Activar Colemak-DH
        vim.cmd("lua require('colemak-keymaps')")
    end
    
    vim.notify("Colemak-DH: " .. (vim.g.colemak_enabled and "ON" or "OFF"))
end

vim.api.nvim_create_user_command("ToggleColemak", M.toggle_colemak, {})

return M
```

### Opción 3: Configuración por Proyecto
Usa variables de entorno o archivos de configuración por proyecto:

```lua
-- En init.lua
local project_config = vim.fn.findfile(".nvimrc", ".;")
if project_config and vim.fn.filereadable(project_config) == 1 then
    vim.cmd("source " .. project_config)
end
```

## 🔧 Solución de Problemas

### Problemas Comunes

#### 1. Teclas no responden después de la reversión
```bash
# Reinicia Neovim completamente
nvim --headless -c 'qa!'

# O elimina el directorio de plugins y reinstala
rm -rf ~/.local/share/nvim/lazy
nvim
```

#### 2. LSP no funciona correctamente
```bash
# Verifica configuración de LSP
:LspInfo

# Reinicia LSP
:LspRestart
```

#### 3. Plugins con keymaps conflictivos
```bash
# Verifica keymaps activos
:verbose map h
:verbose map j
:verbose map k
:verbose map l
```

#### 4. Muscle memory conflictivo
- Usa la Opción 2 (Toggle) para transición gradual
- Practica con `vimtutor` para reentrenar
- Considera mantener Colemak-DH por un tiempo

## 📚 Referencia de Keymaps Estándar

### Navegación Básica Vim
| Tecla | Función | Modo |
|-------|---------|------|
| h | Izquierda | Normal, Visual |
| j | Abajo | Normal, Visual |
| k | Arriba | Normal, Visual |
| l | Derecha | Normal, Visual |
| H | Línea arriba (screen) | Normal |
| M | Línea media (screen) | Normal |
| L | Línea abajo (screen) | Normal |
| ^ | Inicio de línea | Normal, Visual |
| $ | Fin de línea | Normal, Visual |
| w | Siguiente palabra | Normal |
| b | Palabra anterior | Normal |
| e | Fin de palabra | Normal |
| gg | Inicio de archivo | Normal |
| G | Fin de archivo | Normal |

### Búsqueda y Navegación
| Tecla | Función | Modo |
|-------|---------|------|
| / | Buscar hacia adelante | Normal |
| ? | Buscar hacia atrás | Normal |
| n | Siguiente coincidencia | Normal |
| N | Coincidencia anterior | Normal |
| * | Buscar palabra bajo cursor | Normal |
| # | Buscar palabra bajo cursor (atrás) | Normal |

## 🔄 Estrategias de Migración

### Gradual Transition
1. **Semana 1**: Usa layout estándar para edición básica
2. **Semana 2**: Prueba Colemak-DH para navegación solo
3. **Semana 3**: Uso completo de Colemak-DH
4. **Semana 4**: Evalúa y decide

### Hybrid Approach
- Mantén Colemak-DH para navegación
- Usa layout estándar para otras operaciones
- Personaliza según preferencia

### Project-Based
- Usa Colemak-DH para proyectos personales
- Usa layout estándar para proyectos de equipo
- Cambia según el contexto

## 📋 Resumen Rápido

**Para revertir Colemak-DH:**
1. Backup: `cp -r ~/.config/nvim ~/.config/nvim-backup`
2. Editar `lua/keymaps.lua`: comentar líneas 13-32, 35-36, 39-40, 42-44
3. Reiniciar Neovim
4. Probar navegación con h,j,k,l

**Para mantener Colemak-DH:**
- Navegación: n,e,i,o (izquierda, abajo, arriba, derecha)
- Scroll: E/I (abajo/arriba)
- Línea: N/O (inicio/fin)

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Colemak-DH Guide](../en/colemak-dh.md)

---

## 🎯 Recomendaciones Finales

1. **Prueba antes de decidir**: Usa la configuración actual por al menos una semana
2. **Considera el toggle**: La opción 2 te permite cambiar dinámicamente
3. **Mantén el backup**: Siempre ten una configuración funcional de respaldo
4. **Personaliza según tu flujo**: Adapta la configuración a tus necesidades específicas

---

*Esta guía te proporciona todas las opciones necesarias para personalizar tu experiencia de navegación en Neovim según tus preferencias.*