# Configuration

This guide covers the general Neovim configuration, including basic options, LSP configurations, and key customization aspects.

## 📁 File Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── README.md                   # Dependencies documentation
├── LICENSE                     # MIT License
├── lazy-lock.json              # Plugin version lockfile
└── lua/
    ├── general-config.lua      # General settings and autocmds
    ├── keymaps.lua             # Global keybindings
    ├── function-keymaps.lua    # Custom functions and LSP keymaps
    ├── config/                 # Configuration modules
    │   ├── theme.lua           # Theme system
    │   ├── filetype-theme.lua  # Filetype-specific themes
    │   ├── lazy.lua            # Lazy.nvim setup
    │   ├── dap-config.lua      # DAP configuration
    │   ├── lazygit.lua         # LazyGit configuration
    │   ├── lazy-docker.lua     # LazyDocker configuration
    │   ├── indent.lua          # Indentation settings
    │   ├── neo-tree.lua        # Neo-tree configuration
    │   ├── highlight-%.lua     # Highlight configuration
    │   └── telekasten-config.lua # Telekasten configuration
    ├── plugins/                # Plugin specifications
    │   ├── telescope.lua       # Telescope configuration
    │   ├── treesitter.lua      # Treesitter configuration
    │   ├── nvim-cmp.lua        # Autocompletion
    │   ├── neotree.lua         # File explorer
    │   ├── harpoon2.lua        # Navigation bookmarks
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
    │   ├── trouble.lua         # Diagnostics display
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
    │   ├── vim-multicursor.lua # Multiple cursors
    │   ├── neotest.lua         # Testing framework
    │   ├── dap-ui.lua          # Debug UI
    │   ├── overseer.lua        # Task runner
    │   ├── neovim-session-manager.lua # Session management
    │   ├── projects.lua        # Project management
    │   ├── dressing.lua        # UI enhancement
    │   ├── lazydev.lua         # Lua development
    │   ├── configurationless.lua # Utility functions
    │   └── windows-picker.lua  # Window selection
    ├── plugins-keymaps/        # Plugin-specific keymaps
    │   ├── harpoon2-keymaps.lua
    │   ├── lazygit-keymaps.lua
    │   ├── lazydocker-keymaps.lua
    │   ├── dap-keymaps.lua
    │   ├── yanky-keymaps.lua
    │   ├── telekasten-keymaps.lua
    │   ├── conform-keymaps.lua
    │   └── vim-multicursor-keymaps.lua
    └── lsp/                    # Language Server configurations
        ├── gopls.lua           # Go language server
        ├── vtsls.lua           # TypeScript/JavaScript LSP
        ├── lua-lsp.lua         # Lua language server
        ├── html.lua            # HTML LSP
        ├── css.lua             # CSS LSP
        ├── markdown.lua        # Markdown LSP
        └── omnisharp.lua       # C# language server
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

**Auto-close Neo-tree**
```lua
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        if ft ~= "neo-tree" and ft ~= "neo-tree-popup" then
            pcall(vim.cmd, "Neotree close")
        end
    end,
})
```

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
        local cwd = vim.loop.cwd()
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
_G.lsp_on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    
    -- Disable semantic tokens if not needed
    client.server_capabilities.semanticTokensProvider = nil
    
    -- LSP navigation keybindings
    map("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)
    map("n", "gD", function() Snacks.picker.lsp_references() end, opts)
    map("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)
    map("n", "gt", function() Snacks.picker.lsp_type_definitions() end, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", ".", vim.lsp.buf.code_action, opts)
    map("v", ".", vim.lsp.buf.code_action, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end
```

### Language-specific Configurations

**Go (lsp/gopls.lua)**
- Uses system gopls (not Mason)
- Optimized for Go development

**TypeScript/JavaScript (lsp/vtsls.lua)**
- vtsls via Mason
- Configuration for modern TS/JS projects

**C# (lsp/omnisharp.lua)**
- OmniSharp via Mason
- .NET SDK integration

**Lua (lsp/lua-lsp.lua)**
- lua-language-server with lazydev.nvim
- Optimized for Neovim config development

## 🛠️ Plugin Configuration

### Lazy.nvim (config/lazy.lua)
```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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

**Telescope (plugins/telescope.lua)**
- Extensions: file_browser, live_grep, neovim-project
- Integration with snacks.picker

**Treesitter (plugins/treesitter.lua)**
- Highlight for multiple languages
- Auto-install of parsers

**nvim-cmp (plugins/nvim-cmp.lua)**
- Sources: LSP, buffer, path, luasnip
- Behavior and appearance configuration

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
function M.run_project()
    local ext = vim.fn.expand("%:e")
    local file = vim.fn.expand("%:p")
    local cmd
    
    if ext == "cs" then
        cmd = "dotnet run"
    elseif ext == "ts" or ext == "js" then
        if vim.fn.filereadable("bun.lock") == 1 then
            cmd = "bun run dev"
        elseif vim.fn.filereadable("package.json") == 1 then
            cmd = "npm start"
        else
            cmd = "node " .. file
        end
    elseif ext == "go" then
        cmd = "go run " .. file
    -- ... more languages
    end
    
    runner.cmd = cmd
    runner:toggle()
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