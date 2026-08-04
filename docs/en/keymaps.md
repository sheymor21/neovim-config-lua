# Keybindings

This reference guide covers all main keybindings configured in this Neovim distribution, including the optimized Colemak-DH layout.

> Keymaps are split across `lua/keymaps/core.lua` (shared: Colemak movement, save/quit, smart punctuation, flash) and `lua/keymaps/nvim.lua` (plugin + utility keymaps). Each plugin additionally has its own `lua/plugins-keymaps/<name>-keymaps.lua`.

## 🎯 Colemak-DH Layout

This configuration uses the Colemak-DH layout for more ergonomic navigation (see `colemak-dh.md` for the reversion guide).

### Basic Navigation
| Original Key | Colemak-DH Key | Function |
|--------------|----------------|----------|
| h | n | Move left |
| j | e | Move down |
| k | i | Move up |
| l | o | Move right |

### Visual Mode Navigation
| Original Key | Colemak-DH Key | Function |
|--------------|----------------|----------|
| J | E | Move down (visual) |
| K | I | Move up (visual) |

### Extended Navigation
| Key | Function |
|-----|----------|
| N | Start of line |
| O | End of line |
| E | Scroll down (Ctrl+d) |
| I | Scroll up (Ctrl+u) |
| h | Open line below (cursor pos preserved) |
| H | Open line above |
| k | Enter insert mode (cursor pos preserved) |

### Folding shorthand (Colemak-friendly)
| Key | Function |
|-----|----------|
| `zn` | zc (close fold) |
| `zN` | zM (close all folds) |
| `zO` | zR (open all folds) |

> Caveat: Colemak-safe keys for new chains are anything except `n/e/i/o` and their uppercase variants. The dadbod (`<leader>d<`) and storyboard (`<leader>ts<`) prefixes were chosen to avoid them.

## 🔧 System Keybindings

### File management
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>w` | `:w<CR>` | Save file |
| `<leader>q` | `:q<CR>` | Close file |
| `<leader>W` | `:luafile %<CR>` | Run Lua (source current file) |
| `<leader>j` | `jump_to_line()` | Jump to a specific line in the current buffer |
| `-` | `:Oil<CR>` | Open parent directory (Oil) |
| `<leader>e` | `:Oil<CR>` (from `plugins/oil.lua`) | Open Oil in current buffer's directory |
| `<leader>E` | `:Oil .<CR>` | Open Oil in current working directory |
| `<leader>ff` | FzfLua files | Find files |
| `<leader>fb` | FzfLua buffers | List buffers |
| `<leader>fr` | `Snacks.picker.recent()` | Recent files |
| `<leader>fp` | `NeovimProjectLoadRecent` | Recent project |
| `<leader>fP` | `NeovimProjectDiscover` | Discover projects |

> In standalone Neovim, `<leader>e`/`<leader>E`/`-` are Oil keymaps; in VS Code mode `<leader>e` is remapped to the VS Code explorer via `keymaps/nvim_vscode.lua` while the other two stay as Oil.

### Search
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>sgg` | FzfLua live_grep | Search text in files (global) |
| `<leader>sgf` | FzfLua live_grep (current file) | Search text in `vim.fn.expand("%:p")` |
| `<leader>ss` | FzfLua lsp_document_symbols | Search LSP symbols |

### Window / motion
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>iwp` | window_picker() | Pick a window |
| `f` / `F` | flash_jump / flash_treesitter | Flash motion (n/x/o modes) |

### Terminal / external launcher
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>tt` | Snacks.terminal() | Toggle Snacks floating terminal |
| `<leader>to` | open_external_opencode() | Open OpenCode in project root (uses `vim.g.external_terminal`) |

### Smart punctuation
| Keybinding | Function | Description |
|------------|----------|-------------|
| `;` | `add_dot()` | Smart `;` insertion at EOL |
| `,` | `add_coma()` | Smart `,` insertion at EOL |

