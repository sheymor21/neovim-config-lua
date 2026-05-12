# Agent Guide for Neovim Configuration

## Architecture

**Entry point**: `init.lua` - sets core vim options, then loads:
1. `lsp/on_attach.lua` - LSP handlers
2. `config/lazy.lua` - Plugin manager bootstrap
3. `general-config.lua` - Autocmds, diagnostics, folding
4. `function-keymaps.lua` - Utility functions
5. `keymaps.lua` - Keymaps (imports plugin keymaps)

**Directory structure**:
- `lua/plugins/` - Plugin specs (return lazy.nvim spec tables)
- `lua/config/` - Plugin setup/config logic (deferred modules for VeryLazy too)
- `lua/plugins-keymaps/` - Keymap definitions per plugin
- `lua/lsp/` - LSP server configurations
- `lua/plugins-off/` - Disabled plugins (not loaded by lazy)
- `docs/en/`, `docs/es/` - Bilingual documentation

## Critical Conventions

### Colemak-DH Layout (ALWAYS RESPECT)
The config remaps movement keys to Colemak-DH. **When defining new keymaps**:
- `n` = left (was `h`)
- `e` = down (was `j`)
- `i` = up (was `k`)
- `o` = right (was `l`)
- Original h/j/k/l are disabled (`<nop>`)
- `h` now opens line below, `k` enters insert mode

**Safe keys for leader combinations**: Everything except n, e, i, o and their uppercase variants.

### Plugin Loading Pattern
Plugins use lazy.nvim with structured separation:
```lua
-- lua/plugins/foo.lua - the spec
return {
    "author/plugin",
    config = function()
        require("config.foo") -- setup logic
    end,
}

-- lua/config/foo.lua - the setup
require("plugin").setup({...})

-- lua/plugins-keymaps/foo-keymaps.lua - keymaps
local map = vim.keymap.set
map("n", "<leader>xx", ...)
```

### Startup Defer Pattern
Non-critical modules load on `VeryLazy` event (see `init.lua` lines 33-54). Add new deferred modules there.

### Keymap Behavior Functions
Complex keymap logic goes in `function-keymaps.lua`, wrapped in the `M` table, then referenced in keymaps.

## Primary Tools

- **File finder**: fzf-lua (`<leader>ff`, `<leader>fb`, `<leader>sg`)
- **File manager**: Oil.nvim (`<leader>e`, `-` for parent dir)
- **Bookmarks**: Grapple (`<leader>aa`, `<C-1>` to `<C-4>`)
- **Git**: Snacks.lazygit (`<leader>ig`)
- **Notes**: Telekasten (`<leader>zp`, `<leader>zf`)
- **Picker/Recent**: Snacks.picker (`<leader>fr`)

## Commands

| Command | Purpose |
|---------|---------|
| `:checkhealth` | Run health check (see `lua/health.lua`) |
| `:StartupTime` | Show startup performance |
| `:SlowPlugins` | Show slow-loading plugins |
| `:DevReload` | Full reload LSP & CMP |
| `:LspReload` | Reload LSP only |
| `:CmpReload` | Reload CMP only |
| `:Lazy` | Plugin manager |
| `:Mason` | LSP server installer |

## Testing Changes

1. Edit a Lua file
2. Run `:luafile %` (or `<leader>W`) to source current file
3. Run `:DevReload` if LSP/CMP affected
4. Run `:checkhealth` to verify health

## LSP Servers

Configured servers (in `lua/lsp/`):
- `gopls` - Go (requires system install)
- `vtsls` - TypeScript (via Mason)
- `lua_ls` - Lua (via Mason + lazydev)
- `roslyn` - C# (special plugin, not Mason)
- `html`, `cssls` - Web (via Mason)
- `markdown` - Markdown (via Mason)

## External Dependencies

Optional: `node`, `npm`, `deno`, `go`, `python3`, `dotnet`, `cargo`
Required: `git`

## Health Check System

`lua/health.lua` provides `:checkhealth` integration. Add new checks there following the existing pattern with `vim.health.ok/warn/error`.

## Lockfile

`lazy-lock.json` is committed for reproducible builds. Update with `:Lazy sync` or `:Lazy update`.

## Notes/Telekasten Vault

Vault path is defined in `lua/config/paths.lua` (default: `~/Documents/Sheymor`). The health check verifies vault accessibility.
