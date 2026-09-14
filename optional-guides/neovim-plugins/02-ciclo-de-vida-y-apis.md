# Crear tu primer plugin: ciclo de vida y APIs

Esta guía es un recorrido práctico. Al terminar tendrás un plugin que:

- muestra un saludo con un comando;
- inserta la fecha en el buffer actual;
- muestra una notificación al guardar un archivo;
- puede configurarse desde `init.lua`.

Los conceptos de estructura general están en [Fundamentos y estructura](01-fundamentos.md). Aquí construiremos algo que puedas probar inmediatamente y después veremos cómo ampliar ese plugin para casos de uso habituales.

## 1. Decide una función pequeña

Un primer plugin no debería intentar resolver varias cosas. Elige una acción que puedas describir en una frase, por ejemplo:

> Quiero ejecutar `:MiPluginFecha` y añadir la fecha actual en la línea del cursor.

Durante el desarrollo usa un nombre propio, como `mi_primer_plugin`. Más adelante podrás cambiarlo por el nombre real del repositorio.

## 2. Crea la estructura

Desde una carpeta donde guardes tus plugins, crea esta estructura:

```text
mi-primer-plugin/
├── lua/
│   └── mi_primer_plugin/
│       └── init.lua
└── plugin/
    └── mi_primer_plugin.lua
```

El directorio `lua/` contiene la implementación reutilizable. El directorio `plugin/` es el punto de entrada que Neovim ejecuta automáticamente cuando el plugin está en `'runtimepath'`.

Para probar un plugin localmente, añade su directorio al `runtimepath`:

```vim
:set runtimepath^=/ruta/absoluta/a/mi-primer-plugin
```

Si usas un gestor como `lazy.nvim`, el gestor hace esta parte por ti.

## 3. Escribe el módulo principal

Crea `lua/mi_primer_plugin/init.lua`:

```lua
local M = {}

local defaults = {
    greeting = "Hola desde mi primer plugin",
}

local config = vim.deepcopy(defaults)

function M.setup(opts)
    config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
end

function M.saludar()
    vim.notify(config.greeting, vim.log.levels.INFO)
end

function M.insertar_fecha()
    local fecha = os.date("%Y-%m-%d")
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local column = cursor[2]

    vim.api.nvim_set_current_line(
        line:sub(1, column) .. fecha .. line:sub(column + 1)
    )
end

return M
```

El módulo devuelve una tabla `M`. Sus funciones son la API pública del plugin. `setup()` mezcla las opciones del usuario con los valores predeterminados sin modificar la tabla original.

La función `insertar_fecha()` usa una posición de cursor basada en bytes, que es precisamente la convención de las APIs de texto de Neovim. Para un primer plugin es suficiente; más adelante consulta `:help nvim_win_get_cursor` si necesitas trabajar con texto Unicode de forma más sofisticada.

## 4. Conecta el módulo con Neovim

Crea `plugin/mi_primer_plugin.lua`:

```lua
if vim.g.loaded_mi_primer_plugin then
    return
end
vim.g.loaded_mi_primer_plugin = true

local group = vim.api.nvim_create_augroup("MiPrimerPlugin", { clear = true })

vim.api.nvim_create_user_command("MiPluginSaludar", function()
    require("mi_primer_plugin").saludar()
end, {
    desc = "Muestra un saludo del plugin",
})

vim.api.nvim_create_user_command("MiPluginFecha", function()
    require("mi_primer_plugin").insertar_fecha()
end, {
    desc = "Inserta la fecha en el cursor",
})

vim.keymap.set("n", "<Plug>(mi-plugin-fecha)", function()
    require("mi_primer_plugin").insertar_fecha()
end, {
    desc = "Inserta la fecha en el cursor",
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    callback = function(args)
        if args.file ~= "" then
            vim.notify("Guardado: " .. args.file, vim.log.levels.INFO)
        end
    end,
    desc = "Notifica cuando se guarda un archivo",
})
```