### Runners (`<leader>c<key>`)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>cn` | runner_run() | Run project by filetype (unirunner) |
| `<leader>ck` | runner_cancel() | Cancel live run |
| `<leader>cN` | runner_select_run() | Pick + run |
| `<leader>co` | runner_open_url() | Open runner URL (e.g. ASP.NET launchSettings) |
| `<leader>cO` | runner_url_select() | Pick a runner URL |
| `<leader>cc` | runner_config() | Add a runner config |
| `<leader>ch` | runner_history() | Show output history |
| `<leader>iwt` | runner_go_terminal() | Jump to runner terminal |

### Neotest (`<leader>iu<key>`)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>iur` | `neotest.run.run()` | Run test under cursor |
| `<leader>iuR` | `neotest.run.run({ suite = true })` | Run all tests in suite |
| `<leader>ius` | `neotest.summary.toggle()` | Toggle test summary |
| `<leader>iud` | `neotest.run.run({ strategy = "dap" })` | Debug test under cursor |

### ZealSearch (`<leader>i<z>`)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>iz` | zeal_search_input() | Open ZealSearch dialog |
| `<leader>iZ` | zeal_search_repeat() | Repeat last Zeal query |

### Unipackage / Dashboard URL
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>ip` | unipackage_menu() | Unipackage menu (project actions) |
| `<leader>iou` | dashboard_open_url() | Open a URL from gitignored `lua/config/dashboard-urls.lua` |

### Nvim status / reload / health
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>nr` | DevReload | Full reload LSP (cycle custom pipeline) |
| `<leader>nl` | LspReload | Reload LSP only |
| `<leader>ns` | StartupTime | Show startup performance |
| `<leader>nS` | SlowPlugins | Show slow-loading plugins |
| `<leader>nh` | checkhealth | Health check |
| `<leader>nn` | `<cmd>Noice all<cr>` | Show Noice history (when Noice is active) |
| `<leader>np` | `%bd!\|e#` | Purge buffers |

### Cellular Automaton (visual effect)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>!` | CellularAutomaton `make_it_rain` | Make it rain |

## 🎨 Plugin Keybindings

### Grapple (bookmarks) — `lua/plugins-keymaps/grapple-keymaps.lua`
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>aa` | `grapple.toggle()` | Toggle bookmark on file |
| `<leader>ah` | `grapple.open_tags()` | Open bookmarks menu |
| `<leader>as` | `grapple.open_tags()` | Search bookmarks (alias of menu) |
| `<C-1>` | `grapple.select({ index = 1 })` | Bookmark 1 |
| `<C-2>` | `grapple.select({ index = 2 })` | Bookmark 2 |
| `<C-3>` | `grapple.select({ index = 3 })` | Bookmark 3 |
| `<C-4>` | `grapple.select({ index = 4 })` | Bookmark 4 |

### Multicursor — `lua/keymaps/nvim.lua`
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<C-n>` | `mc_add_cursor_next()` | Add cursor at next match |
| `<C-p>` | `mc_add_cursor_prev()` | Add cursor at previous match |
| `<leader>ma` | `mc_match_all_cursors()` | Add cursor to all matches |
| `<esc>` | `mc_clear_or_enable_cursors()` | Toggle multicursor mode |

### DAP — `lua/plugins-keymaps/dap-keymaps.lua`
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<F5>` | Smart dap.continue | Start with auto-detected "Current File" config |
| `<F10>` | `dap.step_over()` | Step over |
| `<F11>` | `dap.step_into()` | Step into |
| `<F12>` | `dap.step_out()` | Step out |
| `<leader>ib` | `toggle_breakpoint_or_debugger()` | Toggle breakpoint (or insert `debugger;` in JS/TS) |
| `<leader>iB` | `dap.set_breakpoint(condition)` | Conditional breakpoint |
| `<leader>cdr` | `dap.repl.open()` | Open REPL |
| `<leader>cdu` | `dapui.toggle()` | Toggle debugging UI |
| `<leader>cdx` | `dap.terminate()` | Stop debug session |
| `<leader>cdd` | `auto_detect_debug()` | Auto-detect project type + run |
| `<leader>cdt` | NUnit test in current file | Debug PHPUnit/NUnit test for current file |
| `<leader>cdT` | All NUnit tests | Debug all NUnit tests in solution |

### LazyGit / LazyDocker / Terminal (`<leader>i<key>`)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>ig` | `Snacks.lazygit()` | LazyGit (via Snacks) |
| `<leader>id` | `Snacks.terminal({ "lazydocker" })` | LazyDocker (lazydocker binary must be installed) |
| `<leader>tt` | `Snacks.terminal()` | Toggle Snacks floating terminal |

