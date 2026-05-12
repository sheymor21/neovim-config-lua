# Configuration

This guide covers the general Neovim configuration, including basic options, LSP configurations, and key customization aspects.

## 📁 File Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point (branches to init/nvim or init/nvim_vscode)
├── README.md                   # Dependencies documentation
├── LICENSE                     # MIT License
├── lazy-lock.json              # Plugin version lockfile
└── lua/
    ├── init/                   # Environment entry points
    │   ├── nvim.lua            # Standalone Neovim init
    │   └── nvim_vscode.lua     # VS Code: init
    ├── general-config.lua      # Shared autocmds and settings
    ├── general-config/         # Environment-specific configurations
    │   └── nvim.lua            # Nvim-only autocmds
    ├── keymaps.lua             # Keymaps entry (branches to keymaps/nvim or keymaps/nvim_vscode)
    ├── keymaps/                # Keymap modules
    │   ├── core.lua            # Shared keymaps (Colemak, basics, flash)
    │   ├── nvim.lua            # Nvim-only keymaps
    │   └── nvim_vscode.lua     # VS Code: keymaps
    ├── function-keymaps.lua    # Custom functions and LSP keymaps
    ├── health.lua              # Health checks
    ├── utils.lua               # Utility functions
    ├── config/                 # Configuration modules
    │   ├── theme.lua           # Theme system
    │   ├── filetype-theme.lua  # Filetype-specific themes
    │   ├── lazy.lua            # Lazy.nvim setup
    │   ├── dap-config.lua      # DAP configuration
    │   ├── lazygit.lua         # LazyGit configuration
    │   ├── lazy-docker.lua     # LazyDocker configuration
    │   ├── indent.lua          # Indentation settings
    │   ├── telekasten-config.lua # Telekasten configuration
    │   ├── csharp-accessors.lua # C# accessors
    │   ├── csharp-editorconfig.lua # C# editorconfig
    │   ├── plugin-health.lua   # Plugin health checks
    │   ├── profiler.lua        # Performance profiler
    │   ├── reloader.lua        # Config reloader
    ├── plugins/                # Plugin specifications
    │   ├── 99.lua              # Core plugins loader
    │   ├── telescope.lua       # Telescope configuration
    │   ├── fzf-lua.lua         # Fzf-lua configuration
    │   ├── treesitter.lua      # Treesitter configuration
    │   ├── blink-cmp.lua       # Autocompletion (blink.cmp)
    │   ├── grapple.lua         # Navigation bookmarks
    │   ├── conform.lua         # Code formatting
    │   ├── aerial.lua          # Symbol outline
    │   ├── lualine.lua         # Status line
    │   ├── toggle-term.lua     # Terminal management
    │   ├── which-key.lua       # Keybinding help
    │   ├── gitsigns.lua        # Git integration
    │   ├── noice.lua           # UI notifications
    │   ├── snacks.lua          # Snacks.nvim features
    │   ├── flash.lua           # Quick navigation
    │   ├── undotree.lua        # Undo visualization
    │   ├── surround.lua        # Surrounding text objects
    │   ├── autopairs.lua       # Auto bracket completion
    │   ├── indent.lua          # Indentation guides
    │   ├── oil.lua             # File system editing
    │   ├── yanky.lua           # Enhanced yank/paste
    │   ├── luasnipet.lua       # Snippets
    │   ├── cellular.lua        # Visual effects
    │   ├── faster.lua          # Performance optimization
    │   ├── colors.lua          # Color schemes
    │   ├── markdown-render.lua # Markdown rendering
    │   ├── multicursor.lua     # Multiple cursors
    │   ├── neotest.lua         # Testing framework
    │   ├── dap-ui.lua          # Debug UI
    │   ├── neovim-session-manager.lua # Session management
    │   ├── projects.lua        # Project management
    │   ├── lazydev.lua         # Lua development
    │   ├── configurationless.lua # Utility functions
    │   ├── windows-picker.lua  # Window selection
    │   ├── mini-nvim.lua       # Mini.nvim suite
    │   ├── roslyn.lua          # Roslyn LSP
    │   ├── unirunner.lua       # Unified runner
    │   ├── unipackage.lua      # Package manager
    │   ├── unidiagnostic.lua   # Diagnostic management
    │   ├── wakatime.lua        # Wakatime integration
    │   ├── telekasten.lua      # Zettelkasten notes
    │   ├── reloader.lua        # Config reloader
    │   └── nvim-web-devicons.lua # File icons
    ├── nvim_vscode/            # VS Code compatibility layer
    │   └── init.lua            # Detection & plugin filtering
    ├── plugins-off/            # Disabled plugins
    │   ├── alpha.lua
    │   ├── dressing.lua
    │   ├── overseer.lua
    │   └── sessions.lua
    ├── plugins-keymaps/        # Plugin-specific keymaps
    │   ├── 99-keymaps.lua
    │   ├── grapple-keymaps.lua
    │   ├── snacks-keymaps.lua
    │   ├── lazydocker-keymaps.lua
    │   ├── dap-keymaps.lua
    │   ├── yanky-keymaps.lua
    │   ├── telekasten-keymaps.lua
    │   ├── conform-keymaps.lua
    │   ├── fzf-lua-keymaps.lua
    │   ├── snacks-keymaps.lua
    │   └── grapple-keymaps.lua
    └── lsp/                    # Language Server configurations
        ├── gopls.lua           # Go language server
        ├── vtsls.lua           # TypeScript/JavaScript LSP
        ├── lua-lsp.lua         # Lua language server
        ├── html.lua            # HTML LSP
        ├── css.lua             # CSS LSP
        ├── markdown.lua        # Markdown LSP
        ├── on_attach.lua       # LSP attach function
        └── utils.lua           # LSP utilities
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
vim.opt.smartindent = true

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
```

### Autocommands (general-config.lua)

**Highlight on yank**
```lua
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 200,
        })
    end,
})
```

**Tree-sitter re-attach**
```lua
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft ~= "" then
            pcall(vim.treesitter.start, args.buf)
        end
    end,
})
```

**Buffer cleanup on directory change**
```lua
vim.api.nvim_create_autocmd("DirChanged", {
    desc = "Clean buffers outside current project",
    callback = function()
        local cwd = vim.uv.cwd()
        -- Buffer cleanup logic
    end,
})
```

## 🎨 Theme System

### Theme Configuration (config/theme.lua)
- **Default theme**: Kanagawa
- **Available themes**: Catppuccin, Gruvbox, Onedark, Cyberdream
- **Dynamic switching**: Commands to change themes on the fly

### Filetype-specific Themes (config/filetype-theme.lua)
- Theme configuration based on file type
- Optimization for different languages

## 🔧 LSP Configuration

### General Attach Function
```lua
local function lsp_on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local map = vim.keymap.set

    client.server_capabilities.semanticTokensProvider = nil

    map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
    map("n", "gD", Snacks.picker.lsp_references, { buffer = bufnr, desc = "Go to Declaration" })
    map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Implementation" })
    map("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
    map("n", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
end
```

### Language-specific Configurations

**Go (lsp/gopls.lua)**
- Uses system gopls (not Mason)
- Optimized for Go development

**TypeScript/JavaScript (lsp/vtsls.lua)**
- vtsls via Mason
- Configuration for modern TS/JS projects

**C# (plugins/roslyn.lua)**
- Roslyn.nvim - official Microsoft C# LSP
- CSharpier formatting support
- .NET SDK integration

**Lua (lsp/lua-lsp.lua)**
- lua-language-server with lazydev.nvim
- Optimized for Neovim config development

## 🛠️ Plugin Configuration

### Lazy.nvim (config/lazy.lua)
```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
```

### Notable Configurations

**blink.cmp (plugins/blink-cmp.lua)**
- Sources: LSP, lazydev, snippets, buffer, path
- Rust-powered fuzzy matching
- Command-line completion
- Signature help with parameter hints
- LuaSnip integration

**Telescope (plugins/telescope.lua)**
- Extensions: file_browser, live_grep, neovim-project
- Integration with snacks.picker

**fzf-lua (plugins/fzf-lua.lua)**
- Fast fuzzy finding with native fzf performance
- File, buffer, grep, and symbol pickers
- Horizontal preview layout

**Treesitter (plugins/treesitter.lua)**
- Highlight for multiple languages
- Auto-install of parsers

**DAP (config/dap-config.lua)**
- Support for Go, TypeScript/JavaScript, C#
- Adapter and configuration setup

## 🎯 Custom Functions

### Utility Functions (function-keymaps.lua)

**Smart Punctuation Insertion**
```lua
function M.add_dot()
    local line = vim.api.nvim_get_current_line()
    if line:match(";%s*$") then
        return
    end
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A;")
    vim.api.nvim_win_set_cursor(0, pos)
end
```

**Project Runner**
```lua
function M.runner_run()
    require("unirunner").run()
end

function M.runner_select_run()
    require("unirunner").run_select()
end
```

**Note Search**
```lua
function M.search_notes()
    require("telescope.builtin").grep_string({
        search = "- [ ]",
        cwd = vim.fn.expand("~/notes"),
        prompt_title = "Pending tasks",
    })
end
```

**Jump to Line**
```lua
function M.jump_to_line()
    local line_count = vim.api.nvim_buf_line_count(0)
    local line = vim.fn.input("Jump to line (1-" .. line_count .. "): ")
    if line and line ~= "" then
        local num = tonumber((line:gsub("%D", "")))
        if num then
            if num >= 1 and num <= line_count then
                vim.api.nvim_win_set_cursor(0, { num, 0 })
            else
                vim.notify("Line out of range (1-" .. line_count .. ")", vim.log.levels.WARN)
            end
        else
            vim.notify("Invalid line number", vim.log.levels.WARN)
        end
    end
end
```

## 📊 Diagnostic Configuration

```lua
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        spacing = 2,
        severity = {
            min = vim.diagnostic.severity.ERROR,
        },
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
```

## 🔄 Performance Configuration

### Lazy Loading
- On-demand plugin loading
- Event-driven configuration
- Startup time optimization

### Buffer Management
- Automatic buffer cleanup
- Tree-sitter auto-reattachment
- Smart garbage collection

## 🔧 Customization Guide

### Adding New Plugins
1. Create file in `lua/plugins/`
2. Configure with `require("lazy").setup()`
3. Add keymaps in `lua/plugins-keymaps/`

### Modifying LSPs
1. Edit files in `lua/lsp/`
2. Update `lsp_on_attach` if needed
3. Restart Neovim or run `:LspRestart`

### Changing Themes
1. Modify `lua/config/theme.lua`
2. Add new themes in `lua/plugins/colors.lua`

## 🌐 Languages

- 🇺🇸 **English**: This documentation
- 🇪🇸 **Español**: [Configuración en Español](../es/configuracion.md)

## 📚 Additional Resources

- [Neovim Lua API](https://neovim.io/doc/user/lua.html)
- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig)

---

*This configuration is designed to be modular and easy to customize. Feel free to adapt it to your specific needs.*
