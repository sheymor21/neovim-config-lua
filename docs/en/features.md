# Features

This Neovim configuration includes a complete set of features designed to provide a modern and productive development environment.

## 🎯 Key Features

### 1. Language Support and LSP

#### Go Development
- **gopls**: Official Go Language Server Protocol (system installed)
- **DAP**: Complete debugging support (delve, auto-detected configurations)
- **Neotest**: Integrated testing harness
- **Unirunner**: Fast project execution with CWD and root-marker detection

#### TypeScript/JavaScript Development
- **vtsls**: Modern TS/JS Language Server (via Mason)
- **Prettier**: Automatic code formatting
- **DAP**: Debugging with js-debug-adapter, auto-detects `npm`/`pnpm`/`yarn`/`bun`
- **Unirunner**: Auto-picks the package manager for `tsx`

#### C# Development
- **Roslyn**: Official Microsoft C# Language Server (via `seblyng/roslyn.nvim`)
- **CSharpier**: Code formatting
- **Neotest**: Testing is delegated to the .NET CLI; DAP comes via netcoredbg (auto-install via Mason)
- **DAP**: netcoredbg adapter, ASP.NET launchSettings URL injection, NUnit support
- **dotnet run**: Integrated project execution through unirunner

#### Lua Development
- **lua-language-server**: Official Lua LSP
- **lazydev.nvim**: Enhancements for Neovim config development
- **Stylua**: Automatic Lua code formatting (4 spaces, 100 column)
- **LuaSnip**: Powerful snippet engine

#### Python Development
- **black**: Code formatting (100 character line length)

#### Web Technologies
- **HTML/CSS**: Language Servers with autocompletion
- **Markdown**: Complete support with LSP (marksman) and rendering (`markdown-render`)
- **Emmet**: Abbreviation expansion via `nvim-autopairs`
- **Shell/Bash**: shfmt formatting with 4-space indentation

#### SQL Development
- **vim-dadbod** for connection management
- **vim-dadbod-ui** for schema browsing and queries
- **vim-dadbod-completion** integrated as a blink.cmp source for `sql`/`mysql`/`plsql` buffers
- Interactive URL builder for `mysql`/`postgres`/`sqlserver` connections (`<leader>du`)

### 2. Navigation and Movement

#### Fzf-lua
- Fuzzy file finding (`<leader>ff`)
- Buffer management (`<leader>fb`)
- Live grep text search (`<leader>sgg`, `<leader>sgf`)
- LSP symbol search (`<leader>ss`)
- Fast native fzf performance with previews

#### Snacks Picker
- Recent files (`<leader>fr`)
- Marks / Help / Keymaps / Commands / Undo / Quickfix / Loclist / Resume picker
- Markdown notes: `find_notes`, `grep_notes`, `show_backlinks`, `show_tags`

#### Grapple
- Quick file bookmarks (`<leader>aa`)
- Ctrl-1/2/3/4 direct navigation
- Quick bookmarks menu (`<leader>ah`) and search (`<leader>as`)
- Fzf-lua integration

#### Flash
- Ultra-fast navigation with highlighting (`f` / `F` for normal / treesitter nodes)
- Multiple tag support

#### Snap / Motion
- **Spider** (`w`/`e`/`b` semantic motion)
- **Window picker** (`<leader>iwp`)
- **Multicursor** (`<C-n>` / `<C-p>` / `<leader>ma`)

### 3. Editing and Productivity

#### blink.cmp
- Intelligent autocompletion with multiple sources
- Default sources: `lsp`, `lazydev`, `snippets`, `buffer`, `path`. SQL buffers swap in `dadbod`
- Type icons for each source
- Rust-powered fuzzy matching
- Command-line completion
- Signature help (parameter hints)
- Snippet-only hotkey: `<C-s>`

#### LuaSnip
- Powerful snippet engine
- Cooperative with Tab / S-Tab jump
- VSCode snippet loader is lazy-loaded on VeryLazy

#### nvim-autopairs
- Automatic bracket, quote, etc. closure
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

#### UFO
- Fast C-based folding provider
- Used everywhere; `z*` Colemak-style folding aliases in `keymaps/core.lua`

### 4. UI and Appearance

#### Adaptive Filetype Themes
- **Ayu** is loaded eagerly at startup by `lua/plugins/colors.lua`
- Auto-switches per filetype (see `lua/config/filetype-theme.lua`):
  - `lua` → ayu, `go` → onedark_dark, `cs` → gruvbox, `html` → tokyodark, `css` → gruvbox, `javascript`/`typescript` → onedark_dark
- Kanagawa as fallback for unspecified filetypes

