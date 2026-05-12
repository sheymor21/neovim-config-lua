# Características

Esta configuración de Neovim incluye un conjunto completo de características diseñadas para proporcionar un entorno de desarrollo moderno y productivo.

## 🎯 Características Principales

### 1. Soporte de Lenguajes y LSP

#### Desarrollo Go
- **gopls**: Language Server Protocol oficial de Go (instalado en sistema)
- **DAP**: Soporte completo de debugging con puntos de interrupción
- **Neotest**: Framework de testing integrado
- **Runner**: Ejecución rápida de proyectos Go

#### Desarrollo TypeScript/JavaScript
- **vtsls**: Language Server moderno para TS/JS (vía Mason)
- **Prettier**: Formateo automático de código
- **DAP**: Debugging con Node.js/Chrome DevTools
- **npm/bun**: Detección automática de gestores de paquetes

#### Desarrollo C#
- **Roslyn**: Language Server oficial de Microsoft para C# (vía roslyn.nvim)
- **CSharpier**: Formateo de código
- **Neotest**: Testing con adaptador neotest-dotnet
- **DAP**: Debugging con netcoredbg
- **dotnet run**: Ejecución integrada de proyectos

#### Desarrollo Lua
- **lua-language-server**: LSP oficial para Lua
- **lazydev.nvim**: Mejoras para desarrollo de configuraciones Neovim
- **Stylua**: Formateo automático de código Lua (4 espacios, 100 columnas)
- **Luasnip**: Motor de snippets potente

#### Desarrollo Python
- **black**: Formateo de código (líneas de 100 caracteres)

#### Tecnologías Web
- **HTML/CSS**: Language Servers con autocompletado
- **Markdown**: Soporte completo con LSP y renderizado
- **Emmet**: Expansión abreviada para HTML/CSS
- **Shell/Bash**: Formateo shfmt con indentación de 4 espacios

### 2. Navegación y Movimiento

#### Fzf-lua
- Búsqueda difusa de archivos (`<leader>ff`)
- Gestión de buffers (`<leader>fb`)
- Búsqueda de texto en vivo (`<leader>sg`)
- Búsqueda de símbolos LSP (`<leader>ss`)
- Rendimiento nativo rápido con vistas previas

#### Grapple
- Marcadores rápidos de archivos (`<leader>aa`)
- Navegación con Ctrl-1/2/3/4
- Menú rápido de bookmarks (`<leader>ah`)
- Integración con Fzf-lua

#### Telescope (Legacy)
- Descubrimiento de proyectos vía neovim-project (`<leader>fP`, `<leader>fp`)
- Historial de yank y extensiones

#### Flash
- Navegación ultra-rápida con highlighting
- Jump motion mejorado
- Soporte para múltiples etiquetas



### 3. Edición y Productividad

#### blink.cmp
- Autocompletado inteligente con múltiples fuentes
- Integración con LSP, snippets, buffer, path, lazydev
- Iconos de tipo para cada fuente
- Búsqueda fuzzy potenciada por Rust
- Autocompletado en línea de comandos
- Ayuda de firmas (parameter hints)

#### LuaSnip
- Motor de snippets potente
- Snippets específicos por lenguaje
- Expansión con Tab/Enter
- Navegación entre placeholders

#### nvim-surround
- Manipulación de delimitadores (quotes, brackets, tags)
- Añadir/eliminar/cambiar surrounding text
- Operaciones visuales y normales

#### nvim-autopairs
- Cierre automático de brackets, quotes, etc.
- Configuración específica por filetype
- Compatibilidad con snippets

#### Yanky
- Historial de yank/paste
- Navegación en el historial
- Ciclado de texto pegado
- Integración con system clipboard

#### Conform
- Formateo async y sync (`<leader>mf`, `<leader>mF`)
- Soporte de fallback LSP
- Formateo de selección visual
- Soporte multi-lenguaje

### 4. UI y Apariencia

#### Kanagawa Theme
- Tema principal predeterminado
- Variantes wave, dragon, lotus
- Soporte para árboles sintácticos
- Paleta de colores cohesiva

#### Temas Adicionales
- Catppuccin (mocha, latte, frappe, macchiato)
- Gruvbox (dark, light, hard, soft)
- Onedark
- Cyberdream

#### Lualine
- Status line personalizada
- Indicadores de modo, git, LSP, diagnostics
- Temas personalizables
- Componentes modulares

