# Características

Esta configuración de Neovim incluye un conjunto completo de características diseñadas para proporcionar un entorno de desarrollo moderno y productivo.

## 🎯 Características Principales

### 1. Soporte de Lenguajes y LSP

#### Go Development
- **gopls**: Language Server Protocol oficial de Go (instalado en sistema)
- **DAP**: Soporte completo de debugging con puntos de interrupción
- **Neotest**: Framework de testing integrado
- **Runner**: Ejecución rápida de proyectos Go

#### TypeScript/JavaScript Development
- **vtsls**: Language Server moderno para TS/JS (vía Mason)
- **Prettier**: Formateo automático de código
- **DAP**: Debugging con Node.js/Chrome DevTools
- **npm/bun**: Detección automática de gestores de paquetes

#### C# Development
- **OmniSharp**: Language Server completo para .NET (vía Mason)
- **.NET SDK**: Integración con herramientas de Microsoft
- **DAP**: Debugging con .NET debugger
- **dotnet run**: Ejecución integrada de proyectos

#### Lua Development
- **lua-language-server**: LSP oficial para Lua
- **lazydev.nvim**: Mejoras para desarrollo de configuraciones Neovim
- **Stylua**: Formateo automático de código Lua
- **Luasnip**: Motor de snippets potente

#### Web Technologies
- **HTML/CSS**: Language Servers con autocompletado
- **Markdown**: Soporte completo con LSP y renderizado
- **Emmet**: Expansión abreviada para HTML/CSS

### 2. Navegación y Movimiento

#### Harpoon 2.0
- Marcadores rápidos de archivos (`<leader>a`)
- Navegación con Ctrl-1/2/3/4
- Menú rápido de bookmarks (`<leader>h`)
- Integración con Telescope

#### Telescope
- Búsqueda difusa de archivos (`<leader>f`)
- Búsqueda de texto en archivos (`<leader>gp`)
- Gestión de buffers (`<leader>b`)
- Historial de archivos recientes (`<leader>r`)
- Búsqueda de símbolos (`<leader>s`)

#### Flash
- Navegación ultra-rápida con highlighting
- Jump motion mejorado
- Soporte para múltiples etiquetas

#### Neo-tree
- Explorador de archivos con git integration
- Vista de árbol con iconos
- Búsqueda integrada
- Toggle con `<leader>e`

### 3. Edición y Productividad

#### nvim-cmp
- Autocompletado inteligente con múltiples fuentes
- Integración con LSP, snippets, buffer, path
- Iconos de tipo para cada fuente
- Personalización de comportamiento

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

#### Trouble
- Visualización mejorada de diagnostics
- Integración con LSP
- Filtrado por tipo/severidad
- Quick fix de problemas

#### Aerial
- Outline de símbolos de código
- Navegación estructural
- Integración con LSP
- Vista jerárquica

#### Overseer
- Task runner universal
- Gestión de tareas en background
- Integración con build tools
- UI de progreso y resultados

### 8. Características Únicas

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

## 📊 Matriz de Características

| Característica | Categoría | Soporte de Lenguajes | Estado |
|----------------|------------|----------------------|---------|
| LSP | Soporte de Lenguajes | Go, TS/JS, C#, Lua, HTML/CSS | ✅ Activo |
| DAP | Herramientas de Desarrollo | Go, TS/JS, C# | ✅ Activo |
| Harpoon | Navegación | Todos | ✅ Activo |
| Telescope | Navegación | Todos | ✅ Activo |
| Neo-tree | Gestión de Archivos | Todos | ✅ Activo |
| nvim-cmp | Edición | Todos | ✅ Activo |
| Session Manager | Gestión de Proyectos | Todos | ✅ Activo |
| LazyGit | Herramientas de Desarrollo | Todos | ✅ Activo |

## 🌐 Idiomas

- 🇪🇸 **Español**: Esta documentación
- 🇺🇸 **English**: [English Features Documentation](../en/features.md)

---

*Esta configuración está diseñada para ser modular y extensible, permitiéndote personalizarla según tus necesidades específicas.*