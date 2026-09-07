# Agent Guide

## Boot Flow

- `init.lua` sets global options and dispatches to `lua/init/nvim.lua` for standalone Neovim or `lua/init/nvim_vscode.lua` when `vim.g.vscode` is set.
- Both entrypoints load `config.lazy`, `general-config`, `function-keymaps`, and `keymaps`; standalone Neovim also loads `general-config.nvim` and the deferred `User VeryLazy` modules.
- Lazy.nvim discovers plugin specs under `lua/plugins/`. In VS Code mode, `lua/config/lazy.lua` scans those specs and filters them through `lua/nvim_vscode/init.lua`'s `disabled_plugins` table.
- Keep plugin specifications, setup code, and plugin-specific keymaps separated as `lua/plugins/*.lua`, `lua/config/*.lua`, and `lua/plugins-keymaps/*.lua`. Register new plugin keymaps from the appropriate environment keymap module.

## Keymap Constraints

- The config uses Colemak-DH: normal/visual movement is `n` left, `e` down, `i` up, and `o` right; `h`, `j`, `k`, and `l` are disabled. Do not use these movement keys or their uppercase forms in leader sequences.
- Put non-trivial mapping behavior in `lua/function-keymaps.lua` and expose it through the module table; keep keymap files declarative.
- Avoid ambiguous leader chains that require a buffer key after an asynchronous picker. Follow the existing split-key pattern in `lua/plugins-keymaps/fzf-lua-keymaps.lua`.

## LSP Changes

- This does not use `nvim-lspconfig` for its main LSP pipeline. Add or remove servers in `lua/lsp/servers.lua`, and keep each server's implementation in its `lua/lsp/*.lua` module.
- `lua/lsp/setup.lua` registers `FileType` startup and delegates `LspAttach` behavior to `lua/lsp/on_attach.lua`; use `:LspReload` or `:DevReload` after changes.
- C# is the exception: Roslyn is configured by `lua/plugins/roslyn.lua`, not the custom registry. VS Code mode delegates language services to VS Code.

## Verification

- There is no repository build or test manifest. For a Lua change, source the file with `:luafile %`; use `:DevReload` for LSP changes and `:checkhealth` for dependency/plugin health.
- `:StartupTime`, `:SlowPlugins`, and `:PluginHealth` are available for startup/plugin diagnostics.
- Format manually; format-on-save is disabled. Conform maps Lua to `stylua`, Go to `gofumpt` then `goimports`, C# to `csharpier`, web/Markdown/YAML/JSON to `prettier`, Python to `black`, and shell to `shfmt`. Use `<leader>mf` or `<leader>mF` for async or sync formatting.
- Match formatter settings in `lua/plugins/conform.lua` when changing formatting behavior: Lua uses 4-space/100-column, Black uses 100 characters, shell uses 4-space indentation, and Prettier uses repo-configured settings or 4-space/120-column defaults.

## External State

- `git` is required. Mason installs most language servers and DAP adapters; `gopls`, `gofumpt`, and `goimports` are expected system/Go-installed tools. `blink.cmp` may require Rust/Cargo during installation.
- The optional Storyboard integration in `lua/config/storyboard.lua` clones `DiaProject` into `vim.fn.stdpath("data") .. "/storyboard"`, builds it with `go`, and uses `curl` plus `python3` to run/check it.
- Dadbod connection data is stored outside the repo under `~/.local/share/nvim/dadbod_ui/`; Oracle URLs additionally require the `sqlplus` executable and Oracle environment variables.
- The notes vault defaults to `~/Documents/Sheymor` (`lua/config/paths.lua`). `lua/config/dashboard-urls.lua` is local-only; edit the example file when documenting dashboard URL changes.
- `lazy-lock.json` is intentionally ignored and local to each installation; do not add it to a change just because Lazy regenerates it.

## Style

- Preserve the existing 4-space Lua formatting and ASCII-default style. Follow the surrounding module structure instead of adding a new abstraction for a one-off behavior.
