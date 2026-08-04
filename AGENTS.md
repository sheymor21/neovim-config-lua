# Agent Guide for Neovim Configuration

## Architecture

**Entry point**: `init.lua` - sets core vim options (tabstop=4, expandtab, relativenumber, etc.), then branches to:
1. `lua/init/nvim.lua` - Standalone Neovim init
2. `lua/init/nvim_vscode.lua` - VS Code: init

Both load: `config/lazy.lua` → `general-config.lua` → `function-keymaps.lua` → `keymaps.lua`

`lua/keymaps.lua` is itself a thin entry that delegates to `lua/keymaps/core.lua` (shared: Colemak, basics, flash) and `lua/keymaps/nvim.lua` (or `nvim_vscode.lua`).

`lua/init/nvim.lua` additionally loads `general-config.nvim` (resolves to `lua/general-config/nvim.lua`), which contains nvim-only autocmds: project buffer cleanup on `DirChanged`, and auto-insert mode for snacks input dialogs.

**Plugin loading pattern** (3-part separation):
```lua
-- lua/plugins/foo.lua - the spec (lazy.nvim spec table)
return { "author/plugin", config = function() require("config.foo") end }

-- lua/config/foo.lua - setup logic
require("plugin").setup({...})

-- lua/plugins-keymaps/foo-keymaps.lua - keymaps
local map = vim.keymap.set
map("n", "<leader>xx", ...)
```

A few specs are inline in `plugins/*.lua` (e.g. `dadbod.lua`, `unirunner.lua`).

**Deferred loading**: Non-critical modules load on `User VeryLazy` event in `lua/init/nvim.lua`. Add new deferred modules there. The `config/lazy.lua` switches to a VS Code-aware filter when `vim.g.vscode` is set.

**VS Code mode**: `vim.g.vscode` triggers `lua/init/nvim_vscode.lua`. The `nvim_vscode` module (not in this repo) provides a `disabled_plugins` list that `config/lazy.lua` uses to filter specs dynamically.

## Critical Conventions

### Colemak-DH Layout (ALWAYS RESPECT)
The config remaps movement keys to Colemak-DH. **When defining new keymaps**:
- `n` = left (was `h`)
- `e` = down (was `j`)
- `i` = up (was `k`)
- `o` = right (was `l`)
- `h` = open line below (was `o`)
- `k` = enter insert mode (was `i`)
- Original `h/j/k/l` are disabled (`<nop>`) in normal+visual

**Safe keys for leader combinations**: Everything except `n/e/i/o` and their uppercase variants.

**Snacks picker keys** in `lua/plugins/snacks.lua` are already mapped to Colemak-DH:
- `<C-e>` / `e` = list down
- `<C-i>` / `i` = list up

### Keymap Behavior Functions
Complex keymap logic goes in `lua/function-keymaps.lua`, wrapped in the `M` table, then referenced in keymaps. Do not inline complex logic in keymap definitions.

### Avoid buffers in leader chains
Snacks pickers run async, so `<leader>sg>` and similar patterns are split into separate `<leader>sXg` style keys (see `lua/plugins-keymaps/fzf-lua-keymaps.lua`).

## Plugin / Module Inventory

