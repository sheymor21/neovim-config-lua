# Agent Guide for Neovim Configuration

## Architecture

**Entry point**: `init.lua` - sets core vim options (tabstop=4, expandtab, relativenumber, etc.), then branches to:
1. `lua/init/nvim.lua` - Standalone Neovim init
2. `lua/init/nvim_vscode.lua` - VS Code: init

Both load: `config/lazy.lua` → `general-config.lua` → `function-keymaps.lua` → `keymaps.lua`

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

**Deferred loading**: Non-critical modules load on `User VeryLazy` event in `lua/init/nvim.lua`. Add new deferred modules there.

**VS Code mode**: `vim.g.vscode` triggers `lua/init/nvim_vscode.lua`. The `nvim_vscode` module (not in this repo) provides a `disabled_plugins` list that filters the plugin specs dynamically.

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

**Important**: `lua/lsp/on_attach.lua` disables semantic tokens for ALL clients:
```lua
client.server_capabilities.semanticTokensProvider = nil
```

Configured servers (in `lua/lsp/servers.lua` + `lua/lsp/setup.lua`):
- `gopls` - Go (requires system install)
- `vtsls` - TypeScript (via Mason)
- `lua_ls` - Lua (via Mason + lazydev)
- `html`, `cssls` - Web (via Mason)
- `marksman` - Markdown (via Mason)

**Exception**: `roslyn` (C#) is handled by `seblyng/roslyn.nvim` in `lua/plugins/roslyn.lua`, NOT the custom LSP setup.

## Primary Tools

| Tool | Plugin | Keymaps |
|------|--------|---------|
| File finder | fzf-lua | `<leader>ff`, `<leader>fb`, `<leader>sg` |
| File manager | Oil.nvim | `<leader>e`, `-` for parent dir |
| Bookmarks | Grapple | `<leader>aa`, `<C-1>` to `<C-4>` |
| Git | Snacks.lazygit | `<leader>ig` |
| Notes | Markdown notes + snacks.picker | `<leader>on`, `<leader>od`, `<leader>of` |
| Picker | Snacks.picker | `<leader>fr`, `<leader>sm`, `<leader>sh` |
| Completion | blink.cmp | Tab, S-Tab, C-j, C-k |
| Terminal | Snacks.terminal | `<leader>tt` |
| Dashboard | Snacks.dashboard | Shows on startup |

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

## External Dependencies

Optional: `node`, `npm`, `deno`, `go`, `python3`, `dotnet`, `cargo` (required for blink.cmp build)
Required: `git`

## Health Check System

`lua/health.lua` provides `:checkhealth` integration. Add new checks there following the existing pattern with `vim.health.ok/warn/error`.

## Notes Vault

Vault path is defined in `lua/config/paths.lua` (default: `~/Documents/Sheymor`). Notes are plain markdown files managed with `snacks.picker` and custom helpers in `lua/function-keymaps.lua`. The health check verifies vault accessibility.

## Special Filetype Handling

- **C# files**: UTF-8 BOM is preserved (`vim.opt_local.bomb = true`) to prevent showing whole file as changed
- **Windows line endings**: Auto-converted to Unix on open (`:set fileformat=unix`)
- **Per-filetype themes**: Auto-switched by `lua/config/filetype-theme.lua`:
  - `lua` → `ayu`
  - `go` → `onedark_dark`
  - `cs` → `gruvbox`
  - `html` → `tokyodark`
  - `css` → `gruvbox`
  - `javascript` / `typescript` → `onedark_dark`

## Formatting

- **Lua**: `stylua` (4-space indent, 100 col width)
- **Go**: `gofumpt` + `goimports`
- **C#**: `csharpier`
- **Web**: `prettier` (with spacious defaults: 4-tab, 120 width)
- **Format on save is DISABLED** — manual only via `<leader>mf` (async) or `<leader>mF` (sync)

## Git

- `lazy-lock.json` is **ignored** (not tracked). Users generate their own lockfile.
- `lua/config/dashboard-urls.lua` is gitignored (create from `dashboard-urls.example.lua`)
