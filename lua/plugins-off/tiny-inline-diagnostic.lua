-- Replaces virtual_text with inline diagnostics at end of lines
-- Run :checkhealth tiny-inline-diagnostic after install

return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
        local tiny = require("tiny-inline-diagnostic")
        tiny.setup()
        -- Mutate config in place so ColorScheme autocommand picks up the new blend
        tiny.config.blend.factor = 0
        -- Apply immediately
        tiny.change({ factor = 0 })
        vim.diagnostic.config({ virtual_text = false })

        -- Fix: some colorschemes define diagnostic highlights as links.
        -- The plugin reads them without resolving links, so fg becomes nil.
        -- We add a ColorScheme autocommand that copies resolved colors.
        local function fix_tiny_highlights()
            local severities = {
                { "Error", "DiagnosticError", "DiagnosticVirtualTextError" },
                { "Warn",  "DiagnosticWarn",  "DiagnosticVirtualTextWarn" },
                { "Info",  "DiagnosticInfo",  "DiagnosticVirtualTextInfo" },
                { "Hint",  "DiagnosticHint",  "DiagnosticVirtualTextHint" },
            }
            for _, sev in ipairs(severities) do
                local suffix = sev[1]
                -- Try DiagnosticVirtualText* first (resolved), fall back to Diagnostic*
                local src = vim.api.nvim_get_hl(0, { name = sev[3], link = false })
                if not src.fg then
                    src = vim.api.nvim_get_hl(0, { name = sev[2], link = false })
                end
                if src.fg then
                    for _, prefix in ipairs({
                        "TinyInlineDiagnosticVirtualText",
                        "TinyInlineDiagnosticVirtualTextArrow",
                    }) do
                        local hi_name = prefix .. suffix
                        local existing = vim.api.nvim_get_hl(0, { name = hi_name, link = false })
                        -- Only set if currently missing fg
                        if not existing.fg then
                            vim.api.nvim_set_hl(0, hi_name, { fg = src.fg, bg = existing.bg })
                        end
                        -- Also fix CursorLine variant
                        local cursor_name = hi_name .. "CursorLine"
                        local cursor_existing = vim.api.nvim_get_hl(0, { name = cursor_name, link = false })
                        if not cursor_existing.fg then
                            vim.api.nvim_set_hl(0, cursor_name, { fg = src.fg, bg = cursor_existing.bg })
                        end
                    end
                    -- Fix inverse highlights (the / borders)
                    for _, inv_prefix in ipairs({
                        "TinyInlineInvDiagnosticVirtualText",
                        "TinyInlineInvDiagnosticVirtualTextArrow",
                    }) do
                        local inv_name = inv_prefix .. suffix
                        local inv_existing = vim.api.nvim_get_hl(0, { name = inv_name, link = false })
                        if not inv_existing.fg and inv_existing.bg then
                            -- Inverse highlights use bg as fg; if missing, copy from source bg or use same fg
                            vim.api.nvim_set_hl(0, inv_name, { fg = inv_existing.bg, bg = src.fg })
                        end
                        local inv_cursor = inv_name .. "CursorLine"
                        local inv_cursor_existing = vim.api.nvim_get_hl(0, { name = inv_cursor, link = false })
                        if not inv_cursor_existing.fg and inv_cursor_existing.bg then
                            vim.api.nvim_set_hl(0, inv_cursor, { fg = inv_cursor_existing.bg, bg = src.fg })
                        end
                    end
                end
            end
        end

        -- Run once now and on every colorscheme change.
        -- Defer on ColorScheme so our fix runs AFTER the plugin's own handler.
        fix_tiny_highlights()
        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("TinyInlineDiagnosticColorFix", { clear = true }),
            callback = function()
                vim.defer_fn(fix_tiny_highlights, 50)
            end,
        })

        -- Diagnostic command to troubleshoot color issues
        vim.api.nvim_create_user_command("TinyInlineDiagnosticInfo", function()
            local lines = {}
            local function add(fmt, ...)
                table.insert(lines, string.format(fmt, ...))
            end

            add("=== Tiny Inline Diagnostic Debug Info ===")
            add("")

            -- Colorscheme
            add("Colorscheme: %s", vim.g.colors_name or "none")
            add("")

            -- Plugin config
            add("Plugin config:")
            add("  blend.factor: %s", tostring(tiny.config.blend.factor))
            add("  blend.hlgroup: %s", tostring(tiny.config.blend.hlgroup))
            add("  preset: %s", tostring(tiny.config.preset))
            add("")

            -- Diagnostic config
            add("vim.diagnostic.config():")
            local diag_config = vim.diagnostic.config()
            add("  virtual_text: %s", vim.inspect(diag_config.virtual_text))
            add("  signs: %s", vim.inspect(diag_config.signs))
            add("  underline: %s", vim.inspect(diag_config.underline))
            add("")

            -- Plugin highlights
            add("Plugin highlights:")
            for _, name in ipairs({
                "TinyInlineDiagnosticVirtualTextError",
                "TinyInlineDiagnosticVirtualTextWarn",
                "TinyInlineDiagnosticVirtualTextInfo",
                "TinyInlineDiagnosticVirtualTextHint",
                "TinyInlineDiagnosticVirtualTextErrorCursorLine",
                "TinyInlineDiagnosticVirtualTextWarnCursorLine",
            }) do
                local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
                local fg = hl.fg and string.format("#%06x", hl.fg) or "nil"
                local bg = hl.bg and string.format("#%06x", hl.bg) or "nil"
                add("  %s: fg=%s bg=%s", name, fg, bg)
            end
            add("")

            -- Native diagnostic highlights
            add("Native diagnostic highlights:")
            for _, name in ipairs({
                "DiagnosticError",
                "DiagnosticWarn",
                "DiagnosticInfo",
                "DiagnosticHint",
                "DiagnosticVirtualTextError",
                "DiagnosticVirtualTextWarn",
            }) do
                local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
                local fg = hl.fg and string.format("#%06x", hl.fg) or "nil"
                local bg = hl.bg and string.format("#%06x", hl.bg) or "nil"
                add("  %s: fg=%s bg=%s", name, fg, bg)
            end
            add("")

            -- Extmarks in current buffer
            add("Extmarks in current buffer:")
            local ns = vim.api.nvim_create_namespace("TinyInlineDiagnostic")
            local marks = vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { details = true })
            if #marks == 0 then
                add("  No extmarks found (no diagnostics rendered?)")
            else
                add("  Found %d extmark(s):", #marks)
                for _, mark in ipairs(marks) do
                    local row = mark[2]
                    local details = mark[4]
                    if details.virt_text then
                        for _, chunk in ipairs(details.virt_text) do
                            local text = chunk[1]:gsub("\n", "\\n")
                            local hl = chunk[2] or "nil"
                            add("    row %d: '%s' -> %s", row, text, hl)
                        end
                    end
                end
            end
            add("")

            -- Diagnostics in current buffer
            add("Diagnostics in current buffer:")
            local diags = vim.diagnostic.get(0)
            if #diags == 0 then
                add("  No diagnostics found")
            else
                add("  Found %d diagnostic(s):", #diags)
                for _, diag in ipairs(diags) do
                    local sev = ({"ERROR", "WARN", "INFO", "HINT"})[diag.severity] or "?"
                    add("    line %d: [%s] %s", diag.lnum + 1, sev, diag.message:sub(1, 60))
                end
            end

            -- Show in a floating window
            local buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
            vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })

            local width = math.min(80, vim.o.columns - 4)
            local height = math.min(#lines, vim.o.lines - 4)
            local col = math.floor((vim.o.columns - width) / 2)
            local row = math.floor((vim.o.lines - height) / 2)

            vim.api.nvim_open_win(buf, true, {
                relative = "editor",
                row = row,
                col = col,
                width = width,
                height = height,
                style = "minimal",
                border = "rounded",
                title = " TinyInlineDiagnostic Info ",
                title_pos = "center",
            })
        end, { desc = "Show debug info for tiny-inline-diagnostic" })
    end,
}