### DiffView — `lua/plugins-keymaps/diffview-keymaps.lua`
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>gd` | `Diffview.open()` | DiffView (working changes; toggles when already open) |
| `<leader>gD` | `Diffview.open({ files_only = true })` | DiffView vs HEAD, files only |
| `<leader>gh` | `Diffview.file_history()` | File history |
| `<leader>gH` | `Diffview.file_history({ rev = { "HEAD" } })` | Branch history |
| `<leader>gt` | `Diffview.toggle_files()` | Toggle files panel |

> Note: `<leader>gd` and `<leader>gD` here are **global** mappings, while `gd` / `gD` from `lsp/on_attach.lua` are **buffer-local**. When an LSP is attached, the LSP version wins inside that buffer.

### Snacks Picker (`<leader>s<key>`)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>sm` | `Snacks.picker.marks()` | Marks |
| `<leader>sh` | `Snacks.picker.help()` | Help pages |
| `<leader>sk` | `Snacks.picker.keymaps()` | Keymaps |
| `<leader>sc` | `Snacks.picker.commands()` | Commands |
| `<leader>su` | `Snacks.picker.undo()` | Undo history |
| `<leader>sq` | `Snacks.picker.qflist()` | Quickfix list |
| `<leader>sl` | `Snacks.picker.loclist()` | Location list |
| `<leader>sr` | `Snacks.picker.resume()` | Resume last picker |

### Notes (Markdown vault) — `lua/plugins-keymaps/notes-keymaps.lua`
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>on` | new_note_with_folder() | Create a note in a vault folder |
| `<leader>oC` | capture_note() | Quick note (no folder picker) |
| `<leader>od` | open_daily_note(0) | Today's daily note |
| `<leader>oD` | open_daily_note(-1) | Yesterday's daily note |
| `<leader>ot` | open_daily_note(1) | Tomorrow's daily note |
| `<leader>os` | grep_notes() | Grep the vault |
| `<leader>of` | find_notes() | File picker scoped to the vault |
| `<leader>ob` | show_backlinks() | Snacks grep for current note name |
| `<leader>og` | show_tags() | Snacks grep for `#tag` |
| `<leader>or` | rename_note() | Rename current note |
| `<leader>oc` | toggle_checkbox() | Toggle `- [ ]` ⇄ `- [x]` |
| `<leader>ok` | follow_link() | Follow `[[wiki]]` or `[text](path)` |

For markdown buffers, `gf` is also buffer-mapped to `follow_link`.

### Markdown preview
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>mp` | toggle_peek_preview() | Toggle peek.nvim markdown preview |

### Yanky — `lua/plugins-keymaps/yanky-keymaps.lua`
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>yh` | yank_history | Yank history picker |

> Yanky also enhances `p`/`P` with cycle history (`>p` / `<p`), indent paste (`]p` / `[p`), and system clipboard integration via its default behavior.

