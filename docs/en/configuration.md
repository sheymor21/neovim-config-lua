# Configuration

This guide covers the general Neovim configuration, including basic options, LSP configurations, and key customization aspects.

## 📁 File Structure

```
~/.config/nvim/
├── init.lua                       # Main entry point (branches to init/nvim or init/nvim_vscode)
├── AGENTS.md                      # Agent guide for LLM agents
├── README.md                      # Documents and entry points
├── LICENSE                        # MIT License
├── lazy-lock.json                 # Plugin version lockfile (gitignored)
├── docs/                          # User-facing docs (en/ + es/)
├── optional-guides/               # Auxiliary guides (e.g. Azure DevOps, Git credential manager)
└── lua/
    ├── init/                      # Environment entry points
    │   ├── nvim.lua               # Standalone Neovim init
    │   └── nvim_vscode.lua        # VS Code: init
    ├── general-config.lua         # Shared autocmds and settings
    ├── general-config/            # Environment-specific configurations
    │   └── nvim.lua               # Nvim-only autocmds
    ├── keymaps.lua                # Keymaps entry (branches to keymaps/core + keymaps/{nvim,nvim_vscode})
    ├── keymaps/                   # Keymap modules
    │   ├── core.lua               # Shared keymaps (Colemak, basics, flash)
    │   ├── nvim.lua               # Nvim-only keymaps
    │   └── nvim_vscode.lua        # VS Code: keymaps
    ├── function-keymaps.lua       # Custom functions and LSP behaviors
    ├── health.lua                 # Health checks
    ├── utils.lua                  # Utility helpers
    ├── config/                    # Configuration / setup modules
    │   ├── theme.lua              # Theme switcher
    │   ├── filetype-theme.lua     # Auto-theme per filetype
    │   ├── lazy.lua               # Lazy.nvim bootstrap and VS Code plugin filter
    │   ├── dap-config.lua         # DAP adapters and configurations
    │   ├── lazygit.lua            # LazyGit toggle wrapper
    │   ├── lazy-docker.lua        # LazyDocker toggle wrapper
    │   ├── indent.lua             # Indent settings
    │   ├── dadbod.lua             # vim-dadbod-ui setup
    │   ├── dashboard-urls.lua     # Dashboard URL list (gitignored)
    │   ├── dashboard-urls.example.lua
    │   ├── paths.lua              # Vault and path constants
    │   ├── helpers.lua            # Random helper snippet lists (SQL, …)
    │   ├── snacks.lua             # Snacks.nvim overrides (vim.notify)
    │   ├── csharp-accessors.lua   # C# custom accessor overrides
    │   ├── csharp-editorconfig.lua # C# editorconfig helper
    │   ├── plugin-health.lua      # Plugin health checks
    │   ├── profiler.lua           # Startup-time error capture
    │   ├── reloader.lua           # Manual :reload helper
    │   ├── diffview.lua           # Diffview setup
    │   └── storyboard.lua         # Story Board (DiaProject) backend
    ├── plugins/                   # Plugin specifications
    │   ├── autopairs.lua          # nvim-autopairs
    │   ├── blink-cmp.lua          # blink.cmp completion
    │   ├── cellular.lua           # cellular-automaton visual effects
    │   ├── colors.lua             # Color schemes (ayu/kanagawa/tokyodark/gruvbox/onedark/onedark_dark)
    │   ├── configurationless.lua  # Utility functions
    │   ├── conform.lua            # Async/sync formatting
    │   ├── dadbod.lua             # vim-dadbod + dadbod-ui + dadbod-completion
    │   ├── dap-ui.lua             # nvim-dap-ui
    │   ├── diffview.lua           # diffview.nvim setup
    │   ├── faster.lua             # Faster.nvim (large-file guard)
    │   ├── flash.lua              # Flash.nvim
    │   ├── fzf-lua.lua            # Fzf-lua
    │   ├── gitsigns.lua           # Git signs
    │   ├── grapple.lua            # Grapple bookmarks
    │   ├── lazydev.lua            # Lua dev (lazydev.nvim)
    │   ├── lualine.lua            # Status line
    │   ├── luasnipet.lua          # LuaSnip snippets (filename kept for back-compat)
    │   ├── markdown-render.lua    # Markdown rendering
    │   ├── mason.lua              # Mason / mason-lspconfig / mason-nvim-dap
    │   ├── multicursor.lua        # jake-stewart/multicursor.nvim
    │   ├── neotest.lua            # Neotest harness
    │   ├── neovim-session-manager.lua  # Shatur/neovim-session-manager
    │   ├── noice.lua              # Noice.nvim
    │   ├── nvim-navic.lua         # LSP breadcrumbs
    │   ├── nvim-web-devicons.lua  # File icons
    │   ├── oil.lua                # oil.nvim file manager
    │   ├── projects.lua           # Projects / neovim-project
    │   ├── rainbow-delimiters.lua # Rainbow delimiters
    │   ├── reloader.lua           # Reloader.nvim
    │   ├── roslyn.lua             # seblyng/roslyn.nvim
    │   ├── snacks.lua             # folke/snacks.nvim
    │   ├── spider.lua             # Spider.nvim
    │   ├── toggle-term.lua        # ToggleTerm
    │   ├── treesitter.lua         # Treesitter
    │   ├── ufo.lua                # UFO folding
    │   ├── undotree.lua           # Undotree
    │   ├── unidiagnostic.lua      # Diagnostics toggle
    │   ├── unipackage.lua         # Package manager
    │   ├── unirunner.lua          # Unified runner (local clone)
    │   ├── wakatime.lua           # Wakatime (disabled)
    │   ├── which-key.lua          # Which-key
    │   ├── windows-picker.lua     # Window selection
    │   ├── yanky.lua              # Yank/paste history
    │   └── zealsearch.lua         # Zeal documentation search
    ├── nvim_vscode/               # VS Code compatibility layer (external)
    │   └── init.lua               # Provides disabled_plugins table
    ├── plugins-off/               # Disabled plugins (no-op specs)
    │   ├── 99.lua / 99-keymaps.lua
    │   ├── dressing.lua
    │   ├── harpoon2.lua / harpoon2-keymaps.lua
    │   ├── obsidian.lua
    │   ├── overseer.lua
    │   ├── sessions.lua
    │   └── tiny-inline-diagnostic.lua
    ├── plugins-keymaps/           # Plugin-specific keymaps
    │   ├── conform-keymaps.lua
    │   ├── dadbod-keymaps.lua
    │   ├── dap-keymaps.lua
    │   ├── diffview-keymaps.lua
    │   ├── fzf-lua-keymaps.lua
    │   ├── grapple-keymaps.lua
    │   ├── lazydocker-keymaps.lua
    │   ├── lazygit-keymaps.lua
    │   ├── notes-keymaps.lua
    │   ├── snacks-keymaps.lua
    │   ├── spider-keymaps.lua
    │   ├── storyboard-keymaps.lua
    │   └── yanky-keymaps.lua
    └── lsp/                       # Language Server setup
        ├── gopls.lua              # Go LSP
        ├── vtsls.lua              # TS/JS LSP
        ├── lua-lsp.lua            # Lua LSP
        ├── html.lua               # HTML LSP
        ├── css.lua                # CSS LSP
        ├── markdown.lua           # Markdown LSP
        ├── on_attach.lua          # LspAttach handler
        ├── setup.lua              # Server registration pipeline
        ├── servers.lua            # Server list (single source of truth)
        └── utils.lua              # LSP utilities (vim.lsp.start wrapper)
```

