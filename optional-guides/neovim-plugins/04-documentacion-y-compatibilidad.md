# Documentación y compatibilidad

## Documentación nativa

El archivo `doc/mi_plugin.txt` usa el formato de ayuda de Vim y debe contener la referencia técnica estable:

```text
*mi-plugin.txt*  Herramientas de mi plugin

============================================================================
CONTENIDO                                                    *mi-plugin-contents*

1. Introducción                                               |mi-plugin-intro|
2. Configuración                                               |mi-plugin-setup|

============================================================================
INTRODUCCIÓN                                                  *mi-plugin-intro*

Mi plugin añade una funcionalidad pequeña a Neovim.

CONFIGURACIÓN                                                  *mi-plugin-setup*

                                                          *mi_plugin.setup()*
require("mi_plugin").setup({})

 vim:tw=78:ts=8:ft=help:norl:
```

Después de instalarlo, ejecuta `:helptags ALL` si el gestor no generó tags automáticamente. Comprueba que `:help mi-plugin` abre el documento y que cada referencia `|tag|` existe.

El README del plugin debe explicar instalación, requisitos, configuración, comandos, mappings, ejemplos y limitaciones. La ayuda `:help` debe ser suficiente para consultar la API sin depender de un sitio externo.

## Configuración

Usa defaults copiados y no modifiques la tabla recibida:

```lua
local defaults = { enabled = true, debug = false }

function M.setup(opts)
    config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
end
```

Valida las entradas públicas temprano:

```lua
function M.set_name(name)
    vim.validate({ name = { name, "string" } })
end
```

## Compatibilidad

Declara la versión mínima en `README.md`, `doc/mi_plugin.txt`, los metadatos del gestor y CI. Si soportas Neovim 0.12+, evita ramas para versiones antiguas que no pruebas. Para una API concreta, comprueba la función:

```lua
if type(vim.system) ~= "function" then
    error("mi_plugin requiere Neovim 0.12 o posterior")
end
```

No prometas compatibilidad con una versión que no hayas probado realmente.

## Completado y tipos de Lua

Hay dos problemas distintos:

- `vim` aparece como global desconocida: falta declararlo para los diagnósticos de `lua_ls`.
- Los métodos de `vim.api`, `vim.fs` o `vim.uv` no tienen completado: `lua_ls` no está cargando las definiciones del runtime de Neovim.

`diagnostics.globals = { "vim" }` solo elimina el warning; no añade tipos.

### `lazydev.nvim`

`lazydev.nvim` proporciona a `lua_ls` el runtime de Neovim y de los plugins cargados. Comprueba:

```vim
:LazyDev
:LazyDev lsp
:LspInfo
```

Abre un archivo Lua del plugin y verifica que `lua_ls` esté adjunto. Después prueba `vim.api.` o `vim.fs.`.

### `.luarc.json`

Si el proyecto administra su propio workspace, puedes usar un `.luarc.json` mínimo:

```json
{
    "runtime": { "version": "LuaJIT" },
    "diagnostics": { "globals": ["vim"] },
    "workspace": {
        "checkThirdParty": false,
        "library": ["/usr/share/nvim/runtime/lua"]
    }
}
```

La ruta depende de la instalación. Obtén la real con `:lua print(vim.env.VIMRUNTIME .. "/lua")`. En esta configuración puedes generar un archivo con `:PluginLuarc` o `<leader>hp`; no sobrescribe uno existente.

Si existe `.luarc.json` o `.luarc.jsonc`, `lazydev.nvim` puede quedar desactivado por la configuración del proyecto. Un `.nvim.lua` local puede activar `vim.g.lazydev_enabled = true`, pero revisa su contenido antes de confiar en él y usa `:set exrc` y `:set secure` conscientemente.