### Conform — `lua/plugins-keymaps/conform-keymaps.lua`
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>mf` | conform.format() (async) | Format buffer |
| `<leader>mF` | conform.format() (sync) | Format buffer synchronously |
| `<leader>mf` (visual) | conform.format() | Format selection |

### Unidiagnostic / Undotree / Built-in diagnostics — `lua/keymaps/nvim.lua`
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>isp` | `UnidiagnosticToggle` | Toggle diagnostics panel |
| `<leader>isc` | `UnidiagnosticCurrent` | Show current file diagnostics |
| `<leader>u` | `UndotreeToggle` | Toggle undo tree |
| `[d` | `vim.diagnostic.jump({ count = -1 })` | Previous diagnostic (rounded float) |
| `]d` | `vim.diagnostic.jump({ count = 1 })` | Next diagnostic |
| `<leader>isd` | `vim.diagnostic.open_float` | Line diagnostics |
| `<leader>isq` | `vim.diagnostic.setqflist` | Send diagnostics to quickfix |
| `<leader>isl` | `vim.diagnostic.setloclist` | Send diagnostics to location list |

## 📝 LSP Keybindings (set in `lua/lsp/on_attach.lua`)

### LSP navigation
| Keybinding | Function | Description |
|------------|----------|-------------|
| `gd` | `fzf-lua.lsp_definitions({ jump1 = true })` | Go to definition |
| `gD` | `fzf-lua.lsp_references({ jump1 = true })` | Find references |
| `gi` | `fzf-lua.lsp_implementations({ jump1 = true })` | Implementations |
| `gt` | `fzf-lua.lsp_typedefs({ jump1 = true })` | Type definition |
| `K` | `vim.lsp.buf.hover` | Hover documentation |
| `.` | `vim.lsp.buf.code_action` | Code actions |
| `<leader>rn` | `function-keymaps.lsp_rename_and_save` | Rename (writes every modified normal buffer) |
| `<leader>ca` | `vim.lsp.buf.code_action` | Code action |
| `<leader>cl` | `vim.lsp.codelens.run` | Run LSP CodeLens |

### LSP features
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>th` | `toggle_inlay_hints` | Toggle inlay hints (uses `vim.lsp.inlay_hint`) |
| `<leader>td` | `toggle_diagnostics_display` | Toggle diagnostic virtual text/virtual lines |
| `Navic` | `nvim-navic.attach` | Statusline breadcrumbs (auto-attached when server supports `documentSymbolProvider`) |

> Semantic tokens are intentionally disabled for **all** clients in `lsp/on_attach.lua` (`client.server_capabilities.semanticTokensProvider = nil`) — the Tree-sitter warnings/errors list carries the highlights.

## 🗃️ Dadbod / SQL — `lua/plugins-keymaps/dadbod-keymaps.lua`

| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>db` | `:DBUIToggle` | Toggle DB UI sidebar |
| `<leader>du` | `dadbod.dadbod_build_url` | Interactively build a `mysql`/`sqlserver`/`postgres` URL and copy it to `+` and `"` registers |
| `<leader>dC` | `:DBUICloseTab` | Close the result tab |
| `<leader>dr` | `:DBUIRenameBuffer` | Rename the current result buffer |
| `<leader>dL` | `:DBCompletionClearCache` | Clear dadbod-completion schema cache |

SQL buffers (`sql`/`mysql`/`plsql`) also get the `dadbod` blink.cmp completion source configured in `lua/plugins/blink-cmp.lua`.

## 🪪 Storyboard (DiaProject) — `lua/plugins-keymaps/storyboard-keymaps.lua`

Custom kanban backend in `lua/config/storyboard.lua`. Requires `go` + `curl`.

| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>tsd` | `dia_start` | Clone (if needed) + build + start the server |
| `<leader>tsD` | `dia_stop` | Stop the server |
| `<leader>tso` | `dia_open` | Open `http://localhost:<port>` in the browser |
| `<leader>tsl` | `dia_logs` | Open the storyboard log in a vsplit |
| `<leader>tsp` | `dia_projects` | List projects (REST `/api/projects`) |
| `<leader>tsn` | `dia_create_project` | Create project (REST `POST /api/projects`) |
| `<leader>tsc` | `dia_columns` | List columns of a selected project |
| `<leader>tsk` | `dia_cards` | List cards (project → column → cards) |

## 📋 Snippets (blink.cmp + LuaSnip)