#### Noice.nvim
- Reemplazo moderno para notificaciones
- UI mejorada para command line
- Messages inteligentes
- Integración con notify.nvim

#### Indent Guides
- Guías visuales de indentación
- Rainbow highlighting
- Configuración específica por lenguaje

### 5. Herramientas de Desarrollo

#### Debug Adapter Protocol (DAP)
- Soporte de debugging multi-lenguaje
- Breakpoints condicionales
- REPL integrado
- UI de debugging mejorada

#### Neotest
- Framework de testing unificado
- Ejecución de tests individuales o de archivo
- Integración con DAP
- Resultados en ventana flotante

#### LazyGit
- Interfaz Git mejorada
- Integración con Neovim
- Toggle con teclas rápidas
- Operaciones Git comunes

#### LazyDocker
- Interfaz Docker mejorada
- Gestión de contenedores
- Integración con Docker CLI
- Vista de logs y recursos

#### ToggleTerm
- Gestión de terminales flotantes
- Múltiples terminales
- Atajos rápidos
- Integración con runners

### 6. Gestión de Sesiones y Proyectos

#### Neovim Session Manager
- Persistencia de sesiones
- Auto-guardado de sesiones
- Recuperación rápida de workspace
- Gestión de buffers y layouts

#### Neovim Project
- Descubrimiento automático de proyectos
- Historial de proyectos recientes
- Telescope integration
- Gestión de workspace por proyecto

#### Undotree
- Visualización de historial de cambios
- Navegación en timeline de undo
- Comparación de versiones
- Restauración de cambios específicos

### 7. Utilidades Avanzadas

#### Which-key
- Ayuda interactiva de keybindings
- Sugerencias de comandos
- Agrupación lógica de teclas
- Personalización de menús

#### Unidiagnostic / Trouble
- Visualización mejorada de diagnostics
- Integración con LSP
- Filtrado por tipo/severidad
- Quick fix de problemas

#### Aerial
- Outline de símbolos de código
- Navegación estructural
- Integración con LSP
- Vista jerárquica

#### Snacks.nvim
- **Dashboard**: Pantalla de bienvenida con acciones rápidas (reemplaza alpha-nvim)
- **Picker**: Selector de archivos/diagnósticos/recientes con vista previa (reemplaza telescope-ui-select)
- **Notifier**: Sistema moderno de notificaciones (reemplaza nvim-notify)
- **Indent**: Guías de indentación (reemplaza indent-blankline)
- **LazyGit**: UI integrada de lazygit
- **Terminal**: Gestión de terminal flotante
- **Words**: Navegación de referencias LSP
- **Input**: Diálogos de entrada mejorados (reemplaza vim.ui.input)



#### Oil.nvim
- **Edición de archivos en buffer**: Editar filesystem como un buffer
- **Navegación rápida**: Abrir directorio padre con `-`
- **Operaciones en lote**: Renombrar, mover, eliminar archivos en masa
- **Integración Git**: Muestra estado git en el árbol de archivos
- **Ventanas flotantes**: Gestor de archivos flotante configurable

### 8. Herramientas Adicionales

#### Multicursor.nvim
- **Múltiples cursores**: Editar múltiples ubicaciones simultáneamente
- **Selección en modo visual**: Agregar cursores a regiones seleccionadas
- **Navegación de matches**: Saltar entre coincidencias con Ctrl-n/p
- **Match all**: Seleccionar todas las ocurrencias con `<leader>ma`

#### Faster.nvim
- **Optimización de rendimiento**: Desactiva funciones pesadas en archivos grandes
- **Detección automática**: Se activa cuando archivos exceden umbral de tamaño
- **Recuperación inteligente**: Reactiva funciones al salir de archivos grandes
- **Protección Treesitter**: Previene crashes con archivos grandes

#### Window Picker
- **Selección rápida de ventanas**: Saltar a cualquier ventana visible
- **Hints con letras**: Cada ventana etiquetada con tecla de acceso rápido
- **Integración con Telescope**: Buscar y seleccionar ventanas

#### Plugin 99 (Asistente de IA)
- **Edición con IA**: Sugerencias de código contextual
- **Selección visual**: Operaciones IA en texto seleccionado (`<leader>9v`)
- **Integración de búsqueda**: Búsqueda potenciada con IA (`<leader>9s`)
- **Modo vibe**: Asistente de IA interactivo (`<leader>9a`)
- **Gestión de requests**: Detener y limpiar requests de IA

