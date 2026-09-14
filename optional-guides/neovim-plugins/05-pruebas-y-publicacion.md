# Pruebas y publicación

## Prueba manual aislada

Empieza con una configuración limpia para descubrir dependencias accidentales:

```bash
nvim --clean -u NONE
```

Desde la sesión puedes añadir el checkout al `runtimepath`:

```vim
:set runtimepath^=/ruta/absoluta/a/mi-plugin
:lua require("mi_plugin").setup()
:MiPluginSaludar
```

Un `tests/minimal_init.lua` puede contener:

```lua
vim.opt.rtp:prepend(vim.fn.getcwd())
require("mi_plugin").setup()
```

Y se ejecuta con:

```bash
nvim --clean -u tests/minimal_init.lua
```

## Pruebas headless

Una comprobación de carga no necesita framework externo:

```bash
nvim --headless --clean -u NONE \
    -c 'set rtp^=.' \
    -c 'lua assert(type(require("mi_plugin").setup) == "function")' \
    -c 'qa!'
```

Para escenarios mayores usa `nvim --headless -l tests/test_plugin.lua`. Cada prueba debe terminar con `qa!` y devolver un código distinto de cero si falla.

## Qué probar

- `require("mi_plugin")` funciona sin configuración.
- `setup()` acepta defaults y opciones parciales.
- Una segunda llamada no duplica autocmds ni mappings.
- Los comandos validan argumentos inválidos.
- El plugin funciona con un buffer vacío y sin nombre.
- Las callbacks asíncronas toleran buffers y ventanas cerrados.
- Los procesos que fallan muestran un error útil y no dejan handles abiertos.
- Las interfaces nativas se pueden cerrar con `<Esc>` o `q` cuando corresponda.
- `:help mi-plugin` existe y sus tags resuelven.
- El plugin carga en `nvim --clean` sin dependencias ocultas.

## Diagnóstico

Durante el desarrollo son útiles:

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

Usa `vim.notify` para eventos normales, pero no en cada tecla. Para diagnóstico detallado ofrece una opción `debug` o un log moderado.

## Gestores de plugins

El plugin debe ser independiente del gestor. Un ejemplo conceptual con `lazy.nvim`:

```lua
{
    "usuario/mi-plugin",
    event = "VeryLazy",
    cmd = "MiPluginSaludar",
    opts = { greeting = "Hola" },
}
```

Si un comando dispara la carga, `plugin/` debe registrar ese comando al cargarse. Si un mapping necesita que el plugin esté presente, el gestor puede usar `keys`; para máxima portabilidad expón `<Plug>`.

## Rendimiento, seguridad y mantenimiento

- No hagas escaneos del proyecto ni procesos externos durante el arranque sin necesidad.
- No ejecutes trabajo por cada `CursorMoved` o `TextChangedI` sin debounce y medición.
- No dependas del directorio de trabajo actual si representa otra cosa que el proyecto.
- No uses `os.execute`, `io.popen` ni comandos shell construidos con entrada del usuario.
- No sobrescribas opciones globales sin una opción documentada.
- No mantengas referencias a buffers, ventanas o jobs sin verificar su validez.
- No descargues ni ejecutes código automáticamente sin consentimiento.
- No guardes tokens en variables globales, logs o mensajes.
- Valida rutas y pide confirmación antes de acciones irreversibles.

Para medir arranque usa `:StartupTime`, `:profile start`, `:profile func *` y `:profile file *`. Optimiza a partir de mediciones.

## Checklist de publicación

1. Prueba en una configuración limpia y en la versión mínima soportada.
2. Comprueba que el repositorio se instala sin archivos generados innecesarios.
3. Añade licencia, README y ayuda nativa.
4. Genera tags y prueba `:help mi-plugin`.
5. Documenta comandos, opciones, eventos, dependencias y limitaciones.
6. Añade un changelog para cambios incompatibles.
7. Declara las dependencias opcionales explícitamente.
8. Ejecuta un lint de Lua y un formateador consistente.

## Receta rápida

1. Define una sola responsabilidad y un caso verificable.
2. Crea `lua/mi_plugin/init.lua` y devuelve `M`.
3. Implementa `setup(opts)` con defaults copiados.
4. Añade una función pública o comando mínimo.
5. Usa `plugin/` solo para registros protegidos contra doble carga.
6. Usa `vim.ui`, buffers, `vim.system` y `vim.fs` antes de añadir dependencias.
7. Escribe `doc/mi_plugin.txt`.
8. Prueba con `nvim --clean` y headless.
9. Mide rendimiento, documenta la configuración y publica una versión pequeña.

La frontera importante es: el módulo contiene comportamiento reutilizable, `plugin/` conecta ese comportamiento con Neovim y el usuario conserva el control sobre configuración, mappings y recursos globales.
