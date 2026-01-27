# Colemak-DH

This guide explains the Colemak-DH layout implemented in this Neovim configuration and how to revert it to the standard Vim layout if you wish.

## 🎯 What is Colemak-DH?

Colemak-DH is a variant of the Colemak layout designed for greater ergonomics and comfort. In this Neovim configuration, it's specifically applied to navigation keys to reduce hand movement and improve speed.

## 📋 Current Implementation

### Basic Navigation Remapped
| Original Key | Colemak-DH Key | Function | File |
|--------------|----------------|----------|------|
| h | n | Move left | `lua/keymaps.lua:13` |
| j | e | Move down | `lua/keymaps.lua:14` |
| k | i | Move up | `lua/keymaps.lua:15` |
| l | o | Move right | `lua/keymaps.lua:16` |

### Visual Mode Navigation
| Original Key | Colemak-DH Key | Function | File |
|--------------|----------------|----------|------|
| H | N | Move left (visual) | `lua/keymaps.lua:18` |
| J | E | Move down (visual) | `lua/keymaps.lua:19` |
| K | I | Move up (visual) | `lua/keymaps.lua:20` |
| L | O | Move right (visual) | `lua/keymaps.lua:21` |

### Original Keys Deactivated
| Key | Status | File |
|-----|--------|------|
| h, j, k, l | Deactivated (`<nop>`) | `lua/keymaps.lua:24-27` |
| H, J, K, L | Deactivated (`<nop>`) | `lua/keymaps.lua:29-32` |

### Extended Navigation
| Key | Function | File |
|-----|----------|------|
| N | Start of line (`^`) | `lua/keymaps.lua:35` |
| O | End of line (`$`) | `lua/keymaps.lua:36` |
| E | Scroll down (`<C-d>`) | `lua/keymaps.lua:39` |
| I | Scroll up (`<C-u>`) | `lua/keymaps.lua:40` |

### Additional Remaps
| Key | Function | File |
|-----|----------|------|
| h | `o` (create line below) | `lua/keymaps.lua:42` |
| H | `O` (create line above) | `lua/keymaps.lua:43` |
| k | `i` (enter insert mode) | `lua/keymaps.lua:44` |

## 🔄 Complete Reversion Guide

### Step 1: Configuration Backup
```bash
# Create backup before modifying
cp -r ~/.config/nvim ~/.config/nvim-backup-$(date +%Y%m%d)
```

### Step 2: Revert Basic Navigation

**Edit `lua/keymaps.lua`:**

**Option A: Comment out Colemak-DH lines**
```lua
-- =========================
-- COLEMAK-DH MOVEMENT (COMMENTED)
-- =========================
-- map({ "n", "v" }, "n", "h") -- left
-- map({ "n", "v" }, "e", "j") -- down
-- map({ "n", "v" }, "i", "k") -- up
-- map({ "n", "v" }, "o", "l") -- right

-- map({ "n", "v" }, "N", "H")
-- map({ "n", "v" }, "E", "J") -- down
-- map({ "n", "v" }, "I", "K") -- up
-- map({ "n", "v" }, "O", "L") -- right

-- Deactivate originals (COMMENTED)
-- map({ "n", "v" }, "h", "<nop>")
-- map({ "n", "v" }, "j", "<nop>")
-- map({ "n", "v" }, "k", "<nop>")
-- map({ "n", "v" }, "l", "<nop>")

-- map({ "n", "v" }, "H", "<nop>")
-- map({ "n", "v" }, "J", "<nop>")
-- map({ "n", "v" }, "K", "<nop>")
-- map({ "n", "v" }, "L", "<nop>")
```

**Option B: Completely remove lines**
Remove lines 13-32 from `lua/keymaps.lua` file.

### Step 3: Revert Extended Navigation

**Comment out or remove these lines:**
```lua
-- Start / end of line (COMMENTED)
-- map({ "n", "v" }, "N", "^")
-- map({ "n", "v" }, "O", "$")

-- Comfortable scroll (COMMENTED)
-- map("n", "E", "<C-d>")
-- map("n", "I", "<C-u>")
```

### Step 4: Revert Additional Remaps

**Comment out or remove these lines:**
```lua
-- Additional remaps (COMMENTED)
-- map("n", "h", "o")
-- map("n", "H", "O")
-- map("n", "k", "i")
```

### Step 5: Verify LSP and Functions

**Review `lua/function-keymaps.lua`:**
Ensure LSP functions don't depend on Colemak-DH layout. Current functions use Snacks.picker and should work correctly.

### Step 6: Verify Plugins

**Review files in `lua/plugins-keymaps/`:**
- `harpoon2-keymaps.lua` - Doesn't use navigation keys
- `dap-keymaps.lua` - Uses function keys, not affected
- `lazygit-keymaps.lua` - Doesn't use navigation keys
- `yanky-keymaps.lua` - Uses standard p/P
- `telekasten-keymaps.lua` - Doesn't use navigation keys

