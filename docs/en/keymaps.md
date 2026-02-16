# Keybindings

This reference guide covers all main keybindings configured in this Neovim distribution, including optimized Colemak-DH layout.

## 🎯 Colemak-DH Layout

This configuration uses the Colemak-DH layout for more ergonomic navigation:

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
| H | N | Move left (visual) |
| J | E | Move down (visual) |
| K | I | Move up (visual) |
| L | O | Move right (visual) |

### Extended Navigation
| Key | Function |
|-----|----------|
| N | Start of line |
| O | End of line |
| E | Scroll down (Ctrl+d) |
| I | Scroll up (Ctrl+u) |

## 🔧 System Keybindings

### Files and Management
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>w` | `:w<CR>` | Save file |
| `<leader>q` | `:q<CR>` | Close file |
| `<leader>W` | `:luafile %<CR>` | Execute current Lua file |

### Find (Telescope)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>ff` | Telescope find_files | Find files |
| `<leader>fb` | Telescope buffers | List buffers |
| `<leader>fr` | Telescope oldfiles | Recent files |
| `<leader>fp` | Telescope neovim-project history | Project history |
| `<leader>fP` | Telescope neovim-project discover | Discover projects |

### Search
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>sg` | Telescope live_grep | Search text in files |
| `<leader>ss` | Telescope aerial | Search symbols |
| `<leader>sa` | AerialToggle | Toggle symbols outline |

### Navigation
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>e` | `:Neotree toggle<CR>` | Toggle Neo-tree |
| `<leader>E` | `:Neotree reveal_force_cwd<CR>` | Open Neo-tree in current path |
| `<leader>iwp` | window_picker() | Pick window |
| `-` | Oil | Open parent directory |

### Terminal and Execution
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>tt` | ToggleTerm | Toggle floating terminal |
| `<leader>cn` | run_project() | Run project by filetype |
| `<leader>ck` | runner_cancel() | Cancel running project |
| `<leader>cN` | runner_select_run() | Select and run project |
| `<leader>cc` | runner_config() | Add runner config |
| `<leader>ch` | runner_history() | Show runner history |
| `<leader>iwt` | runner_go_terminal() | Go to runner terminal |

### Smart Functions
| Keybinding | Function | Description |
|------------|----------|-------------|
| `;` | add_dot() | Smart `;` insertion at EOL |
| `,` | add_coma() | Smart `,` insertion at EOL |

## 🎨 Plugin Keybindings

### Harpoon 2.0
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>a` | harpoon:list():add() | Add current file |
| `<leader>h` | harpoon:toggle_quick_menu() | Quick bookmarks menu |
| `<C-1>` | harpoon:list():select(1) | Go to bookmark 1 |
| `<C-2>` | harpoon:list():select(2) | Go to bookmark 2 |
| `<C-3>` | harpoon:list():select(3) | Go to bookmark 3 |
| `<C-4>` | harpoon:list():select(4) | Go to bookmark 4 |
| `<leader>F` | telescope harpoon marks | Search bookmarks with Telescope |

### Multicursor (jake-stewart/multicursor.nvim)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<C-n>` | mc_add_cursor_next() | Add cursor at next match |
| `<C-p>` | mc_add_cursor_prev() | Add cursor at previous match |
| `<leader>ma` | mc_match_all_cursors() | Add cursor to all matches |
| `<esc>` | mc_clear_or_enable_cursors() | Clear all cursors |

### Flash (folke/flash.nvim)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `f` | flash_jump() | Flash jump to character |
| `F` | flash_treesitter() | Flash treesitter node |

### Aerial (stevearc/aerial.nvim)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `{` | AerialPrev | Previous aerial symbol |
| `}` | AerialNext | Next aerial symbol |

### Debug Adapter Protocol (DAP)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<F5>` | dap.continue() | Start/continue debugging |
| `<F10>` | dap.step_over() | Step over |
| `<F11>` | dap.step_into() | Step into |
| `<F12>` | dap.step_out() | Step out |
| `<leader>ib` | toggle_breakpoint_or_debugger() | Toggle breakpoint |
| `<leader>iB` | dap.set_breakpoint() | Conditional breakpoint |
| `<leader>dr` | dap.repl.open() | Open REPL |
| `<leader>du` | dapui.toggle() | Toggle debugging UI |
| `<leader>dx` | dap.terminate() | Terminate debugging |

