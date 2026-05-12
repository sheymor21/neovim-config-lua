# Features

This Neovim configuration includes a complete set of features designed to provide a modern and productive development environment.

## 🎯 Key Features

### 1. Language Support and LSP

#### Go Development
- **gopls**: Official Go Language Server Protocol (system installed)
- **DAP**: Complete debugging support with breakpoints
- **Neotest**: Integrated testing framework
- **Runner**: Fast Go project execution

#### TypeScript/JavaScript Development
- **vtsls**: Modern TS/JS Language Server (via Mason)
- **Prettier**: Automatic code formatting
- **DAP**: Debugging with Node.js/Chrome DevTools
- **npm/bun**: Automatic package manager detection

#### C# Development
- **Roslyn**: Official Microsoft C# Language Server (via roslyn.nvim)
- **CSharpier**: Code formatting
- **Neotest**: Testing with neotest-dotnet adapter
- **DAP**: Debugging with netcoredbg
- **dotnet run**: Integrated project execution

#### Lua Development
- **lua-language-server**: Official Lua LSP
- **lazydev.nvim**: Enhancements for Neovim config development
- **Stylua**: Automatic Lua code formatting (4 spaces, 100 column)
- **Luasnip**: Powerful snippet engine

#### Python Development
- **black**: Code formatting (100 character line length)

#### Web Technologies
- **HTML/CSS**: Language Servers with autocompletion
- **Markdown**: Complete support with LSP and rendering
- **Emmet**: Abbreviation expansion for HTML/CSS
- **Shell/Bash**: shfmt formatting with 4-space indentation

### 2. Navigation and Movement

#### Fzf-lua
- Fuzzy file finding (`<leader>ff`)
- Buffer management (`<leader>fb`)
- Live grep text search (`<leader>sg`)
- LSP symbol search (`<leader>ss`)
- Fast native fzf performance with previews

#### Grapple
- Quick file bookmarks (`<leader>aa`)
- Ctrl-1/2/3/4 navigation
- Quick bookmarks menu (`<leader>ah`)
- Fzf-lua integration

#### Telescope (Legacy)
- Project discovery via neovim-project (`<leader>fP`, `<leader>fp`)
- Yank history and extensions

#### Flash
- Ultra-fast navigation with highlighting
- Enhanced jump motion
- Multiple tag support



### 3. Editing and Productivity

#### blink.cmp
- Intelligent autocompletion with multiple sources
- Integration with LSP, snippets, buffer, path, lazydev
- Type icons for each source
- Rust-powered fuzzy matching
- Command-line completion
- Signature help (parameter hints)

#### LuaSnip
- Powerful snippet engine
- Language-specific snippets
- Tab/Enter expansion
- Placeholder navigation

#### nvim-surround
- Delimiter manipulation (quotes, brackets, tags)
- Add/delete/change surrounding text
- Visual and normal mode operations

#### nvim-autopairs
- Automatic bracket, quote closing
- Filetype-specific configuration
- Snippet compatibility

#### Yanky
- Yank/paste history
- History navigation
- Paste text cycling
- System clipboard integration

#### Conform
- Async and sync formatting (`<leader>mf`, `<leader>mF`)
- LSP fallback support
- Visual selection formatting
- Multi-language support

### 4. UI and Appearance

#### Kanagawa Theme
- Default main theme
- Wave, dragon, lotus variants
- Treesitter support
- Cohesive color palette

#### Additional Themes
- Catppuccin (mocha, latte, frappe, macchiato)
- Gruvbox (dark, light, hard, soft)
- Onedark
- Cyberdream

#### Lualine
- Custom status line
- Mode, git, LSP, diagnostics indicators
- Customizable themes
- Modular components

#### Noice.nvim
- Modern notification replacement
- Enhanced command line UI
- Smart messages
- Notify.nvim integration

#### Indent Guides
- Visual indentation guides
- Rainbow highlighting
- Language-specific configuration

### 5. Development Tools

#### Debug Adapter Protocol (DAP)
- Multi-language debugging support
- Conditional breakpoints
- Integrated REPL
- Enhanced debugging UI

#### Neotest
- Unified testing framework
- Individual or file test execution
- DAP integration
- Floating window results

#### LazyGit
- Enhanced Git interface
- Neovim integration
- Quick key toggles
- Common Git operations

#### LazyDocker
- Enhanced Docker interface
- Container management
- Docker CLI integration
- Logs and resources view