#### Available Themes
- Ayu (default)
- Kanagawa
- Gruvbox (with custom C# and multicursor highlights)
- Onedark / Onedark Dark
- Tokyodark

#### Lualine
- Custom status line
- Mode, git, LSP, diagnostics indicators
- Synchronized with the active colorscheme (no extra config needed)

#### Snacks.notifier
- Replaces `vim.notify` via `config/snacks.lua`. All notifications go through Snacks.

#### Indent / Rainbow
- Snacks `indent` for indent guides (deferred to VeryLazy)
- Snacks `words` for LSP reference nav (deferred to VeryLazy)
- `rainbow-delimiters` for colored nested brackets

### 5. Development Tools

#### Debug Adapter Protocol (DAP)
- Multi-language debugging support
- Conditional breakpoints
- Integrated REPL
- Enhanced debugging UI (`dap-ui`)
- Auto-install of `netcoredbg`, `js-debug-adapter`, `delve` via Mason

#### Neotest
- Unified testing framework
- Individual or file test execution
- DAP integration
- Floating window results

#### LazyGit
- Enhanced Git interface via Snacks
- The Snacks lazygit wrapper respects `~/.config/lazygit/config.yml` (Colemak-DH keybindings live there)
- Used by `<leader>ig`

#### LazyDocker
- Toggleterm-based wrapper (`config/lazy-docker.lua`) and a Snacks-based launcher (`<leader>id`)

#### DiffView
- Side-by-side and file-history diffs
- Wired through `plugins-keymaps/diffview-keymaps.lua`: `<leader>gd` (working changes), `<leader>gD` (files only), `<leader>gh` / `<leader>gH` (file / branch history), `<leader>gt` (toggle files panel)
- LSP `gd` / `gD` still take precedence because they are buffer-local

#### Snacks.terminal
- Floating terminal management
- Quick shortcuts via `<leader>tt`
- Runner integration

#### ToggleTerm (legacy)
- Kept for `unirunner` / `lazygit` / `lazy-docker` wrappers
- Most terminal usage has moved to `Snacks.terminal`

#### OpenCode Integration
- Open external terminal with OpenCode in project root
- Auto-detects project root via git
- Supports multiple terminals: alacritty, kitty, wezterm, gnome-terminal, konsole, xterm
- Configurable via `vim.g.external_terminal`
- Quick access via `<leader>to`

### 6. Session and Project Management

#### Neovim Session Manager (`Shatur/neovim-session-manager`)
- Session persistence and auto-save
- Quick workspace recovery
- Buffer and layout management

#### Neovim Project
- Automatic project discovery (`<leader>fP`)
- Recent project history (`<leader>fp`)
- Snacks.nvim picker integration

#### Dashboard (Snacks)
- Welcome screen with quick actions (dashboard keys `f`, `p`, `v`, `n`, `N`, `l`, `u`, `g`, `m`, `q`)
- Git clone shortcut (`g`) via `M.dashboard_git_clone`
- Custom URL launcher (`u`) via the gitignored `lua/config/dashboard-urls.lua`

#### Undotree
- Change history visualization (`<leader>u`)
- Undo timeline navigation
- Version comparison
- Specific change restoration

### 7. Advanced Utilities

#### Which-key
- Interactive keybinding help
- Command suggestions
- Logical key grouping

#### Unidiagnostic / Trouble
- Enhanced diagnostics visualization (`<leader>isp` toggle, `<leader>isc` current file)
- LSP integration
- Type/severity filtering

#### nvim-navic
- LSP breadcrumbs in statusline (attached only when `documentSymbolProvider` is advertised)
- Symbol navigation path
- LSP integration
- Lightweight compared to aerial

#### Snacks.nvim
- **Dashboard**: Welcome screen with quick actions (replaces alpha-nvim)
- **Picker**: File/diagnostic/recent picker with preview (replaces telescope-ui-select)
- **Notifier**: Modern notification system (replaces nvim-notify)
- **Indent**: Indentation guides (replaces indent-blankline; defers to VeryLazy)
- **LazyGit**: Integrated lazygit UI
- **Terminal**: Floating terminal management
- **Words**: LSP references navigation (defers to VeryLazy)
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
- **Floating big-letter hints**: Visual window selection overlay

#### ZealSearch
- **Docset search**: Search offline docs via Zeal/Dash
- **Filetype-aware docset**: Auto-picks the right docset based on the current buffer (`ts`, `go`, `cs`, `lua`, …)
- **Repeat**: `<leader>iZ` repeats the last query

#### Dadbod / Dadbod-UI
- **Connection manager**: Add connections interactively with `:DBUIAddConnection`
- **Sidebar UI**: Browse schema and run queries from `<leader>db`
- **SQL completion**: Tables/columns come from vim-dadbod-completion through blink.cmp
- **URL builder**: `<leader>du` walks you through host/port/user/db/password and puts the RFC-3986-encoded URI on the clipboard

### 9. Storyboard (DiaProject) — Custom Kanban Backend

Sheymor maintains a custom Go kanban-style API at `https://github.com/sheymor21/DiaProject`. The `lua/config/storyboard.lua` module pulls it down to `vim.fn.stdpath("data")/storyboard`, builds the `server` binary on demand, and runs it on a free port.

Keymaps share the `<leader>ts<key>` prefix:

| Keymap | Action |
|--------|--------|
| `<leader>tsd` | Start server (clone + build + run if needed) |
| `<leader>tsD` | Stop server |
| `<leader>tso` | Open dashboard in the browser |
| `<leader>tsl` | View server log |
| `<leader>tsp` | List / inspect projects |
| `<leader>tsn` | Create project |
| `<leader>tsc` | List columns in a selected project |
| `<leader>tsk` | List cards (project → column → cards) |

Storyboard is reported in `:checkhealth` and requires `go` + `curl` on the host.

### 10. Unique Features

#### Colemak-DH Layout
- Ergonomic navigation optimization
- `h,j,k,l` → `n,e,i,o` remapping
- Speed and comfort improvement
- Reversion guide included

#### Smart Functions
- Smart punctuation insertion (`;`, `,`)
- One-command formatting (`<leader>mf` / `<leader>mF`)
- Pending notes search (`<leader>it`)
- Automatic buffer cleanup on DirChanged
- Cross-file LSP rename with auto-save (`<leader>rn`)
- Helper snippets: copiable random lists (SQL queries, …) via `<leader>hs`, edited with `<leader>hl`

#### Performance Optimizations
- Aggressive lazy loading
- Event-driven configuration (`User VeryLazy`)
- Intelligent buffer management
- Tree-sitter auto-reattachment

## 🆚 VS Code Neovim Compatibility

This configuration includes a **VS Code compatibility layer** (`lua/nvim_vscode/` + `lua/keymaps/nvim_vscode.lua`) that automatically detects when running inside the [VS Code Neovim extension](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim) and disables conflicting plugins while remapping keys to VS Code native commands.

### How It Works
- **Detection**: Uses `vim.g.vscode` flag set by the VS Code Neovim extension
- **Plugin Filtering**: `config/lazy.lua` reads `nvim_vscode.disabled_plugins` and skips everything in that list. Plugins not listed still try to load — disable them via `lua/plugins-off/`.
- **Key Remapping**: `<leader>w`, `<leader>q`, `<leader>sg`, etc. map to VS Code commands via `vim.fn.VSCodeNotify()`
- **Silent Undo**: `u` and `U` are silenced (`<cmd>silent undo<CR>` / `<cmd>silent redo<CR>`) to prevent "Already at oldest change" spam in VS Code's OUTPUT panel

### Plugins Active in VS Code
| Plugin | Purpose |
|--------|---------|
| nvim-treesitter | Syntax highlighting |
| nvim-autopairs | Auto bracket closing |
| flash.nvim | Quick navigation |
| spider.nvim | CamelCase motion |
| which-key.nvim | Keybinding help |
| yanky.nvim | Yank/paste history |
| reloader.nvim | Config reload |
| colors | Color schemes |

### Plugins Disabled by default in VS Code
- **UI**: lualine, noice, snacks.nvim dashboard/picker/notifier
- **LSP**: mason.nvim, blink-cmp, all LSP servers (VS Code provides these)
- **Pickers**: fzf-lua (use VS Code's native search)
- **Git**: gitsigns, lazygit (use VS Code's source control)
- **Terminal**: Snacks.terminal / toggleterm (use VS Code's integrated terminal)
- **Notes**: markdown files (use VS Code's file explorer)
- **Debug**: nvim-dap, neotest (use VS Code's debug/test panels)

(See `nvim_vscode.disabled_plugins` for the authoritative list.)

### VS Code Settings Required
- `vscode-neovim.neovimExecutablePaths.linux`: `nvim`
- `vscode-neovim.logLevel`: `"error"`
- `keybindings.json`: Colemak navigation mappings (`e`/`i` for up/down in lists, `Alt+Q` to close panels)

See [Installation Guide](installation.md#vs-code-neovim-extension) for setup details.

## 📊 Feature Matrix

| Feature | Category | Language Support | Status |
|---------|----------|------------------|--------|
| LSP | Language Support | Go, TS/JS, C#, Lua, Python, HTML/CSS, Markdown | ✅ Active |
| DAP | Development Tools | Go, TS/JS, C# | ✅ Active |
| blink.cmp | Editing | All (SQL gets `dadbod` source) | ✅ Active |
| fzf-lua | Navigation | All | ✅ Active |
| Grapple | Navigation | All | ✅ Active |
| Oil | File Management | All | ✅ Active |
| Snacks.nvim | UI/Dashboard | All | ✅ Active |
| Markdown Notes | Note-taking | Markdown | ✅ Active |
| Multicursor | Editing | All | ✅ Active |
| Session Manager | Project Management | All | ✅ Active |
| LazyGit | Development Tools | All | ✅ Active |
| Conform | Formatting | All | ✅ Active |
| Faster | Performance | All | ✅ Active |
| DiffView | Git/Diff | All | ✅ Active |
| Dadbod | Data/SQL | SQL (mysql/postgres/sqlserver) | ✅ Active |
| Storyboard | Custom backend | Go binary | ✅ Active |
| Helper snippets | Editing | All | ✅ Active |

## 🌐 Languages

- 🇺🇸 **English**: This documentation
- 🇪🇸 **Español**: [Documentación de Características en Español](../es/caracteristicas.md)

---

*This configuration is designed to be modular and extensible, allowing you to customize it according to your specific needs.*
