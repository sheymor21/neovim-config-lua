# Crear plugins nativos para Neovim 0.12+

Esta documentación está dividida por tema para que puedas consultar solo la parte que necesitas. Explica cómo diseñar, conectar, probar y distribuir un plugin escrito en Lua usando las APIs nativas de Neovim, sin depender de `nvim-lspconfig`, `plenary.nvim` ni otro plugin externo.

## Guías

1. [Fundamentos y estructura](01-fundamentos.md)
   - Qué es un plugin y cómo se descubre mediante `runtimepath`.
   - Estructura de `lua/`, `plugin/`, `doc/`, `ftplugin/`, `queries/` y otros directorios.
   - Plugin mínimo con `setup()` y un comando.
2. [Ciclo de vida y APIs](02-ciclo-de-vida-y-apis.md)
   - Tutorial completo para crear y probar el primer plugin.
   - Comandos, mappings, autocomandos, buffers, ventanas y tabs.
   - Filesystem, procesos, asincronía, namespaces, extmarks, LSP y Tree-sitter.
3. [Interfaces nativas](03-interfaces-nativas.md)
   - Cómo crear ventanas flotantes, paneles, formularios, menús y vistas interactivas.
   - Cuándo usar `vim.ui.input`, `vim.ui.select`, buffers temporales o `vim.notify`.
   - Ejemplo completo de una interfaz nativa reutilizable.
4. [Documentación y compatibilidad](04-documentacion-y-compatibilidad.md)
   - Ayuda integrada con `:help`, tags, configuración y versiones soportadas.
   - Completado y tipos de Lua mediante `lazydev.nvim` o `.luarc.json`.
5. [Pruebas y publicación](05-pruebas-y-publicacion.md)
   - Pruebas aisladas y headless.
   - Diagnóstico, integración con gestores, rendimiento, seguridad y checklist de publicación.

## Referencia oficial

- [`:help lua-guide`](https://neovim.io/doc/user/lua-guide.html)
- [`:help api`](https://neovim.io/doc/user/api.html)
- [`:help lua`](https://neovim.io/doc/user/lua.html)
- [`:help runtime`](https://neovim.io/doc/user/runtime.html)
- [`:help dev`](https://neovim.io/doc/user/develop.html)

## Ruta recomendada

Lee `01-fundamentos.md` y `02-ciclo-de-vida-y-apis` para construir el plugin. Consulta `03-interfaces-nativas` si necesitas una UI dentro de Neovim. Termina con `04-documentacion-y-compatibilidad` y `05-pruebas-y-publicacion` antes de distribuirlo.
