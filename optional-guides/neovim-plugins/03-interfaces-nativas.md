# Interfaces nativas

Neovim ofrece varias capas para construir interfaces sin depender de un framework externo. Elige la más pequeña que resuelva el problema:

Si todavía no tienes claro qué es un buffer o por qué una ventana es distinta del contenido que muestra, consulta la sección sobre buffers en [Ciclo de vida y APIs](02-ciclo-de-vida-y-apis.md). En una interfaz nativa, normalmente el buffer contiene la pantalla y la ventana decide dónde aparece.

| Necesidad | API recomendada |
| --- | --- |
| Mensaje o estado breve | `vim.notify` |
| Texto corto introducido por el usuario | `vim.ui.input` |
| Elegir un elemento de una lista | `vim.ui.select` |
| Resultado que el usuario puede leer o editar | Buffer temporal |
| Panel persistente o formulario | Buffer + ventana flotante |
| Indicadores sobre código | Extmarks, highlights, signs o diagnostics |

## APIs abstractas de UI

`vim.ui.input` y `vim.ui.select` son interfaces nativas reemplazables. No asumas que siempre dibujan una ventana flotante: otra configuración puede ofrecer un selector de terminal, una interfaz gráfica o una integración con un picker.

```lua
vim.ui.input({ prompt = "Nombre: " }, function(value)
    if value and value ~= "" then
        vim.notify("Elegiste " .. value)
    end
end)

vim.ui.select({ "Lua", "Go", "Rust" }, {
    prompt = "Lenguaje:",
    format_item = function(item)
        return "- " .. item
    end,
}, function(choice)
    if choice then
        vim.notify("Seleccionaste " .. choice)
    end
end)
```

Las callbacks pueden recibir `nil` si el usuario cancela. Valida siempre ese caso.

## Ventana flotante mínima

Una ventana flotante muestra un buffer normal en una posición temporal. Separa el contenido, las opciones del buffer y la ventana para que la UI sea fácil de limpiar:

```lua
local function open_float(lines)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].modifiable = false
    vim.bo[buf].swapfile = false

    local width = 40
    local height = math.min(#lines, 10)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2 - 1),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
        title = " Mi plugin ",
        title_pos = "center",
    })

    vim.keymap.set("n", "q", function()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end, { buffer = buf, nowait = true, silent = true, desc = "Cerrar ventana" })

    return buf, win
end
```

Puntos importantes:

- Usa `relative = "editor"` para centrar en Neovim o `relative = "cursor"` para una UI contextual.
- Calcula `width` y `height` con `vim.o.columns` y `vim.o.lines`; no asumas una terminal grande.
- Usa `style = "minimal"` solo cuando la vista no necesite números, foldcolumn o signcolumn.
- Guarda el identificador de ventana si necesitas actualizarla y comprueba que siga siendo válido.
- Usa `bufhidden = "wipe"` para que un buffer temporal no quede acumulado.

## Panel interactivo

Para un panel con acciones, configura opciones locales y mappings buffer-locales. No registres mappings globales para una interfaz que solo existe mientras el panel está abierto:

```lua
local function open_panel(items)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, items)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].modifiable = false
    vim.bo[buf].filetype = "mi-plugin"

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = math.min(60, vim.o.columns - 4),
        height = math.min(15, vim.o.lines - 6),
        row = 2,
        col = 2,
        style = "minimal",
        border = "single",
    })

    local function close()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    vim.keymap.set("n", "q", close, { buffer = buf, silent = true })
    vim.keymap.set("n", "<Esc>", close, { buffer = buf, silent = true })
    vim.keymap.set("n", "<CR>", function()
        local line = vim.api.nvim_win_get_cursor(win)[1]
        vim.notify("Elegiste: " .. items[line])
        close()
    end, { buffer = buf, silent = true })

    return buf, win
end
```

Para interfaces más grandes, considera una ventana dividida (`nvim_open_win` no es obligatorio), un buffer dedicado con `winfixwidth`, o una combinación de panel y `vim.ui.input`. No conviertas un resultado simple en una UI compleja.

## Actualización y limpieza

Una UI debe tener un único dueño de sus recursos. Guarda el estado en el módulo y ofrece una función para cerrar o alternar:

```lua
local state = { win = nil, buf = nil }

local function close()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
    end
    state.win = nil
    state.buf = nil
end
```

Antes de escribir, enfocar o cerrar, comprueba `nvim_buf_is_valid` y `nvim_win_is_valid`. Si la UI usa timers, jobs o autocmds, detén y libera esos recursos al cerrar. Un `WinClosed` puede servir como respaldo para limpiar estado si el usuario cierra la ventana por otro medio.

## Errores frecuentes

- Crear una ventana global para una entrada que podía resolverse con `vim.ui.input`.
- Usar `vim.cmd` con dimensiones o contenido concatenado desde entrada del usuario.
- Dejar mappings globales después de cerrar un panel.
- Suponer que `vim.ui.select` devuelve siempre una opción.
- Fijar tamaños que no caben en una pantalla pequeña.
- Intentar modificar un buffer marcado como `modifiable = false`.
- Actualizar una ventana desde una callback asíncrona sin verificar su validez.
- Añadir iconos o fuentes especiales sin ofrecer texto comprensible como alternativa.