## ⚙️ General Configuration

### Basic Options (init.lua)
```lua
-- Relative numbers
vim.opt.relativenumber = true

-- Tab configuration
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Colors and UI
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Leader key
vim.g.mapleader = " "

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Virtualedit off (strict cursor)
vim.o.virtualedit = ""

-- Timeoutlen tuned for snack UX
vim.opt.timeoutlen = 700

-- Default external terminal hint for opencode launcher
vim.g.external_terminal = "alacritty"
```

### Autocommands (general-config.lua)

The shared `general-config.lua` defines:

**Diagnostic configuration** (errors only, virtual-text prefix `●`)
```lua
vim.diagnostic.config({
    virtual_text = { prefix = "●", spacing = 2, severity = { min = vim.diagnostic.severity.ERROR } },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
```

**Highlight on yank**
```lua
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = vim.api.nvim_create_augroup("UserConfig", { clear = false }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})
```

**Combined BufEnter** handler (skips prompt buffers, runs `filetype detect` when empty, reattaches treesitter)

**CRLF → LF** auto-conversion on open via `BufReadPost`

**Fold defaults**: `foldlevel = 99`, `foldlevelstart = 99`, `foldenable = true` (ufo manages foldmethod/foldexpr at runtime)

### Nvim-only autogroup (`lua/general-config/nvim.lua`)