### Step 7: Test Configuration

**Restart Neovim:**
```bash
nvim
```

**Basic tests:**
1. **Navigation**: Use h,j,k,l to move
2. **Visual mode**: Select with v and navigate with h,j,k,l
3. **LSP**: Test gd, K, . for LSP navigation
4. **Plugins**: Verify all plugins work

## 🎛️ Configuration Alternatives

### Option 1: Conditional Layout
Create a system that detects if you want to use Colemak-DH:

```lua
-- In init.lua
local use_colemak = vim.env.COLEMAK_DH == "1"

if use_colemak then
    require("colemak-keymaps")
else
    require("standard-keymaps")
end
```

### Option 2: Runtime Toggle
Create a command to switch between layouts:

```lua
-- In lua/config/colemak-toggle.lua
local M = {}

function M.toggle_colemak()
    local current = vim.g.colemak_enabled or false
    vim.g.colemak_enabled = not current
    
    if current then
        -- Deactivate Colemak-DH
        vim.cmd("lua require('standard-keymaps')")
    else
        -- Activate Colemak-DH
        vim.cmd("lua require('colemak-keymaps')")
    end
    
    vim.notify("Colemak-DH: " .. (vim.g.colemak_enabled and "ON" or "OFF"))
end

vim.api.nvim_create_user_command("ToggleColemak", M.toggle_colemak, {})

return M
```

### Option 3: Per-Project Configuration
Use environment variables or per-project configuration files:

```lua
-- In init.lua
local project_config = vim.fn.findfile(".nvimrc", ".;")
if project_config and vim.fn.filereadable(project_config) == 1 then
    vim.cmd("source " .. project_config)
end
```

## 🔧 Troubleshooting

### Common Issues

#### 1. Keys don't respond after reversion
```bash
# Restart Neovim completely
nvim --headless -c 'qa!'

# Or remove plugin directory and reinstall
rm -rf ~/.local/share/nvim/lazy
nvim
```

#### 2. LSP not working correctly
```bash
# Check LSP configuration
:LspInfo

# Restart LSP
:LspRestart
```

#### 3. Plugins with conflicting keymaps
```bash
# Check active keymaps
:verbose map h
:verbose map j
:verbose map k
:verbose map l
```

#### 4. Muscle memory conflicts
- Use Option 2 (Toggle) for gradual transition
- Practice with `vimtutor` to retrain
- Consider keeping Colemak-DH for a while

## 📚 Standard Keymap Reference

### Basic Vim Navigation
| Key | Function | Mode |
|-----|----------|------|
| h | Left | Normal, Visual |
| j | Down | Normal, Visual |
| k | Up | Normal, Visual |
| l | Right | Normal, Visual |
| H | Line up (screen) | Normal |
| M | Line middle (screen) | Normal |
| L | Line down (screen) | Normal |
| ^ | Start of line | Normal, Visual |
| $ | End of line | Normal, Visual |
| w | Next word | Normal |
| b | Previous word | Normal |
| e | End of word | Normal |
| gg | Start of file | Normal |
| G | End of file | Normal |

### Search and Navigation
| Key | Function | Mode |
|-----|----------|------|
| / | Search forward | Normal |
| ? | Search backward | Normal |
| n | Next match | Normal |
| N | Previous match | Normal |
| * | Search word under cursor | Normal |
| # | Search word under cursor (backward) | Normal |

## 🔄 Migration Strategies

### Gradual Transition
1. **Week 1**: Use standard layout for basic editing
2. **Week 2**: Try Colemak-DH for navigation only
3. **Week 3**: Full Colemak-DH usage
4. **Week 4**: Evaluate and decide

### Hybrid Approach
- Keep Colemak-DH for navigation
- Use standard layout for other operations
- Customize based on preference

### Project-Based
- Use Colemak-DH for personal projects
- Use standard layout for team projects
- Switch based on context

## 📋 Quick Reference

### Quick Summary

**To revert Colemak-DH:**
1. Backup: `cp -r ~/.config/nvim ~/.config/nvim-backup`
2. Edit `lua/keymaps.lua`: comment lines 13-32, 35-36, 39-40, 42-44
3. Restart Neovim
4. Test navigation with h,j,k,l

**To keep Colemak-DH:**
- Navigation: n,e,i,o (left, down, up, right)
- Scroll: E/I (down/up)
- Line: N/O (start/end)

## 🌐 Languages

- 🇺🇸 **English**: This documentation
- 🇪🇸 **Español**: [Guía de Colemak-DH en Español](../es/colemak-dh.md)

---

## 🎯 Final Recommendations

1. **Test before deciding**: Use the current configuration for at least one week
2. **Consider the toggle**: Option 2 allows dynamic switching
3. **Keep the backup**: Always have a working configuration backup
4. **Customize for your workflow**: Adapt the configuration to your specific needs

---

*This guide provides you with all necessary options to customize your Neovim navigation experience according to your preferences.*