### Plugin specs in `lua/plugins/`
- **Editor**: autopairs, blink-cmp, conform, flash, faster, multicursor, noice, spider, ufo, undotree, unidiagnostic, unipackage, unirunner, yanky
- **UI / Nav**: cellular, gitsigns, grapple, lualine, nvim-navic, nvim-web-devicons, snacks, which-key, windows-picker, zealsearch
- **LSP / Mason**: lazydev, mason, roslyn (C#, uses `seblyng/roslyn.nvim`)
- **Fuzzy / Files**: fzf-lua, oil, neovim-session-manager, projects, neotest
- **Markdown / Notes**: markdown-render
- **Storyboard**: Custom Go project (`https://github.com/sheymor21/DiaProject`) — **no plugin spec required**. Logic lives in `lua/config/storyboard.lua` and is bound via `lua/plugins-keymaps/storyboard-keymaps.lua`
- **Data**: dadbod + dadbod-ui + dadbod-completion
- **Diffing**: diffview
- **Theme / Misc**: colors, configurationsless, reloader, toggle-term, treesitter, wakatime (disabled)

### Plugin-keymap files in `lua/plugins-keymaps/`
`conform`, `dadbod`, `dap`, `diffview`, `fzf-lua`, `grapple`, `lazydocker`, `lazygit`, `notes`, `snacks`, `spider`, `storyboard`, `yanky`.

### Config / Setup modules in `lua/config/`
**Theme / appearance**: `theme.lua`, `filetype-theme.lua`, `colors.lua` (plugin spec).
**LSP / Mason**: `dap-config.lua`.
**Tools**: `lazygit.lua`, `lazy-docker.lua`, `indent.lua`, `reloader.lua`, `profiler.lua`.
**Notes vault**: `paths.lua` (default `~/Documents/Sheymor`), `snacks.lua`, `dashboard-urls.lua` (gitignored).
**Specialized**: `csharp-accessors.lua`, `csharp-editorconfig.lua`, `dadbod.lua`, `storyboard.lua`, `plugin-health.lua`, `diffview.lua`.

### Disabled plugins in `lua/plugins-off/`
`99`, `99-keymaps`, `dressing`, `harpoon2`, `harpoon2-keymaps`, `obsidian`, `overseer`, `sessions`, `tiny-inline-diagnostic`. These exist as no-op specs to avoid accidental re-installation.

## Storyboard (DiaProject) Plugin-less module

Sheymor has a custom storyboard backend hosted at `https://github.com/sheymor21/DiaProject`. The module `lua/config/storyboard.lua` clones the repo to `vim.fn.stdpath("data")/storyboard`, builds it with `go build`, and runs the resulting `server` binary. Keymaps live in `lua/plugins-keymaps/storyboard-keymaps.lua` under the `<leader>ts<key>` prefix.

`lua/health.lua` reports the clone, binary, and run status. Required host dependencies: `go` and `curl`.

## Dadbod

`lua/plugins/dadbod.lua` lays out `tpope/vim-dadbod`, `vim-dadbod-ui`, and `vim-dadbod-completion`. Connection strings are managed by the UI itself (`:DBUIAddConnection`), stored under `~/.local/share/nvim/dadbod_ui/`. blink.cmp picks up the dadbod completion source via the providers table in `lua/plugins/blink-cmp.lua` for SQL filetype.

## Testing Changes

1. Edit a Lua file
2. Run `:luafile %` (or `<leader>W`) to source current file
3. Run `:DevReload` if LSP affected
4. Run `:checkhealth` to verify health

## LSP Architecture

Custom LSP setup (not nvim-lspconfig). Uses `lua/lsp/utils.lua`:

```lua
function M.start_lsp_client(server_name, bufnr, config)
    config.capabilities = require("blink.cmp").get_lsp_capabilities()
    return vim.lsp.start(config, { bufnr = bufnr, reuse_client = ... })
end
```

`lua/lsp/servers.lua` lists each server, and `lua/lsp/setup.lua` wires `FileType` autocmds + an `LspAttach` handler that delegates to `lua/lsp/on_attach.lua`.

**Important**: `lua/lsp/on_attach.lua` disables semantic tokens for ALL clients (`client.server_capabilities.semanticTokensProvider = nil`) and enables `nvim-navic` only when `documentSymbolProvider` is advertised. Inlay hints and CodeLens are wired here too.

Active LSP servers (`lsp/servers.lua`):
- `gopls` - Go (system install, via `lua/lsp/gopls.lua`)
- `vtsls` - TypeScript/JavaScript (via Mason)
- `lua_ls` - Lua (via Mason + lazydev)
- `html`, `cssls` - Web (via Mason)
- `marksman` - Markdown (via Mason)

**Exception**: `roslyn` (C#) is handled by `seblyng/roslyn.nvim` in `lua/plugins/roslyn.lua`, NOT the custom LSP setup.

`jsonls` is in the health check and Mason `ensure_installed`, but is not on the `servers.lua` list yet — installing it via `:MasonInstall jsonls` is a manual step.

`lua/lsp/on_attach.lua` wires the `<leader>rn` keymap to `function-keymaps.lsp_rename_and_save`, which performs the rename and silently writes every modified normal buffer (relevant for cross-file C# and Go renames).

## Primary Tools

| Tool | Plugin | Keymaps |
|------|--------|---------|
| File finder | fzf-lua | `<leader>ff`, `<leader>fb` |
| Recent files | Snacks.picker | `<leader>fr` |
| Projects | neovim-project | `<leader>fp`, `<leader>fP` |
| File manager | Oil.nvim | `<leader>e`, `<leader>E` for cwd, `-` for parent |
| Bookmarks | Grapple | `<leader>aa`, `<C-1>` to `<C-4>`, `<leader>as`, `<leader>ah` |
| Git diff | diffview | `<leader>gd`, `<leader>gD`, `<leader>gh`, `<leader>gH`, `<leader>gt` |
| Git | Snacks.lazygit | `<leader>ig`; LazyDocker `<leader>id` |
| Notes | Markdown notes + snacks.picker | `<leader>on`, `<leader>od`, `<leader>of` |
| Picker | Snacks.picker | `<leader>sm`, `<leader>sh`, `<leader>sk`, `<leader>sc`, `<leader>su`, `<leader>sq`, `<leader>sl`, `<leader>sr` |
| Completion | blink.cmp | `<Tab>`, `<S-Tab>`, `<C-j>`, `<C-k>`, `<C-Space>`, `<CR>`, `<C-s>` (snippets-only) |
| Terminal | Snacks.terminal | `<leader>tt` |
| Dashboard | Snacks.dashboard | Shows on startup |
| Storyboard | custom Go binary | `<leader>ts<key>` |
| Databases | dadbod / dadbod-ui | `<leader>db`, `<leader>du`, `<leader>dC`, `<leader>dr`, `<leader>dL` |
| LSP | custom | `gd`, `gD`, `gi`, `gt`, `K`, `.`, `<leader>rn`, `<leader>ca`, `<leader>cl`, `<leader>th`, `<leader>td` |

## Commands

| Command | Purpose |
|---------|---------|
| `:checkhealth` | Run health check (see `lua/health.lua`) |
| `:StartupTime` | Show startup performance |
| `:SlowPlugins` | Show slow-loading plugins |
| `:DevReload` | Full reload LSP (stops → clears cache → reloads configs → reattaches) |
| `:LspReload` | Reload LSP only |
| `:Lazy` | Plugin manager |
| `:Mason` | LSP server installer |
| `:DBUIAddConnection` | Add a dadbod connection |
| `:DiffviewOpen` / `:DiffviewClose` / `:DiffviewFileHistory` | diffview |

## External Dependencies

Optional: `node`, `npm`, `deno`, `go`, `python3`, `dotnet`, `cargo` (required for blink.cmp build)
Required: `git`

For the optional storyboard backend you also need `curl` and `go`. `lua/health.lua` reports each.

## Health Check System

`lua/health.lua` provides `:checkhealth` integration. New checks follow `vim.health.ok/warn/error` and report via `vim.health.info` headings. It covers startup time, external dependencies, LSP server presence, plugin load failures, notes vault directory, and the storyboard binary / clone status.

## Notes Vault

Vault path is defined in `lua/config/paths.lua` (default: `~/Documents/Sheymor`). Notes are plain markdown files managed with `snacks.picker` and custom helpers in `lua/function-keymaps.lua`. The health check verifies vault accessibility. Daily notes go under `daily/` and templates under `templates/`.

## Special Filetype Handling

- **C# files**: UTF-8 BOM is preserved (`vim.opt_local.bomb = true`) to prevent showing whole file as changed
- **Windows line endings**: Auto-converted to Unix on open (`:set fileformat=unix`)
- **Markdown**: `gf` is buffer-mapped to `follow_link` (see `lua/plugins-keymaps/notes-keymaps.lua`)
- **Per-filetype themes**: Auto-switched by `lua/config/filetype-theme.lua`:
  - `lua` → `ayu`
  - `go` → `onedark_dark`
  - `cs` → `gruvbox`
  - `html` → `tokyodark`
  - `css` → `gruvbox`
  - `javascript` / `typescript` → `onedark_dark`
- **BufEnter filter**: `lua/general-config.lua` skips prompt buffers (snacks picker/input), runs `filetype detect` when filetype is empty, and treesitter-restarts the buffer.
- **Snacks input auto-insert**: `lua/general-config/nvim.lua` auto-enters insert mode for `snacks_input` / `snacks_picker_input` file types.

## Formatting

- **Lua**: `stylua` (4-space indent, 100 col width)
- **Go**: `gofumpt` + `goimports`
- **C#**: `csharpier`
- **Web**: `prettier` (with spacious defaults: 4-tab, 120 width)
- **Format on save is DISABLED** — manual only via `<leader>mf` (async) or `<leader>mF` (sync)

## Git

- `lazy-lock.json` is **ignored** (not tracked). Users generate their own lockfile.
- `lua/config/dashboard-urls.lua` is gitignored (create from `dashboard-urls.example.lua`)