Loaded only in standalone Neovim, not in VS Code.

**Project buffer cleanup on `DirChanged`** — buffers outside the new cwd are deleted when the directory changes.

**Auto-insert** for `snacks_input` / `snacks_picker_input` filetypes so prompts accept text immediately.

## 🎨 Theme System

### Theme Configuration (`config/theme.lua`)
- **Default theme**: `ayu` (loaded eagerly via `lua/plugins/colors.lua`)
- **Available themes**: ayu, kanagawa, tokyodark, gruvbox, onedark, onedark_dark
- **Switching**: dynamic — accidentally-cleared icon colors are restored after a colorscheme change (`refresh_devicons`)
- **Lualine sync**: the corresponding theme variant is applied to lualine when the colorscheme changes
- **Blink.cmp highlights**: `BlinkCmpMenuSelection` is linked to `PmenuSel` and `BlinkCmpLabelMatch` to `Search` so completion styles stay consistent across themes

### Filetype-specific themes (`config/filetype-theme.lua`)
- Skips special buftypes (e.g. lazy, mason, notify)
- Cache by last filetype avoids re-applying on every BufEnter
- Mapping:
  - `lua` → `ayu`
  - `go` → `onedark_dark`
  - `cs` → `gruvbox`
  - `html` → `tokyodark`
  - `css` → `gruvbox`
  - `javascript` / `typescript` → `onedark_dark`
- Fallback for any other filetype: `kanagawa`

## 🔧 LSP Configuration

### Custom startup pipeline (no nvim-lspconfig)
1. `lsp/servers.lua` declares the list of servers (`{ name, module }`)
2. `lsp/setup.lua` registers each one as a `FileType` autocmd that calls `lsp/utils.start_lsp_client`
3. The same module wires a global `LspAttach` autocmd to `lsp/on_attach.lua`
4. `:DevReload` and `:LspReload` cycle this pipeline

### `lsp/utils.lua`
```lua
function M.start_lsp_client(server_name, bufnr, config)
    config.capabilities = require("blink.cmp").get_lsp_capabilities()
    return vim.lsp.start(config, {
        bufnr = bufnr,
        reuse_client = function(client, conf) return client.name == conf.name end,
    })
end
```

### `lsp/on_attach.lua` (excerpt)
```lua
client.server_capabilities.semanticTokensProvider = nil

map("n", "gd", function() require("fzf-lua").lsp_definitions({ jump1 = true }) end, { ... })
map("n", "gD", function() require("fzf-lua").lsp_references({ jump1 = true }) end, { ... })
map("n", "gi", function() require("fzf-lua").lsp_implementations({ jump1 = true }) end, { ... })
map("n", "gt", function() require("fzf-lua").lsp_typedefs({ jump1 = true }) end, { ... })
map("n", "K", vim.lsp.buf.hover, { ... })
map("n", ".", vim.lsp.buf.code_action, { ... })
map("n", "<leader>rn", require("function-keymaps").lsp_rename_and_save, { ... })
map("n", "<leader>ca", vim.lsp.buf.code_action, { ... })

-- breadcrumbs via nvim-navic, only when the server provides documentSymbolProvider
if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
end

-- inlay hints and code lenses are enabled per-server-capability, not globally
```

