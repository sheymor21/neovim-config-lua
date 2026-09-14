# Ciclo de vida y APIs

## Ciclo de vida

1. **Descubrimiento**: el gestor agrega el directorio al `runtimepath`.
2. **Carga automática**: Neovim ejecuta los archivos dentro de `plugin/`.
3. **Configuración**: el usuario llama a `require("mi_plugin").setup(opts)`.
4. **Uso**: comandos, mappings o funciones públicas invocan el comportamiento.
5. **Limpieza**: se eliminan recursos temporales al cerrar o desactivar la funcionalidad.

Protege el archivo `plugin/` contra doble carga. `setup()` debe decidir explícitamente si una segunda llamada reemplaza opciones o se ignora. Un augroup con `{ clear = true }` y mappings buffer-locales ayudan a evitar duplicados.

## Comandos, mappings y autocomandos

Usa `nvim_create_user_command` en lugar de concatenar strings con `vim.cmd`:

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

Opciones útiles: `nargs`, `bang`, `range`, `count`, `complete` y `desc`.

Registra mappings con `vim.keymap.set`, preferiblemente dentro de `setup()` y con descripción. No impongas una tecla global sin necesidad; `<Plug>` permite que el usuario elija:

```lua
vim.keymap.set("n", "<Plug>(mi-plugin-saludar)", function()
    require("mi_plugin").saludar()
end, { desc = "Saluda desde mi plugin" })
```

Usa un grupo para autocomandos reemplazables:

```lua
local group = vim.api.nvim_create_augroup("MiPlugin", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = "*.mi",
    callback = function(args)
        vim.notify("Guardado: " .. args.file)
    end,
})
```

## Buffers, ventanas y tabs

Un buffer contiene texto, una ventana muestra un buffer y un tabpage agrupa ventanas. Usa las APIs `nvim_create_buf`, `nvim_buf_set_lines`, `nvim_open_win` y `nvim_win_set_buf` en vez de comandos cuando exista una API equivalente.

```lua
local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_name(buf, "mi-plugin://resultado")
vim.bo[buf].buftype = "nofile"
vim.bo[buf].bufhidden = "wipe"
vim.bo[buf].swapfile = false
vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Resultado", "---------" })
```

Guarda identificadores de buffer o namespace cuando corresponda, pero comprueba `vim.api.nvim_buf_is_valid(id)` y `vim.api.nvim_win_is_valid(id)` antes de usarlos.

## APIs útiles

### Datos y rutas

- `vim.tbl_deep_extend("force", ...)` combina opciones anidadas.
- `vim.deepcopy(value)` copia configuración sin compartir referencias.
- `vim.validate(...)` valida argumentos públicos.
- `vim.inspect(value)` ayuda a diagnosticar.
- `vim.schedule(callback)` vuelve al ciclo principal.
- `vim.notify(message, level, opts)` muestra mensajes reemplazables.
- `vim.fs.find`, `vim.fs.dirname`, `vim.fs.basename` y `vim.fs.joinpath` manejan rutas portables.

Usa `vim.fn.stdpath("data")` para datos persistentes, `"state"` para estado regenerable y `"cache"` para cachés. No guardes datos del usuario en el repositorio.

### Procesos y asincronía

`vim.system` evita problemas de quoting al recibir una lista de argumentos:

```lua
vim.system({ "git", "status", "--short" }, { text = true }, function(result)
    vim.schedule(function()
        if result.code ~= 0 then
            vim.notify(result.stderr, vim.log.levels.ERROR)
            return
        end
        vim.notify(result.stdout)
    end)
end)
```

Para no bloquear la UI usa `vim.system`, `vim.uv.fs_*`, `vim.uv.new_timer()` y `vim.schedule()`. Cierra timers, handles y watchers. Las callbacks pueden ejecutarse después de que desaparezca el buffer o la ventana original.

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