### Integration (LazyGit & LazyDocker)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>ig` | lazygit | Open LazyGit |
| `<leader>id` | lazydocker | Open LazyDocker |

### Markdown
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>mp` | toggle_peek_preview() | Toggle markdown preview |

### Telekasten (Notes)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>zn` | telekasten.new_note() | New note |
| `<leader>zf` | telekasten.find_notes() | Find notes |
| `<leader>zg` | telekasten.search_notes() | Search in notes |
| `<leader>zd` | telekasten.goto_today() | Go to today's note |
| `<leader>zp` | telekasten.panel() | Open notes panel |
| `<leader>zv` | telekasten.switch_vault() | Switch vault |

### Yanky (Yank/Paste)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `p` | yanky.put() | Paste after |
| `P` | yanky.put() | Paste before |
| `]p` | yanky.put() | Paste with indentation |
| `[p` | yanky.put() | Paste with indentation (before) |
| `>p` | yanky.put() | Cycle forward in history |
| `<p` | yanky.put() | Cycle backward in history |
| `<leader>yh` | yank_history | Yank history with Telescope |
| `<leader>yw` | ysiw | Surround word shortcut |

### Trouble (folke/trouble.nvim)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>isp` | Trouble diagnostics toggle | Toggle diagnostics panel |

### Undotree (mbbill/undotree)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>u` | UndotreeToggle | Toggle undo tree |

### Cellular Automaton (eandrju/cellular-automaton.nvim)
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>!` | CellularAutomaton make_it_rain | Make it rain |

## 📝 LSP Keybindings

### LSP Navigation
| Keybinding | Function | Description |
|------------|----------|-------------|
| `gd` | snacks.picker.lsp_definitions() | Go to definition |
| `gD` | snacks.picker.lsp_references() | See references |
| `gi` | snacks.picker.lsp_implementations() | Go to implementation |
| `gt` | snacks.picker.lsp_type_definitions() | Go to type definition |
| `K` | vim.lsp.buf.hover() | Hover documentation |
| `.` | vim.lsp.buf.code_action() | Code actions |
| `<leader>rn` | vim.lsp.buf.rename() | Rename symbol |
| `<leader>ca` | vim.lsp.buf.code_action() | Code action |
| `<leader>cl` | vim.lsp.codelens.run() | Run CodeLens |

### LSP Diagnostics
| Keybinding | Function | Description |
|------------|----------|-------------|
| `[d` | vim.diagnostic.goto_prev() | Go to previous diagnostic |
| `]d` | vim.diagnostic.goto_next() | Go to next diagnostic |
| `<leader>td` | toggle_diagnostics_display() | Toggle virtual text/lines |

### LSP Features
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>th` | toggle_inlay_hints() | Toggle inlay hints |

## 🧪 Testing Keybindings

### Neotest
| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>iur` | neotest.run.run() | Run test |
| `<leader>iuR` | neotest.run.run({suite = true}) | Run all tests |
| `<leader>ius` | neotest.summary.toggle() | Toggle test summary |
| `<leader>iud` | neotest.run.run({strategy = "dap"}) | Debug test |

## 📋 Notes & Tasks

| Keybinding | Function | Description |
|------------|----------|-------------|
| `<leader>it` | search_notes() | Search pending tasks in notes |
| `<leader>ip` | unipackage_menu() | Unipackage menu |

## 🔄 Colemak-DH Reversion

To revert to the standard Vim layout, see the [colemak-dh.md](colemak-dh.md) guide.

## 📚 Quick Reference

### Most Used Shortcuts
- **Navigation**: n,e,i,o (left, down, up, right)
- **Files**: `<leader>ff` (find), `<leader>w` (save)
- **LSP**: `gd` (definition), `K` (documentation), `<leader>th` (inlay hints)
- **Git**: `<leader>ig` (LazyGit)
- **Testing**: `<leader>iur` (run tests)
- **Search**: `<leader>sg` (live grep), `<leader>ss` (symbols)
- **Multicursor**: `<C-n>` (add cursor), `<esc>` (clear)
- **Flash**: `f` (jump), `F` (treesitter)

## 🌐 Languages

- 🇺🇸 **English**: This documentation
- 🇪🇸 **Español**: [Keybindings en Español](../es/keymaps.md)

---

*For a complete guide on how to revert the Colemak-DH layout to standard, see [colemak-dh.md](colemak-dh.md).*