`<leader>rn` is wired to `function-keymaps.lsp_rename_and_save`, which performs the rename and then silently writes **every modified normal buffer** so cross-file renames (Roslyn C#, gopls Go) don't get lost.

### Active servers (`lsp/servers.lua`)
- `gopls` — Go (system install)
- `lua_ls` — Lua (Mason + lazydev)
- `vtsls` — TypeScript/JavaScript (Mason)
- `html`, `cssls` — Web (Mason)
- `marksman` — Markdown (Mason)

`jsonls` is listed in Mason `ensure_installed` and in the health check but is **not** on `servers.lua`. Install it manually with `:MasonInstall jsonls` if needed.

### Exceptions
- **C# (`roslyn`)**: handled by `seblyng/roslyn.nvim` in `lua/plugins/roslyn.lua` (with `vim.lsp.config("roslyn", ...)` and Roslyn-specific `filewatching = "auto"`, `lock_target = true`, and razor disabled). **Not** routed through the custom `lsp/setup.lua` pipeline.
- **VS Code mode**: VS Code's bundled LSP / snippet engines replace every server here.

## 🛠️ Plugin Configuration

### Lazy.nvim bootstrap (`config/lazy.lua`)
Clones `folke/lazy.nvim` on first run (stable branch) and:
- **Standalone Neovim**: `require("lazy").setup("plugins")` (loads every spec under `lua/plugins/`)
- **VS Code**: scans `lua/plugins/*.lua` manually and filters against `nvim_vscode.disabled_plugins`, so no plugin loads unless it's safe to combine with VS Code.

### Notable plugin configs

**blink.cmp (`plugins/blink-cmp.lua`)**
- Default sources: `lsp`, `lazydev`, `snippets`, `buffer`, `path`
- **SQL filetypes** (`sql`, `mysql`, `plsql`) swap in the `dadbod` source via `per_filetype` and the `providers.dadbod` entry
- Presets: cooperative LuaSnip via `snippets.preset = "luasnip"`
- Snippet-only hotkey: `<C-s>`
- Tab/S-Tab navigate or call `luasnip.expand_or_jump()` / `jump(-1)`
- Signature help and cmdline completion enabled
- Fuzzy: `prefer_rust_with_warning`

**fzf-lua (`plugins/fzf-lua.lua`)**
- Native fzf performance; horizontal preview layout
- File, buffer, grep, and LSP-symbol pickers. Pickers are launched from `plugins-keymaps/fzf-lua-keymaps.lua`.

**Dadbod (`plugins/dadbod.lua`)**
- Composes `tpope/vim-dadbod`, `vim-dadbod-ui`, and `vim-dadbod-completion`
- Lazy-loads on the `:DB*` commands and on SQL filetypes
- Connection strings are added via `:DBUIAddConnection` and stored under `~/.local/share/nvim/dadbod_ui/`
- `config/dadbod.lua` only sets `vim.g.db_ui_use_nerd_fonts = 1` and a rounded floating window for the UI

**Diffview (`plugins/diffview.lua`)**
- Wired through `config/diffview.lua` and the global `<leader>g*` keymaps in `plugins-keymaps/diffview-keymaps.lua`. The `<leader>gd` mapping toggles the working-change view.

**Storyboard (no plugin spec)**
- The custom Go backend from `lua/config/storyboard.lua` clones `https://github.com/sheymor21/DiaProject.git` to `vim.fn.stdpath("data")/storyboard`, builds the `server` binary on first start, and launches it on a free port.
- Its lifecycle is `defer`-style: it loads lazily (only the `start/stop/api_*` calls reach into it) and is fully scriptable via the `<leader>ts<key>` prefix in `plugins-keymaps/storyboard-keymaps.lua`.

**Helper snippets (no plugin spec)**
- Data lives in `lua/config/helpers.lua` as `M.helpers.<key>` tables with a `label` and an `items` list of strings (multiline via `[[...]]`).
- Keymaps live in `plugins-keymaps/helpers-keymaps.lua` under the `<leader>h<key>` prefix (`<leader>hs` = SQL, `<leader>hl` = edit the data file). Picking an item copies it to the `+` register.

**DAP (`config/dap-config.lua`)**
- Go (delve via Mason), C# (netcoredbg via Mason — auto-installs if missing), JavaScript/TypeScript (js-debug-adapter via Mason)
- C# configurations include auto-detection from `.sln` / `.csproj`, NUnit suite runners, and ASP.NET launchSettings URL injection
- TS runner auto-detects `npm`/`pnpm`/`yarn`/`bun`

**Unirunner (`plugins/unirunner.lua`)**
- Local clone at `~/Projects/unirunner.nvim` (the public `sheymor21/unirunner.nvim` spec is commented out)
- Panel keymaps are already remapped to Colemak-DH (`e`/`i` for down/up)
- Root markers: `package.json`, `go.mod`, `*.sln`, `.git`

## 🎯 Custom Functions (`function-keymaps.lua`)

The `M` table in `function-keymaps.lua` wraps every non-trivial keymap helper; keymap files only consume `M.<name>`.

### Punctuation helpers
- `M.add_dot()` — Smart `;` insertion; skips when the eol already ends with `;`
- `M.add_coma()` — Same for `,`

### Notes / vault helpers
- `M.search_notes()` — Snacks grep for `"- [ ]"` in the vault
- `M.new_note_with_folder()` — Pick a vault folder, then a title, then write a new note using `templates/new_note.md`
- `M.find_notes()`, `M.grep_notes()` — Snacks pickers scoped to the vault
- `M.open_daily_note(offset)` — Today/yesterday/tomorrow daily note (`daily/<date>.md`)
- `M.show_backlinks()` / `M.show_tags()` — Snacks grep on the current note name / `#[%w_-]+`
- `M.rename_note()` — Interactive vault rename
- `M.toggle_checkbox()` — Flip `- [ ]` ⇄ `- [x]` in place
- `M.follow_link()` — Follow `[[wiki]]` or `[text](path)` under cursor (also bound to `gf` in markdown bufs)
- `M.capture_note()` — Single-input quick note (no folder picker)
- `M.open_notes_panel()` — Alias of `find_notes()`

### Editor / LSP helpers
- `M.lsp_rename_and_save()` — Wraps `textDocument/rename` and silently writes every modified normal buffer (cross-file renames for Roslyn / gopls)
- `M.jump_to_line()` — Interactive jump inside the current buffer
- `M.toggle_inlay_hints()` — Global toggle of `vim.lsp.inlay_hint`
- `M.toggle_diagnostics_display()` — Switch between inline `virtual_text` and `virtual_lines`

### Neonav / view helpers
- `M.dashboard_git_clone()` — Clone a repository into `~/Projects` from the dashboard
- `M.dashboard_open_url()` — Open a URL from the gitignored `lua/config/dashboard-urls.lua`
- `M.open_external_opencode()` — Launch `opencode` in the project root in a user-configurable terminal

### Multi-cursor / Flash / preview
- `M.mc_add_cursor_next()`, `M.mc_add_cursor_prev()`, `M.mc_match_all_cursors()`, `M.mc_clear_or_enable_cursors()`
- `M.flash_jump()`, `M.flash_treesitter()`
- `M.toggle_peek_preview()` — Toggle `peek.nvim` markdown preview

### Test / runner helpers
- `M.neotest_run()`, `M.neotest_run_all()`, `M.neotest_summary()`, `M.neotest_debug()`
- `M.runner_run()`, `M.runner_cancel()`, `M.runner_select_run()`, `M.runner_config()`, `M.runner_history()`, `M.runner_go_terminal()`
- `M.runner_open_url()`, `M.runner_url_select()`
- `M.unipackage_menu()`

### ZealSearch helpers (`zealsearch`)
- `M.zeal_search_input()` — Open the ZealSearch input dialog
- `M.zeal_search_repeat()` — Repeat the last query
- Smart docset mapping by filetype (`zealsearch_docset_map`): typescript → TypeScript, cs/csharp → C#, sh/bash → Bash, etc.

### Storyboard (DiaProject) helpers
- `M.dia_start()`, `M.dia_stop()`, `M.dia_open()` — lifecycle + browser open
- `M.dia_logs()` — Open the storyboard log in a vsplit
- `M.dia_projects()`, `M.dia_create_project()`, `M.dia_columns()`, `M.dia_cards()` — REST-backed pickers (`/api/projects`, `/api/columns`, `/api/cards`)

### Dadbod helpers
- `M.dadbod_schemes` — registered schemes (`mysql`, `sqlserver`, `postgres`) with default ports, users, and per-scheme extra prompts
- `M.dadbod_build_url()` — Interactive URI builder; the encoded URL is copied to both `+` and `"` registers and surfaced as a notification

### Helper snippet helpers
- `M.helpers_open(key)` — Snacks-backed `vim.ui.select` over `config.helpers[key].items`; the chosen snippet is copied to the `+` register (warns on unknown/empty lists)
- `M.helpers_open_config()` — Opens `lua/config/helpers.lua` for manual add/edit/remove

## 📊 Diagnostic Configuration

Configured globally in `lua/general-config.lua` (see snippet above). The display mode — virtual-text vs virtual-lines — is toggled at runtime via the `<leader>td` keymap (`M.toggle_diagnostics_display`).

## 🔄 Performance Configuration

### Lazy Loading
- Plugin load is driven by `cmd`/`ft`/`event` filters via lazy.nvim
- Non-critical modules are deferred to `User VeryLazy` in `lua/init/nvim.lua`. Add new deferred modules there.
- Modules currently deferred: `config.profiler`, `csharp-accessors`, `csharp-editorconfig`, `filetype-theme`, `indent`, `plugin-health`, `lazy-docker`, `lazygit`, `dap-config`, `lsp.setup`, and snacks' `indent` + `words` sub-modules

### Buffer Management
- BufEnter handler skips prompt buffers (snacks picker/input)
- Treesitter is reattached automatically when the filetype is non-empty
- `DirChanged` cleans buffers outside the new cwd (only in standalone Neovim)
- Vim adjustments: signature help, code lens, inlay hints only enabled when the server advertises them

## 🔧 Customization Guide

### Adding a new plugin
1. Create the spec in `lua/plugins/foo.lua` (or extend an existing inline spec).
2. If it has a lazy.nvim `config = function() ... end`, point it at `require("config.foo")`.
3. Add the setup module under `lua/config/foo.lua`.
4. If you need keymaps, add `lua/plugins-keymaps/foo-keymaps.lua` and require it from `lua/keymaps/nvim.lua`.
5. Verify with `:Lazy`, `:checkhealth`, and `:luafile %` on each touched file.

### Modifying LSPs
1. Edit the server module under `lua/lsp/`.
2. Add the server to `lua/lsp/servers.lua` (single source of truth).
3. Run `:LspReload` or `:DevReload` to apply.

### Changing themes
1. Add the colorscheme plugin + spec in `lua/plugins/colors.lua` (keep `priority >= 1000` if you want it to be the default).
2. Map it in `lua/config/filetype-theme.lua` if you want a per-filetype override.
3. Use `lua/config/theme.lua`'s `M.apply(name)` to switch at runtime.

### Adding a new storyboard/kanban backend
The storyboard helper at `lua/config/storyboard.lua` is a thin wrapper over `vim.fn.jobstart` and `vim.system`. Add new helpers in `lua/function-keymaps.lua` and bind keymaps through `lua/plugins-keymaps/storyboard-keymaps.lua`.

## 🌐 Languages

- 🇺🇸 **English**: This documentation
- 🇪🇸 **Español**: [Configuración en Español](../es/configuracion.md)

## 📚 Additional Resources

- [Neovim Lua API](https://neovim.io/doc/user/lua.html)
- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [blink.cmp Documentation](https://cmp.saghen.dev/)
- [Roslyn.nvim](https://github.com/seblyng/roslyn.nvim)

---

*This configuration is designed to be modular and easy to customize. Feel free to adapt it to your specific needs.*
