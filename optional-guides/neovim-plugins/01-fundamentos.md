# Fundamentos y estructura

## Qué es un plugin

Un plugin de Neovim es código y recursos que Neovim descubre mediante su `runtimepath` (`'runtimepath'`). Puede contener Lua, comandos, autocomandos, mappings, documentación, colores, queries de Tree-sitter, archivos `ftplugin` y otros recursos.

Un plugin bien diseñado suele:

- Exponer un módulo Lua, normalmente `require("mi_plugin")`.
- Ofrecer una función pública de configuración, normalmente `setup(opts)`.
- Registrar solamente los comandos, autocomandos y mappings necesarios.
- Mantener su estado encapsulado y evitar variables globales.
- Funcionar sin configuración con defaults razonables.
- Informar errores de configuración sin romper el arranque completo.

Un gestor como `lazy.nvim`, `mini.deps` o `vim-plug` solamente coloca el repositorio en el `runtimepath` y decide cuándo cargarlo. La estructura del repositorio determina qué ejecuta Neovim.

## Estructura recomendada

```text
mi-plugin/
├── lua/
│   └── mi_plugin/
│       └── init.lua
├── plugin/
│   └── mi_plugin.lua
├── doc/
│   └── mi_plugin.txt
├── tests/
│   └── minimal_init.lua
├── LICENSE
└── README.md
```

| Ruta | Propósito |
| --- | --- |
| `lua/mi_plugin/` | Módulos cargables con `require("mi_plugin")`. |
| `lua/mi_plugin/init.lua` | Módulo principal; suele contener `setup`. |
| `plugin/` | Código ejecutado automáticamente al entrar en el `runtimepath`. |
| `doc/` | Ayuda nativa consultable con `:help mi-plugin`. |
| `ftplugin/` | Configuración específica de un tipo de archivo. |
| `after/` | Recursos cargados después de los equivalentes de otros plugins. |
| `colors/` | Esquemas cargables con `:colorscheme`. |
| `queries/` | Queries de Tree-sitter por lenguaje. |

Para un plugin nuevo en Lua no suele ser necesario `autoload/`: los módulos de `lua/` ya ofrecen carga bajo demanda mediante `require`.

## `lua/` frente a `plugin/`

`plugin/mi_plugin.lua` se ejecuta una vez por instancia de Neovim. Debe ser pequeño y registrar entradas, no contener toda la implementación:

```lua
if vim.g.loaded_mi_plugin then
    return
end
vim.g.loaded_mi_plugin = true

vim.api.nvim_create_user_command("MiPluginSaludar", function()
    require("mi_plugin").saludar()
end, {})
```

El módulo en `lua/` se carga bajo demanda. No llames `setup()` automáticamente desde `init.lua`; el usuario debe decidir cuándo configurarlo.

## Plugin mínimo

### `lua/mi_plugin/init.lua`

```lua
local M = {}

local defaults = { greeting = "Hola" }
local config = vim.deepcopy(defaults)

function M.setup(opts)
    config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
end

function M.saludar()
    local name = vim.env.USER or vim.env.USERNAME or "Neovim"
    vim.notify(config.greeting .. ", " .. name .. "!", vim.log.levels.INFO)
end

return M
```

### `plugin/mi_plugin.lua`

```lua
if vim.g.loaded_mi_plugin then
    return
end
vim.g.loaded_mi_plugin = true

vim.api.nvim_create_user_command("MiPluginSaludar", function()
    require("mi_plugin").saludar()
end, { desc = "Saluda desde mi plugin" })
```

El usuario puede configurarlo con cualquier gestor:

```lua
{
    "usuario/mi-plugin",
    opts = { greeting = "Buenos días" },
}
```

El plugin debe funcionar igual si se carga manualmente con `require("mi_plugin").setup()`.