Este archivo no contiene la lógica de insertar la fecha. Solo registra las entradas que Neovim necesita y delega el trabajo al módulo. La variable `vim.g.loaded_mi_primer_plugin` evita registrar dos veces los mismos comandos si el archivo se evalúa otra vez.

## 5. Configura y prueba

Con el plugin en el `runtimepath`, abre un buffer y ejecuta:

```vim
:lua require("mi_primer_plugin").setup({ greeting = "Hola, Neovim" })
:MiPluginSaludar
:MiPluginFecha
:write
```

Deberías ver el saludo, la fecha en la posición del cursor y una notificación al guardar.

Para hacerlo permanente en tu configuración:

```lua
require("mi_primer_plugin").setup({
    greeting = "Mi configuración funciona",
})
```

Con `lazy.nvim`, una especificación equivalente sería:

```lua
{
    "/ruta/absoluta/a/mi-primer-plugin",
    opts = {
        greeting = "Mi configuración funciona",
    },
}
```

El gestor normalmente llama a `setup(opts)` cuando usas `opts`, pero el plugin no debe depender de ese detalle. También debe funcionar con una llamada manual.

## Casos de uso comunes

### Añadir un comando con argumentos

Los comandos son útiles cuando la acción necesita texto, una ruta o una opción ocasional:

```lua
vim.api.nvim_create_user_command("MiPluginAbrir", function(command)
    if command.args == "" then
        vim.notify("Falta una ruta", vim.log.levels.WARN)
        return
    end

    vim.cmd.edit(vim.fn.fnameescape(command.args))
end, {
    nargs = "?",
    complete = "file",
    desc = "Abre una ruta desde mi plugin",
})
```

`nargs = "?"` permite cero o un argumento. `complete = "file"` hace que Neovim sugiera rutas. Otros valores frecuentes son `nargs = 0`, `nargs = 1`, `nargs = "*"`, `bang = true`, `range = true` y `count = true`.

Usa `nvim_create_user_command` en vez de concatenar texto de usuario en un comando shell. Si necesitas abrir una ruta, `fnameescape()` protege la sintaxis de Ex; si necesitas ejecutar un proceso, usa `vim.system()`.

### Ofrecer un mapping sin imponer una tecla

Un plugin no debería apropiarse de una combinación global sin necesidad. Expón un mapping `<Plug>`:

```lua
vim.keymap.set("n", "<Plug>(mi-plugin-fecha)", function()
    require("mi_primer_plugin").insertar_fecha()
end, {
    desc = "Inserta la fecha",
})
```

El usuario elige la tecla en su configuración:

```lua
vim.keymap.set("n", "<leader>fd", "<Plug>(mi-plugin-fecha)", {
    desc = "Insertar fecha",
})
```

Si la acción solo tiene sentido dentro de un buffer específico, usa `buffer = bufnr` para que el mapping sea local y desaparezca con el buffer.

### Ejecutar algo al abrir o guardar un archivo

Los autocomandos son apropiados para reaccionar a eventos de Neovim. Usa un grupo con nombre para poder reemplazarlos sin duplicados:

```lua
local group = vim.api.nvim_create_augroup("MiPluginMarkdown", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "markdown",
    callback = function(args)
        vim.bo[args.buf].textwidth = 100
    end,
    desc = "Configura Markdown para el plugin",
})
```

El callback recibe `args`. Usa `args.buf` para modificar el buffer que disparó el evento, no asumas que sigue siendo el buffer actual si el trabajo es asíncrono.

### Crear un buffer de resultados

Para mostrar una lista, un diagnóstico o la salida de una acción, crea un buffer temporal:

```lua
local function mostrar_resultado(lines)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, "mi-plugin://resultado")
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    vim.api.nvim_set_current_buf(buf)
end

mostrar_resultado({ "Resultado", "---------", "Todo correcto" })
```

Usa `nvim_open_win` si quieres una ventana flotante en lugar de reemplazar la ventana actual. Para una interfaz de entrada simple, prefiere `vim.ui.input`; para elegir entre opciones, prefiere `vim.ui.select`. La guía de [interfaces nativas](03-interfaces-nativas.md) desarrolla estos casos.

