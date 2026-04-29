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
- **Roslyn**: Language Server oficial de Microsoft para C# (vía roslyn.nvim)
- **CSharpier**: Formateo de código
- **Neotest**: Testing con adaptador neotest-dotnet
- **DAP**: Debugging con netcoredbg
- **dotnet run**: Ejecución integrada de proyectos

#### Lua Development
- **lua-language-server**: LSP oficial para Lua
- **lazydev.nvim**: Mejoras para desarrollo de configuraciones Neovim
- **Stylua**: Formateo automático de código Lua (4 espacios, 100 columnas)
- **Luasnip**: Motor de snippets potente

#### Python Development
- **black**: Formateo de código (líneas de 100 caracteres)

#### Web Technologies
- **HTML/CSS**: Language Servers con autocompletado
- **Markdown**: Soporte completo con LSP y renderizado
- **Emmet**: Expansión abreviada para HTML/CSS
- **Shell/Bash**: Formateo shfmt con indentación de 4 espacios

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

#### Snacks.nvim
- **Dashboard**: Pantalla de bienvenida con acciones rápidas
- **Picker**: Selector de archivos/diagnósticos con vista previa
- **Notifier**: Sistema moderno de notificaciones
- **Bigfile**: Manejo optimizado de archivos grandes
- **Quickfile**: Operaciones rápidas de archivos
- **Input**: Diálogos de entrada mejorados

#### Obsidian.nvim
- **Toma de notas**: Integración con vault de Obsidian
- **Notas diarias**: Acceso rápido a notas diarias (`<leader>n` desde dashboard)
- **Nuevas notas**: Crear notas nuevas desde el dashboard
- **Plantillas**: Creación de notas con plantillas
- **Backlinks**: Enlace y navegación entre notas

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

## 📊 Matriz de Características

| Característica | Categoría | Soporte de Lenguajes | Estado |
|----------------|------------|----------------------|---------|
| LSP | Soporte de Lenguajes | Go, TS/JS, C#, Lua, Python, HTML/CSS | ✅ Activo |
| DAP | Herramientas de Desarrollo | Go, TS/JS, C# | ✅ Activo |
| Harpoon | Navegación | Todos | ✅ Activo |
| Telescope | Navegación | Todos | ✅ Activo |
| Neo-tree | Gestión de Archivos | Todos | ✅ Activo |
| Oil | Gestión de Archivos | Todos | ✅ Activo |
| nvim-cmp | Edición | Todos | ✅ Activo |
| Snacks.nvim | UI/Dashboard | Todos | ✅ Activo |
| Obsidian | Toma de Notas | Markdown | ✅ Activo |
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