#### ToggleTerm
- Floating terminal management
- Multiple terminals
- Quick shortcuts
- Runner integration

### 6. Session and Project Management

#### Neovim Session Manager
- Session persistence
- Auto-save sessions
- Quick workspace recovery
- Buffer and layout management

#### Neovim Project
- Automatic project discovery
- Recent project history
- Telescope integration
- Per-project workspace management

#### Undotree
- Change history visualization
- Undo timeline navigation
- Version comparison
- Specific change restoration

### 7. Advanced Utilities

#### Which-key
- Interactive keybinding help
- Command suggestions
- Logical key grouping
- Menu customization

#### Unidiagnostic / Trouble
- Enhanced diagnostics visualization
- LSP integration
- Type/severity filtering
- Quick problem fixing

#### Aerial
- Code symbol outline
- Structural navigation
- LSP integration
- Hierarchical view

#### Snacks.nvim
- **Dashboard**: Welcome screen with quick actions (replaces alpha-nvim)
- **Picker**: File/diagnostic/recent picker with preview (replaces telescope-ui-select)
- **Notifier**: Modern notification system (replaces nvim-notify)
- **Indent**: Indentation guides (replaces indent-blankline)
- **LazyGit**: Integrated lazygit UI
- **Terminal**: Floating terminal management
- **Words**: LSP references navigation
- **Input**: Enhanced input dialogs (replaces vim.ui.input)



#### Oil.nvim
- **Buffer-based file editing**: Edit filesystem like a buffer
- **Quick navigation**: Open parent directory with `-`
- **Batch operations**: Rename, move, delete files in bulk
- **Git integration**: Shows git status in file tree
- **Floating windows**: Configurable floating file manager

### 8. Additional Tools

#### Multicursor.nvim
- **Multiple cursors**: Edit multiple locations simultaneously
- **Visual mode selection**: Add cursors to selected regions
- **Match navigation**: Jump between matches with Ctrl-n/p
- **Match all**: Select all occurrences with `<leader>ma`

#### Faster.nvim
- **Performance optimization**: Disables heavy features for large files
- **Automatic detection**: Enables when files exceed size threshold
- **Smart recovery**: Re-enables features when leaving large files
- **Treesitter protection**: Prevents crashes with large files

#### Window Picker
- **Quick window selection**: Jump to any visible window
- **Letter hints**: Each window labeled with quick-access key
- **Telescope integration**: Search and pick windows

#### 99 Plugin (AI Assistant)
- **AI-powered editing**: Context-aware code suggestions
- **Visual selection**: AI operations on selected text (`<leader>9v`)
- **Search integration**: AI-powered search (`<leader>9s`)
- **Vibe mode**: Interactive AI assistant (`<leader>9a`)
- **Request management**: Stop and clear AI requests

### 9. Unique Features

#### Colemak-DH Layout
- Ergonomic navigation optimization
- h,j,k,l → n,e,i,o remapping
- Speed and comfort improvement
- Reversion guide included

#### Smart Functions
- Smart punctuation insertion
- One-command formatting
- Pending notes search
- Automatic buffer cleanup

#### Performance Optimizations
- Aggressive lazy loading
- Event-driven configuration
- Intelligent buffer management
- Tree-sitter auto-reattachment

## 📊 Feature Matrix

| Feature | Category | Language Support | Status |
|---------|----------|------------------|---------|
| LSP | Language Support | Go, TS/JS, C#, Lua, Python, HTML/CSS | ✅ Active |
| DAP | Development Tools | Go, TS/JS, C# | ✅ Active |
| blink.cmp | Editing | All | ✅ Active |
| fzf-lua | Navigation | All | ✅ Active |
| Grapple | Navigation | All | ✅ Active |
| Telescope | Navigation | All | ⚠️ Legacy |
| Oil | File Management | All | ✅ Active |
| Snacks.nvim | UI/Dashboard | All | ✅ Active |
| Telekasten | Note-taking | Markdown | ✅ Active |
| Multicursor | Editing | All | ✅ Active |
| Session Manager | Project Management | All | ✅ Active |
| LazyGit | Development Tools | All | ✅ Active |
| Conform | Formatting | All | ✅ Active |
| Faster | Performance | All | ✅ Active |

## 🌐 Languages

- 🇺🇸 **English**: This documentation
- 🇪🇸 **Español**: [Documentación de Características en Español](../es/caracteristicas.md)

---

*This configuration is designed to be modular and extensible, allowing you to customize it according to your specific needs.*
