# Crear plugins nativos para Neovim 0.12+

Esta guía explica cómo diseñar, conectar, probar y distribuir un plugin de Neovim escrito en Lua, usando únicamente las APIs que ofrece Neovim. El objetivo es terminar con un plugin pequeño, mantenible y compatible con Neovim 0.12 o posterior, sin depender de `nvim-lspconfig`, `plenary.nvim` ni otro plugin externo.

La documentación oficial sigue siendo la referencia definitiva:

- [`:help lua-guide`](https://neovim.io/doc/user/lua-guide.html)
- [`:help api`](https://neovim.io/doc/user/api.html)
- [`:help lua`](https://neovim.io/doc/user/lua.html)
- [`:help runtime`](https://neovim.io/doc/user/runtime.html)
- [`:help dev`](https://neovim.io/doc/user/develop.html)

## 1. Qué es un plugin

Un plugin de Neovim es código y recursos que Neovim descubre mediante su `runtimepath` (`'runtimepath'`). Puede contener Lua, comandos, autocomandos, mappings, documentación, colores, queries de Tree-sitter, archivos `ftplugin` y otros recursos.

Un plugin bien diseñado suele tener estas responsabilidades:

1. Exponer un módulo Lua, normalmente `require("mi_plugin")`.
2. Ofrecer una función pública de configuración, normalmente `setup(opts)`.
3. Registrar solamente los comandos, autocomandos y mappings necesarios.
4. Mantener su estado encapsulado y evitar contaminar variables globales.
5. Funcionar aunque el usuario no lo configure, con valores predeterminados razonables.
6. Informar errores de configuración sin romper el arranque completo de Neovim.

Un plugin no necesita un instalador especial. Un gestor como `lazy.nvim`, `mini.deps`, `vim-plug` o `packer` solamente coloca el repositorio dentro del `runtimepath` y, opcionalmente, decide cuándo cargarlo. El descubrimiento y la ejecución del código dependen de la estructura del repositorio.

## 2. Estructura recomendada

Una estructura inicial, suficiente para muchos plugins, es:

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

Cada directorio tiene una función distinta:

| Ruta | Propósito |
| --- | --- |
| `lua/mi_plugin/` | Módulos cargables con `require("mi_plugin")`. |
| `lua/mi_plugin/init.lua` | Módulo principal; suele contener `setup`. |
| `plugin/` | Código que Neovim ejecuta automáticamente cuando el plugin entra en el `runtimepath`. |
| `doc/` | Ayuda nativa consultable con `:help mi-plugin`. |
| `ftplugin/` | Configuración específica de un tipo de archivo. |
| `after/` | Recursos que deben cargarse después de los equivalentes de otros plugins. |
| `colors/` | Esquemas de color cargables con `:colorscheme`. |
| `syntax/` | Definiciones de sintaxis tradicionales. |
| `queries/` | Capturas y queries de Tree-sitter por lenguaje. |

También puedes encontrar `autoload/` en plugins antiguos de Vimscript. Para un plugin nuevo en Lua no suele ser necesario: los módulos de `lua/` ya ofrecen carga bajo demanda mediante `require`.

### `lua/` frente a `plugin/`

`plugin/mi_plugin.lua` se ejecuta automáticamente una vez por instancia de Neovim. No debe contener toda la implementación. Su función ideal es registrar una entrada pequeña y llamar al módulo principal:

```lua
if vim.g.loaded_mi_plugin then
    return
end
vim.g.loaded_mi_plugin = true

vim.api.nvim_create_user_command("MiPluginSaludar", function()
    require("mi_plugin").saludar()
end, {})
```

El módulo en `lua/` se carga bajo demanda con `require`. Esto permite que un gestor de plugins difiera el trabajo costoso y también facilita las pruebas unitarias.

Evita llamar `setup()` automáticamente desde `lua/mi_plugin/init.lua`. El usuario debe poder decidir cuándo y con qué opciones configurarlo. Si necesitas valores mínimos aun sin configuración, usa defaults internos, pero no registres efectos inesperados al hacer solamente `require`.

## 3. El ciclo de vida de un plugin

Una forma útil de pensar en el ciclo de vida es:

1. **Descubrimiento**: el gestor agrega el directorio al `runtimepath`.
2. **Carga automática**: Neovim ejecuta archivos dentro de `plugin/`.
3. **Configuración**: el usuario llama a `require("mi_plugin").setup(opts)`.
4. **Uso**: comandos, mappings, autocomandos o funciones públicas invocan el comportamiento.
5. **Limpieza**: si el plugin crea recursos temporales, los elimina al cerrar o al desactivar la funcionalidad.

Un plugin puede ser cargado por evento, por tipo de archivo, por comando, por mapping o al inicio. Diseña el código para que el orden sea seguro: `setup()` debe poder ejecutarse después de que `plugin/` se haya evaluado, y registrar dos veces los mismos recursos no debería crear duplicados.

Para protegerse contra doble carga, usa una variable global de carga en el archivo `plugin/`. Para proteger `setup()`, guarda el estado dentro del módulo y decide explícitamente si una segunda llamada reemplaza opciones o debe ser ignorada.

## 4. Plugin mínimo funcional

Este ejemplo crea un comando que saluda usando el nombre del usuario. No requiere dependencias externas.

### `lua/mi_plugin/init.lua`

```lua
local M = {}

local defaults = {
    greeting = "Hola",
}

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
end, {
    desc = "Saluda desde mi plugin",
})
```

### Configuración del usuario

Con un gestor de plugins, el usuario puede escribir:

```lua
{
    "usuario/mi-plugin",
    config = function()
        require("mi_plugin").setup({
            greeting = "Buenos días",
        })
    end,
}
```

Si el plugin está instalado manualmente en un directorio incluido en `'runtimepath'`, basta con:

```lua
require("mi_plugin").setup()
```

Después, `:MiPluginSaludar` ejecuta la funcionalidad.

## 5. Cómo conectarlo a Neovim

### Comandos de usuario

Usa `vim.api.nvim_create_user_command` en lugar de construir comandos con `vim.cmd` y concatenar strings. Los argumentos llegan en una tabla y se pueden validar:

```lua
vim.api.nvim_create_user_command("MiPluginAbrir", function(command)
    local path = command.args
    if path == "" then
        vim.notify("Falta una ruta", vim.log.levels.WARN)
        return
    end
    vim.cmd.edit(vim.fn.fnameescape(path))
end, {
    nargs = "?",
    complete = "file",
    desc = "Abre una ruta desde mi plugin",
})
```

Opciones útiles: `nargs`, `bang`, `range`, `count`, `complete`, `completefunc`, `-bar` y `desc`. Consulta `:help nvim_create_user_command`.

### Mappings

Registra mappings con `vim.keymap.set`, preferiblemente dentro de `setup()` y con un `desc`:

```lua
vim.keymap.set("n", "<Plug>(mi-plugin-saludar)", function()
    require("mi_plugin").saludar()
end, { desc = "Saluda desde mi plugin" })
```

No impongas una tecla global concreta sin necesidad. Los mappings `<Plug>` permiten que el usuario elija su combinación. Si ofreces una opción, hazla configurable y evita sobrescribir mappings existentes sin advertirlo.

### Autocomandos y grupos

Usa un grupo augroup para poder reemplazar o limpiar tus autocomandos sin duplicarlos:

```lua
local group = vim.api.nvim_create_augroup("MiPlugin", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = "*.mi",
    callback = function(args)
        vim.notify("Guardado: " .. args.file, vim.log.levels.INFO)
    end,
    desc = "Notifica archivos .mi guardados",
})
```

Registra solamente los eventos necesarios. Un autocomando global que se ejecuta en cada buffer puede tener un coste importante.

### Buffers, ventanas y tabs

Neovim separa estos conceptos: un buffer contiene texto, una ventana muestra un buffer y un tabpage agrupa ventanas. Usa las APIs `nvim_create_buf`, `nvim_buf_set_lines`, `nvim_buf_get_lines`, `nvim_open_win` y `nvim_win_set_buf` en vez de editar texto mediante comandos cuando no sea necesario.

Para un buffer temporal:

```lua
local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_name(buf, "mi-plugin://resultado")
vim.bo[buf].buftype = "nofile"
vim.bo[buf].bufhidden = "wipe"
vim.bo[buf].swapfile = false
vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Resultado", "---------" })
```

Guarda y reutiliza identificadores de buffer o namespace cuando corresponda, pero comprueba `vim.api.nvim_buf_is_valid(id)` antes de usarlos.

### Autocompletado y confirmaciones

Para entrada simple, usa `vim.ui.input`. Para una selección, usa `vim.ui.select`. Son interfaces nativas que los usuarios y otros plugins pueden reemplazar:

```lua
vim.ui.input({ prompt = "Nombre: " }, function(value)
    if value and value ~= "" then
        vim.notify("Elegiste " .. value)
    end
end)
```

No asumas que la UI siempre es una ventana flotante propia. Respeta estas abstracciones para integrarte con la configuración del usuario.

## 6. APIs nativas que conviene conocer

### Datos y utilidades de Lua

- `vim.tbl_deep_extend("force", ...)`: combina opciones anidadas.
- `vim.deepcopy(value)`: copia tablas de configuración sin compartir referencias.
- `vim.validate(...)`: valida argumentos de funciones públicas.
- `vim.inspect(value)`: representación útil para diagnóstico.
- `vim.split(text, sep, opts)`: separa texto respetando opciones de Neovim.
- `vim.schedule(callback)`: difiere una operación al ciclo principal cuando una callback asíncrona no puede modificar la UI directamente.
- `vim.notify(message, level, opts)`: mensajes no invasivos y reemplazables.

Valida las entradas públicas temprano:

```lua
function M.set_name(name)
    vim.validate({ name = { name, "string" } })
    -- ...
end
```

### Filesystem y rutas

Para rutas portables, prefiere `vim.fs` y `vim.fn.stdpath`:

```lua
local config_dir = vim.fn.stdpath("config")
local data_dir = vim.fn.stdpath("data")
local state_dir = vim.fn.stdpath("state")

for path in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
    -- Recorrer padres cuando sea necesario.
end
```

`vim.fs.find`, `vim.fs.dirname`, `vim.fs.basename`, `vim.fs.normalize` y `vim.fs.joinpath` son preferibles a concatenar `/` manualmente. Para leer y escribir archivos pequeños puedes usar `vim.fn.readfile` y `vim.fn.writefile`; para operaciones asíncronas o grandes considera `vim.uv`.

No guardes datos de usuario dentro del repositorio del plugin. Usa `stdpath("data")` para datos persistentes, `stdpath("state")` para estado regenerable y `stdpath("cache")` para cachés descartables. Crea directorios con `vim.fn.mkdir(path, "p")` y comprueba errores.

### Procesos externos

`vim.system` es la interfaz moderna para lanzar procesos:

```lua
vim.system({ "git", "status", "--short" }, { text = true }, function(result)
    vim.schedule(function()
        if result.code ~= 0 then
            vim.notify(result.stderr, vim.log.levels.ERROR)
            return
        end
        vim.notify(result.stdout, vim.log.levels.INFO)
    end)
end)
```

No construyas un comando shell concatenando entrada del usuario. Usa una lista de argumentos para evitar problemas de quoting e inyección. Si necesitas un proceso interactivo o control fino de streams, consulta `:help vim.uv` y `:help jobstart()`.

`vim.uv` es el nombre actual de la biblioteca libuv expuesta por Neovim. En código que deba funcionar también en versiones anteriores pueden existir referencias históricas a `vim.loop`; para este objetivo usa la API documentada para Neovim 0.12+ y verifica cambios de compatibilidad en la versión exacta que soportes.

### Async, timers y eventos

Para no bloquear la interfaz, mueve I/O o procesos fuera del hilo principal. `vim.system`, `vim.uv.fs_*`, `vim.uv.new_timer()` y `vim.schedule()` son herramientas habituales.

```lua
local timer = vim.uv.new_timer()
timer:start(250, 0, function()
    timer:stop()
    timer:close()
    vim.schedule(function()
        vim.notify("Trabajo terminado")
    end)
end)
```

Cierra timers, handles y watchers. Una callback asíncrona puede ejecutarse después de que el buffer o la ventana original hayan desaparecido, por lo que debes verificar su validez.

### Opciones, variables y namespaces

- `vim.o` y `vim.opt`: opciones globales.
- `vim.bo[buf]` y `vim.wo[win]`: opciones locales.
- `vim.g`: variables globales compartidas; úsalas solo para una integración explícita.
- `vim.b[buf]` y `vim.w[win]`: estado asociado a buffer o ventana.
- `nvim_create_namespace`: identificador para decoraciones, diagnostics o extmarks propios.

Evita nombres globales genéricos como `vim.g.enabled`. Prefiere una tabla privada del módulo o un nombre con prefijo, por ejemplo `vim.g.mi_plugin_loaded`.

### Extmarks y decoraciones

Los extmarks son la base nativa para marcar posiciones que sobreviven a ediciones:

```lua
local namespace = vim.api.nvim_create_namespace("mi_plugin")
local mark = vim.api.nvim_buf_set_extmark(0, namespace, 0, 0, {
    virt_text = {{ "  <- aquí", "Comment" }},
    virt_text_pos = "eol",
})
```

Para decoraciones masivas, usa `nvim_buf_set_extmark` con opciones como `hl_group`, `sign_text`, `virt_lines` o `conceal`. Para diagnostics usa `vim.diagnostic.set(namespace, bufnr, diagnostics, opts)`, no namespaces ajenos.

### LSP y Tree-sitter

Neovim incluye clientes LSP y APIs para iniciar o consultar servidores. Un plugin puede usar `vim.lsp.start`, `vim.lsp.get_clients`, `vim.lsp.buf_request` y `vim.lsp.protocol.make_client_capabilities` sin añadir un wrapper externo. No asumas que existe un servidor o que está activo: filtra por `bufnr`, `name` o `method` y maneja el caso vacío.

Para Tree-sitter, usa las APIs disponibles en la versión objetivo y captura el caso en que el parser no esté instalado. Las queries viven en `queries/<lenguaje>/` y permiten extender capturas sin modificar archivos del usuario. El soporte de una query debe ser opcional: un plugin no debe impedir abrir un buffer porque falte un parser.

## 7. Documentación nativa

El archivo `doc/mi_plugin.txt` debe usar el formato de ayuda de Vim. Un esqueleto correcto es:

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

Después de instalarlo, ejecuta `:helptags ALL` si el gestor no generó tags automáticamente. Comprueba que `:help mi-plugin` abre el documento y que cada referencia `|tag|` apunta a un tag existente.

El README debe explicar instalación, requisitos, configuración, comandos, mappings, ejemplos y limitaciones. La ayuda `:help` debe contener la referencia técnica estable; no dependas solamente de un README externo.

## 8. Configuración y compatibilidad

Usa una tabla `defaults` y mezcla una copia, como en el ejemplo. No modifiques directamente la tabla que recibe el usuario. Para opciones incompatibles, falla pronto con `vim.validate` o una notificación clara.

Define la versión mínima en varios lugares coherentes:

- `README.md` y `doc/mi_plugin.txt`.
- Metadatos del gestor de plugins, si los admite.
- CI o scripts de prueba.
- Código: evita APIs nuevas si declaras soporte para una versión menor.

No compruebes solamente `has("nvim-0.12")` si la diferencia es una función concreta. Para compatibilidad condicional es más robusto comprobar la API que usarás:

```lua
if type(vim.system) ~= "function" then
    error("mi_plugin requiere Neovim 0.12 o posterior")
end
```

No conviertas toda la implementación en una colección de ramas para versiones antiguas si el plugin solamente soporta 0.12+. Mantén una matriz de compatibilidad pequeña y explícita.

## 9. Cuando `vim` no ofrece completado ni tipos

Es importante distinguir dos problemas diferentes:

- `vim` aparece como variable global no definida: falta declarar `vim` para los diagnósticos de `lua_ls`.
- `vim.api.nvim_create_user_command`, `vim.fs`, `vim.uv` u otros métodos no ofrecen completado o firmas: `lua_ls` no está cargando las definiciones del runtime de Neovim.

Para el segundo caso, `diagnostics.globals = { "vim" }` no es suficiente. Esa opción solamente elimina el warning; no añade tipos ni documentación.

### Solución recomendada: `lazydev.nvim`

`lazydev.nvim` proporciona a `lua_ls` el conocimiento del runtime y de los plugins cargados. En esta configuración ya está incluido en `lua/plugins/lazydev.lua` y `blink.cmp` tiene habilitada su fuente de completado.

Comprueba el estado desde Neovim:

```vim
:LazyDev
:LazyDev lsp
:LspInfo
```

Abre un archivo Lua dentro del proyecto del plugin y verifica que `lua_ls` esté adjunto. Después prueba `vim.api.` o `vim.fs.`. Si acabas de cambiar la configuración, usa `:LspReload` en esta configuración o reinicia Neovim.

### Caso especial: `.luarc.json` o `.luarc.jsonc`

La configuración de este repositorio desactiva `lazydev.nvim` cuando detecta un `.luarc.json` o `.luarc.jsonc`, porque esos archivos normalmente indican que el proyecto administra su propio workspace de Lua. Para un proyecto de plugin que tenga uno de esos archivos, habilítalo explícitamente en una configuración local de Neovim:

```lua
-- .nvim.lua dentro del repositorio del plugin
vim.g.lazydev_enabled = true
```

Luego activa la confianza de archivos locales si todavía no usas `exrc`:

```vim
:set exrc
:set secure
```

Revisa siempre un `.nvim.lua` antes de confiar en él, porque puede ejecutar código Lua al entrar en el directorio. El override se añadió para que `lazydev.nvim` pueda convivir con un `.luarc.json` propio sin tener que eliminar la configuración del proyecto.

### Alternativa sin `lazydev.nvim`

Si desarrollas en otra instalación de Neovim, configura `lua_ls` directamente. Un `.luarc.json` mínimo puede declarar `vim` y añadir el runtime Lua de Neovim:

```json
{
    "runtime": {
        "version": "LuaJIT"
    },
    "diagnostics": {
        "globals": ["vim"]
    },
    "workspace": {
        "checkThirdParty": false,
        "library": ["/usr/share/nvim/runtime/lua"]
    }
}
```

La ruta `/usr/share/nvim/runtime/lua` depende de la instalación. Puedes obtener la ruta real desde Neovim con:

```vim
:lua print(vim.env.VIMRUNTIME .. "/lua")
```

En esta configuración puedes generar el archivo automáticamente desde la raíz del proyecto con `:PluginLuarc` o `<leader>hp`. El helper escribe la ruta real de `VIMRUNTIME`, crea un archivo mínimo y no sobrescribe un `.luarc.json` existente.

En un proyecto distribuido no fijes una ruta específica de Linux. Usa `lazydev.nvim` o genera la configuración desde la instalación local de Neovim. No añadas solamente `"vim"` a `diagnostics.globals` esperando obtener completado: son funciones distintas.

## 10. Cómo probar el plugin

### Prueba manual aislada

Primero prueba con una configuración limpia para descubrir dependencias accidentales:

```bash
nvim --clean -u NONE
```

Para cargar el plugin desde un checkout local, añade su ruta al `runtimepath` durante la sesión:

```vim
:set runtimepath^=/ruta/absoluta/a/mi-plugin
:lua require("mi_plugin").setup()
:MiPluginSaludar
```

También puedes preparar un `tests/minimal_init.lua`:

```lua
vim.opt.rtp:prepend(vim.fn.getcwd())
require("mi_plugin").setup()
```

Y arrancar:

```bash
nvim --clean -u tests/minimal_init.lua
```

### Pruebas headless

Las comprobaciones de carga no necesitan un framework externo:

```bash
nvim --headless --clean -u NONE \
    -c 'set rtp^=.' \
    -c 'lua assert(type(require("mi_plugin").setup) == "function")' \
    -c 'qa!'
```

Para escenarios más grandes, usa un script Lua ejecutado con `nvim --headless -l tests/test_plugin.lua`, o inicia una instancia con `nvim --headless -u tests/minimal_init.lua -c 'qa!'`. Cada prueba debe terminar con `qa!` y devolver un código distinto de cero si falla.

### Qué probar

- `require("mi_plugin")` funciona sin configuración.
- `setup()` acepta defaults y opciones parciales.
- Una segunda llamada a `setup()` no duplica autocmds ni mappings.
- Los comandos validan argumentos inválidos.
- El plugin funciona con un buffer vacío y con un buffer sin nombre.
- Callbacks asíncronas toleran buffers y ventanas cerrados.
- Procesos que fallan muestran un error útil y no dejan handles abiertos.
- `:help mi-plugin` existe y sus tags resuelven.
- El plugin carga en `nvim --clean` sin dependencias ocultas.

### Diagnóstico integrado

Durante el desarrollo son especialmente útiles:

```vim
:checkhealth
:messages
:scriptnames
:set runtimepath?
:verbose command MiPluginSaludar
:autocmd MiPlugin
:verbose nmap <Plug>(mi-plugin-saludar)
:lua print(vim.inspect(require("mi_plugin")))
```

`vim.notify` es útil para eventos normales, pero no llenes `:messages` en cada tecla. Para diagnóstico detallado ofrece una opción `debug` o usa `vim.lsp.log`/un archivo de log con moderación.

## 11. Integración con gestores de plugins

El plugin debe ser independiente del gestor. El gestor necesita saber dónde está el repositorio y cuándo cargarlo; tu código solamente debe asumir que sus archivos están en el `runtimepath`.

Ejemplo conceptual con `lazy.nvim`:

```lua
{
    "usuario/mi-plugin",
    event = "VeryLazy",
    cmd = "MiPluginSaludar",
    opts = {
        greeting = "Hola",
    },
}
```

`opts` normalmente termina llamando a `setup(opts)`, pero no acoples el plugin a ese comportamiento. El plugin debe funcionar igual si el usuario lo carga manualmente o con otro gestor.

Si un comando es el disparador de carga, el archivo `plugin/` debe registrar ese comando al cargarse. Si un mapping necesita que el plugin esté presente, el gestor puede usar `keys`; si quieres máxima portabilidad, expón `<Plug>` y documenta el mapping manual.

## 12. Rendimiento y errores comunes

- No ejecutes `require` pesado, escaneos de todo el proyecto o procesos externos durante el arranque sin necesidad.
- No hagas trabajo por cada `CursorMoved` o `TextChangedI` sin debounce y sin medir.
- No escribas al disco en cada cambio de texto; usa timers o eventos de guardado.
- No dependas del directorio de trabajo actual; usa `vim.fn.getcwd()` solo cuando realmente represente el proyecto.
- No uses `os.execute`, `io.popen` ni `vim.fn.system` con strings construidos a partir de entrada del usuario.
- No sobrescribas opciones globales del usuario sin ofrecer una opción clara y documentada.
- No uses `vim.cmd` para lógica que tiene una API Lua equivalente.
- No mantengas referencias a buffers, ventanas o jobs sin verificar que siguen siendo válidos.
- No atrapes todos los errores silenciosamente con `pcall` sin informar el motivo.
- No cargues librerías opcionales al nivel superior si solamente se necesitan para una función concreta.

Para medir problemas de arranque usa `:StartupTime`, `:profile start`, `:profile func *` y `:profile file *`. Una optimización debe basarse en una medición y no solamente en intuición.

## 13. Seguridad

Un plugin puede leer archivos, lanzar procesos y modificar buffers. Trátalo como software con permisos importantes:

- Escapa o, mejor, separa argumentos de procesos con `vim.system({ ... })`.
- No descargues ni ejecutes código automáticamente sin consentimiento explícito.
- No guardes tokens en `vim.g`, logs o mensajes.
- Valida rutas y evita seguir enlaces simbólicos si la operación es destructiva.
- Pide confirmación antes de sobrescribir archivos o ejecutar acciones irreversibles.
- Documenta qué datos persistentes crea y dónde los guarda.

## 14. Publicación y mantenimiento

Antes de publicar:

1. Prueba en una configuración limpia y en la versión mínima soportada.
2. Comprueba que el repositorio se instala sin archivos generados innecesarios.
3. Añade licencia y README.
4. Genera tags de ayuda y prueba `:help mi-plugin`.
5. Documenta comandos, opciones, eventos, dependencias y limitaciones.
6. Añade un changelog para cambios incompatibles.
7. Fija o declara dependencias opcionales de manera explícita.
8. Ejecuta un lint de Lua y un formateador consistente.

Versiona la API pública. Si cambias el nombre de una opción o comando, documenta la migración. Evita prometer compatibilidad con una versión de Neovim que no pruebas realmente.

## 15. Receta de implementación desde cero

1. Define una sola responsabilidad y un caso de uso verificable.
2. Crea `lua/mi_plugin/init.lua` y devuelve una tabla `M`.
3. Implementa `setup(opts)` con defaults copiados.
4. Añade un comando o función pública mínima.
5. Usa `plugin/mi_plugin.lua` solo para registros automáticos y protegidos contra doble carga.
6. Añade un namespace propio si necesitas extmarks, diagnostics o highlights.
7. Usa `vim.ui`, `vim.system`, `vim.fs` y las APIs de buffer antes de añadir dependencias.
8. Escribe ayuda en `doc/mi_plugin.txt`.
9. Prueba con `nvim --clean` y en modo headless.
10. Mide el rendimiento, documenta la configuración y publica una primera versión pequeña.

La regla más importante es mantener una frontera clara: el módulo contiene comportamiento reutilizable, `plugin/` conecta ese comportamiento con Neovim, y el usuario conserva el control sobre configuración, mappings y recursos globales.