| Keybinding | Mode | Function |
|------------|------|----------|
| `<Tab>` | n / i | Visible → next; otherwise expand LuaSnip / jump |
| `<S-Tab>` | n / i | Visible → previous; otherwise LuaSnip jump(-1) |
| `<CR>` | i | Accept current item with `select_and_accept` / fallback |
| `<C-Space>` | i | Show completion / toggle documentation |
| `<C-j>` | i | Select next or fall through |
| `<C-k>` | i | Select previous or fall through |
| `<C-s>` | i | Snippet provider only (force snippets picker) |

## 🆚 VS Code Neovim Keymaps

When running inside the [VS Code Neovim extension](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim), several keymaps are remapped to VS Code native commands via `vim.fn.VSCodeNotify`:

### Remapped keybindings
| Keybinding | VS Code Command | Description |
|------------|-----------------|-------------|
| `<leader>ff` | `workbench.action.quickOpen` | Quick open file |
| `<leader>fb` | `workbench.action.showAllEditors` | Show all editors |
| `<leader>sg` | `workbench.action.findInFiles` | Search across files |
| `<leader>ss` | `workbench.action.gotoSymbol` | Go to symbol |
| `<leader>e` | `workbench.view.explorer` | Toggle explorer |
| `<leader>tt` | `workbench.action.terminal.toggleTerminal` | Toggle terminal |
| `<leader>mp` | `markdown.showPreview` | Markdown preview |
| `<leader>mf` | `editor.action.formatDocument` | Format document |
| `gd` | `editor.action.revealDefinition` | Go to definition |
| `K` | `editor.action.showHover` | Hover documentation |
| `<leader>rn` | `editor.action.rename` | Rename symbol |
| `<leader>ca` | `editor.action.quickFix` | Code action |
| `<F5>` / `<F10>` / `<F11>` / `<F12>` | workbench debug actions | Debug start / step over / into / out |
| `<leader>ib` | `editor.debug.action.toggleBreakpoint` | Toggle breakpoint |
| `<leader>w` | `workbench.action.files.save` | Save file |
| `<leader>q` | `workbench.action.closeActiveEditor` | Close editor |

### Silent undo
`u` and `U` are silenced (`<cmd>silent undo<CR>` / `<cmd>silent redo<CR>`) to avoid "Already at oldest change" spam in the OUTPUT panel.

### Panel navigation (VS Code `keybindings.json`)
VS Code panels (search results, explorer) keep native Colemak mappings via `~/.config/Code/User/keybindings.json`:
| Key | Action |
|-----|--------|
| `e` | Move down in list |
| `i` | Move up in list |
| `n` | Collapse folder |
| `o` | Expand folder / open file |
| `Alt+Q` | Close sidebar/panel |

## 🔄 Colemak-DH Reversion

To revert to the standard Vim layout, see [colemak-dh.md](colemak-dh.md).

## 📚 Quick Reference

### Most used shortcuts
- **Navigation**: n,e,i,o (left, down, up, right)
- **Files**: `<leader>ff` (find), `<leader>w` (save)
- **LSP**: `gd` (definition), `K` (documentation), `<leader>th` (inlay hints)
- **Git**: `<leader>ig` (LazyGit), `<leader>gd` (DiffView)
- **Testing**: `<leader>iur` (run tests)
- **Search**: `<leader>sgg` (live grep), `<leader>sgf` (current file), `<leader>ss` (symbols)
- **Multicursor**: `<C-n>` (add cursor), `<esc>` (clear)
- **Flash**: `f` (jump), `F` (treesitter)
- **Notes**: `<leader>od` (today), `<leader>of` (find), `<leader>og` (tags)
- **Storyboard**: `<leader>tsd` (start), `<leader>tso` (open), `<leader>tsl` (logs)
- **Dadbod**: `<leader>db` (UI), `<leader>du` (URI builder)

## 🌐 Languages

- 🇺🇸 **English**: This documentation
- 🇪🇸 **Español**: [Keybindings en Español](../es/keymaps.md)

---

*For a complete guide on how to revert the Colemak-DH layout to standard, see [colemak-dh.md](colemak-dh.md).*