### 9. Características Únicas

#### Colemak-DH Layout
- Optimización ergonómica de navegación
- Remapeo de h,j,k,l → n,e,i,o
- Mejora de velocidad y comodidad
- Guía de reversión incluida

#### Smart Functions
- Inserción inteligente de puntuación
- Formateo con un comando
- Búsqueda de notas pendientes
- Limpieza automática de buffers

#### Performance Optimizations
- Lazy loading agresivo
- Event-driven configuration
- Buffer management inteligente
- Tree-sitter auto-reattachment

## 🆚 Compatibilidad con VS Code Neovim

Esta configuración incluye una **capa de compatibilidad con VS Code** (`lua/nvim_vscode/` + `lua/keymaps/nvim_vscode.lua`) que detecta automáticamente cuando se ejecuta dentro de la [extensión VS Code Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim) y desactiva plugins conflictivos mientras remapea teclas a comandos nativos de VS Code.

### Cómo Funciona
- **Detección**: Usa el flag `vim.g.vscode` establecido por la extensión VS Code Neovim
- **Filtrado de Plugins**: 35 plugins desactivados en modo VS Code para evitar conflictos de UI
- **Remapeo de Teclas**: `<leader>w`, `<leader>q`, `<leader>sg`, etc. se mapean a comandos de VS Code vía `VSCodeNotify()`
- **Undo Silencioso**: `u` y `U` se silencian para evitar el spam de "Already at oldest change" en el panel OUTPUT de VS Code

### Plugins Activos en VS Code
| Plugin | Propósito |
|--------|-----------|
| nvim-treesitter | Resaltado de sintaxis |
| nvim-autopairs | Cierre automático de brackets |
| nvim-surround | Objetos de texto surrounding |
| flash.nvim | Navegación rápida |
| spider.nvim | Movimiento CamelCase |
| which-key.nvim | Ayuda de keybindings |
| yanky.nvim | Historial de yank/paste |
| reloader.nvim | Recarga de configuración |
| colors | Esquemas de color |

### Plugins Desactivados en VS Code
- **UI**: lualine, noice, snacks.nvim dashboard/picker/notifier
- **LSP/CMP**: mason.nvim, blink-cmp, todos los servidores LSP (VS Code los proporciona)
- **Pickers**: fzf-lua, telescope (usa la búsqueda nativa de VS Code)
- **Git**: gitsigns, lazygit (usa el control de fuente de VS Code)
- **Terminal**: toggleterm (usa el terminal integrado de VS Code)
- **Notas**: telekasten (usa el explorador de archivos de VS Code)
- **Debug**: nvim-dap, neotest (usa los paneles de debug/test de VS Code)

### Configuración Requerida en VS Code
- `vscode-neovim.neovimExecutablePaths.linux`: `nvim`
- `vscode-neovim.logLevel`: `"error"`
- `keybindings.json`: Mapeos de navegación Colemak (`e`/`i` para arriba/abajo en listas, `Alt+Q` para cerrar paneles)

Consulta la [Guía de Instalación](instalacion.md#extensión-vs-code-neovim) para más detalles.

## 📊 Matriz de Características

| Característica | Categoría | Soporte de Lenguajes | Estado |
|----------------|------------|----------------------|---------|
| LSP | Soporte de Lenguajes | Go, TS/JS, C#, Lua, Python, HTML/CSS | ✅ Activo |
| DAP | Herramientas de Desarrollo | Go, TS/JS, C# | ✅ Activo |
| blink.cmp | Edición | Todos | ✅ Activo |
| fzf-lua | Navegación | Todos | ✅ Activo |
| Grapple | Navegación | Todos | ✅ Activo |
| Telescope | Navegación | Todos | ⚠️ Legacy |
| Oil | Gestión de Archivos | Todos | ✅ Activo |
| Snacks.nvim | UI/Dashboard | Todos | ✅ Activo |
| Telekasten | Toma de Notas | Markdown | ✅ Activo |
| Multicursor | Edición | Todos | ✅ Activo |
| Session Manager | Gestión de Proyectos | Todos | ✅ Activo |
| LazyGit | Herramientas de Desarrollo | Todos | ✅ Activo |
| Conform | Formateo | Todos | ✅ Activo |
| Faster | Rendimiento | Todos | ✅ Activo |

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Features Documentation](../en/features.md)

---

*Esta configuración está diseñada para ser modular y extensible, permitiéndote personalizarla según tus necesidades específicas.*