### Ejecutar un proceso externo

Para Git, formateadores u otras herramientas del sistema, usa una lista de argumentos y no bloquees la interfaz:

```lua
vim.system({ "git", "status", "--short" }, { text = true }, function(result)
    vim.schedule(function()
        if result.code ~= 0 then
            vim.notify(result.stderr, vim.log.levels.ERROR)
            return
        end

        vim.notify(result.stdout ~= "" and result.stdout or "Sin cambios")
    end)
end)
```

La callback puede ejecutarse cuando el usuario ya cerró el buffer o la ventana que inició la acción. Si vas a actualizarlos, verifica antes `nvim_buf_is_valid()` y `nvim_win_is_valid()`.

## Cómo elegir la API

| Quiero... | Empiezo con... |
| --- | --- |
| Mostrar un mensaje breve | `vim.notify()` |
| Pedir texto | `vim.ui.input()` |
| Elegir una opción | `vim.ui.select()` |
| Registrar una orden con `:` | `nvim_create_user_command()` |
| Ejecutar código al guardar o abrir | `nvim_create_autocmd()` |
| Añadir una tecla configurable | `vim.keymap.set()` y `<Plug>` |
| Mostrar muchas líneas | Buffer temporal |
| Mostrar una ventana sobre el editor | `nvim_open_win()` |
| Ejecutar una herramienta externa | `vim.system()` |
| Marcar texto sin modificarlo | Extmarks o diagnostics |

## Referencia rápida de APIs

### Buffers, ventanas y tabs

Un buffer contiene texto, una ventana muestra un buffer y un tabpage agrupa ventanas. Usa las APIs directamente cuando exista una alternativa a `vim.cmd`:

```lua
local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Resultado", "---------" })

local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = 40,
    height = 5,
    row = 2,
    col = 2,
    style = "minimal",
    border = "rounded",
})
```

Comprueba `vim.api.nvim_buf_is_valid(buf)` y `vim.api.nvim_win_is_valid(win)` antes de reutilizar esos identificadores.

### Datos y rutas

- `vim.tbl_deep_extend("force", ...)` combina opciones anidadas.
- `vim.deepcopy(value)` copia configuración sin compartir referencias.
- `vim.validate(...)` valida argumentos públicos.
- `vim.inspect(value)` ayuda a diagnosticar.
- `vim.schedule(callback)` vuelve al ciclo principal.
- `vim.notify(message, level, opts)` muestra mensajes reemplazables.
- `vim.fs.find`, `vim.fs.dirname`, `vim.fs.basename` y `vim.fs.joinpath` manejan rutas portables.

Usa `vim.fn.stdpath("data")` para datos persistentes, `"state"` para estado regenerable y `"cache"` para cachés. No guardes datos del usuario en el repositorio.

### Extmarks, LSP y Tree-sitter

Los extmarks sirven para decoraciones que sobreviven a ediciones:

```lua
local namespace = vim.api.nvim_create_namespace("mi_plugin")
vim.api.nvim_buf_set_extmark(0, namespace, 0, 0, {
    virt_text = { { "  <- aquí", "Comment" } },
    virt_text_pos = "eol",
})
```

Para diagnostics usa `vim.diagnostic.set` con un namespace propio. Un plugin puede usar `vim.lsp.start`, `vim.lsp.get_clients` y `vim.lsp.buf_request`, pero debe tolerar que no exista un servidor activo. Las queries de Tree-sitter viven en `queries/<lenguaje>/`; si falta un parser, la funcionalidad debe degradarse sin impedir abrir el buffer.

## Siguiente paso

Cuando el plugin funcione, añade documentación en `doc/`, pruebas headless y una configuración de gestor. Consulta [Documentación y compatibilidad](04-documentacion-y-compatibilidad.md) y [Pruebas y publicación](05-pruebas-y-publicacion.md).
