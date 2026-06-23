local M = {}

function M.add_dot()
    local line = vim.api.nvim_get_current_line()
    if line:match(";%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A;")
    vim.api.nvim_win_set_cursor(0, pos)
end

function M.add_coma()
    local line = vim.api.nvim_get_current_line()
    if line:match(",%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A,")
    vim.api.nvim_win_set_cursor(0, pos)
end

function M.search_notes()
    local paths = require("config.paths")
    local Snacks = require("snacks")

    -- Use snacks grep with a fixed search pattern for pending tasks
    Snacks.picker.grep({
        cwd = paths.vault_path,
        search = "- [ ]",
        prompt = "Pending tasks❯ ",
    })
end

function M.new_note_with_folder()
    local paths = require("config.paths")
    local vault = paths.vault_path

    local dirs = {}
    local handle = vim.uv.fs_scandir(vault)
    if handle then
        while true do
            local name, type = vim.uv.fs_scandir_next(handle)
            if not name then break end
            if type == "directory" then
                if not name:match("^%.")
                    and name ~= "assets"
                    and name ~= "daily"
                    and name ~= "weekly"
                    and name ~= "templates" then
                    table.insert(dirs, name)
                end
            end
        end
    end
    table.sort(dirs)
    table.insert(dirs, 1, "(root)")

    vim.ui.select(dirs, { prompt = "Note folder ❯ " }, function(folder)
        if not folder then return end

        vim.ui.input({ prompt = "Note title: " }, function(title)
            if not title or title == "" then return end

            local safe_title = title:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower()
            local relative_path = folder ~= "(root)" and folder .. "/" .. safe_title or safe_title
            local full_path = vault .. "/" .. relative_path .. ".md"

            if vim.fn.filereadable(full_path) == 0 then
                local content = M._apply_template(full_path, "new_note", { title = title })
                M._write_file(full_path, content)
            end

            vim.cmd("edit " .. vim.fn.fnameescape(full_path))
        end)
    end)
end

-- Markdown notes helpers (replacing telekasten)
function M.find_notes()
    local paths = require("config.paths")
    require("snacks").picker.files({
        cwd = paths.vault_path,
        prompt = "Notes❯ ",
    })
end

function M.grep_notes()
    local paths = require("config.paths")
    require("snacks").picker.grep({
        cwd = paths.vault_path,
        prompt = "Search notes❯ ",
    })
end

function M.open_daily_note(offset)
    offset = offset or 0
    local paths = require("config.paths")
    local vault = paths.vault_path
    local date = os.date("%Y-%m-%d", os.time() + offset * 86400)
    local path = vault .. "/daily/" .. date .. ".md"

    M._ensure_dir(vim.fn.fnamemodify(path, ":h"))

    if vim.fn.filereadable(path) == 0 then
        local content = M._apply_template(path, "daily", { date = date })
        M._write_file(path, content)
    end

    vim.cmd("edit " .. vim.fn.fnameescape(path))
end

function M.show_backlinks()
    local paths = require("config.paths")
    local current = vim.fn.expand("%:t:r")
    if current == "" then
        vim.notify("No file open", vim.log.levels.WARN)
        return
    end
    require("snacks").picker.grep({
        cwd = paths.vault_path,
        search = current,
        prompt = "Backlinks❯ ",
    })
end

function M.show_tags()
    local paths = require("config.paths")
    require("snacks").picker.grep({
        cwd = paths.vault_path,
        search = "#[%w_-]+",
        prompt = "Tags❯ ",
    })
end

function M.rename_note()
    local paths = require("config.paths")
    local old_path = vim.api.nvim_buf_get_name(0)
    if old_path == "" or not old_path:find(paths.vault_path, 1, true) then
        vim.notify("Not a vault note", vim.log.levels.WARN)
        return
    end
    local old_name = vim.fn.fnamemodify(old_path, ":t:r")
    vim.ui.input({ prompt = "New name: ", default = old_name }, function(new_name)
        if not new_name or new_name == "" or new_name == old_name then return end
        local new_path = vim.fn.fnamemodify(old_path, ":h") .. "/" .. new_name .. ".md"
        if vim.fn.filereadable(new_path) == 1 then
            vim.notify("File already exists: " .. new_path, vim.log.levels.ERROR)
            return
        end
        vim.fn.rename(old_path, new_path)
        vim.cmd("edit " .. vim.fn.fnameescape(new_path))
        vim.notify("Renamed to " .. new_name, vim.log.levels.INFO)
    end)
end

function M.toggle_checkbox()
    local line = vim.api.nvim_get_current_line()
    local new_line
    if line:find("%- %[ %]") then
        new_line = line:gsub("%- %[ %]", "- [x]", 1)
    elseif line:find("%- %[x%]") then
        new_line = line:gsub("%- %[x%]", "- [ ]", 1)
    else
        vim.notify("No checkbox on this line", vim.log.levels.WARN)
        return
    end
    vim.api.nvim_set_current_line(new_line)
end

function M.follow_link()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1

    -- [[wiki-link]]
    local wiki_before = line:sub(1, col):match("%[%[([^%[%]]*)$")
    local wiki_after = line:sub(col):match("^([^%[%]]*)%]%]")
    if wiki_before and wiki_after then
        local link = wiki_before .. wiki_after
        local paths = require("config.paths")
        local target = paths.vault_path .. "/" .. link .. ".md"
        if vim.fn.filereadable(target) == 0 then
            target = paths.vault_path .. "/" .. link
        end
        vim.cmd("edit " .. vim.fn.fnameescape(target))
        return
    end

    -- [text](markdown-link)
    local md_before = line:sub(1, col)
    local md_after = line:sub(col)
    local text, path_before = md_before:match("%[([^%[%]]*)%]%(([^%)]*)$")
    local path_after = md_after:match("^([^%)]*)%)")
    if text and path_after then
        local link = path_before .. path_after
        local paths = require("config.paths")
        local target = link
        if not target:match("^/") and not target:match("^[a-zA-Z]:[\\/]") then
            target = paths.vault_path .. "/" .. target
        end
        vim.cmd("edit " .. vim.fn.fnameescape(target))
        return
    end

    vim.notify("No link under cursor", vim.log.levels.WARN)
end

function M.capture_note()
    local paths = require("config.paths")
    vim.ui.input({ prompt = "Note title: " }, function(title)
        if not title or title == "" then return end
        local safe_title = title:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower()
        local path = paths.vault_path .. "/" .. safe_title .. ".md"
        if vim.fn.filereadable(path) == 0 then
            local content = M._apply_template(path, "new_note", { title = title })
            M._write_file(path, content)
        end
        vim.cmd("edit " .. vim.fn.fnameescape(path))
    end)
end

function M.open_notes_panel()
    M.find_notes()
end

-- Internal note helpers
function M._ensure_dir(dir)
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
end

function M._read_file(path)
    local f = io.open(path, "r")
    if not f then return nil end
    local content = f:read("*a")
    f:close()
    return content
end

function M._write_file(path, content)
    M._ensure_dir(vim.fn.fnamemodify(path, ":h"))
    local f = io.open(path, "w")
    if not f then return false end
    f:write(content)
    f:close()
    return true
end

function M._apply_template(path, template_name, vars)
    vars = vars or {}
    local paths = require("config.paths")
    local template_path = paths.vault_path .. "/templates/" .. template_name .. ".md"
    local content = M._read_file(template_path) or ""

    for k, v in pairs(vars) do
        content = content:gsub("{{" .. k .. "}}", v)
    end

    if content == "" then
        if template_name == "new_note" then
            content = "# " .. (vars.title or "") .. "\n\n"
        elseif template_name == "daily" then
            content = "# " .. (vars.date or "") .. "\n\n"
        end
    end

    return content
end

function M.runner_run()
    require("unirunner").run()
end

function M.runner_select_run()
    require("unirunner").run_select()
end

function M.runner_config()
    require("unirunner").open_config()
end

function M.runner_history()
    require("unirunner").show_output_history()
end

function M.runner_go_terminal()
    require("unirunner").goto_terminal()
end

function M.runner_cancel()
    require("unirunner").cancel()
end

function M.runner_open_url()
    require("unirunner").open_url()
end

function M.runner_url_select()
    require("unirunner").open_url_select()
end

function M.lsp_rename_and_save()
	local current_name = vim.fn.expand("<cword>")
	vim.ui.input({ prompt = "Rename to: ", default = current_name }, function(input)
		if not input or input == "" then
			return
		end

		local params = vim.lsp.util.make_position_params()
		params.newName = input

		vim.lsp.buf_request(0, "textDocument/rename", params, function(err, result, ctx)
			if err then
				vim.notify("Rename failed: " .. err.message, vim.log.levels.ERROR)
				return
			end

			if not result or (not result.changes and not result.documentChanges) then
				vim.notify("No rename changes", vim.log.levels.INFO)
				return
			end

			local client = vim.lsp.get_client_by_id(ctx.client_id)
			local offset_encoding = client and client.offset_encoding or "utf-16"
			vim.lsp.util.apply_workspace_edit(result, offset_encoding)

			-- Save all modified normal buffers
			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].modified and vim.bo[bufnr].buftype == "" then
					vim.api.nvim_buf_call(bufnr, function()
						vim.cmd("silent! write")
					end)
				end
			end

			vim.notify("Renamed and saved affected files", vim.log.levels.INFO)
		end)
	end)
end

function M.neotest_run()
	require("neotest").run.run()
end

function M.neotest_run_all()
    require("neotest").run.run({suite = true})
end

function M.neotest_summary()
    require("neotest").summary.toggle()
end

function M.unipackage_menu()
    require("unipackage").package_menu()
end

function M.neotest_debug()
    local strategy = {
        strategy = "dap"
    }
    require("neotest").run.run(strategy)
end

function M.window_picker()
    local picker = require("window-picker")
    local picked_window_id = picker.pick_window()

    if picked_window_id then
        vim.api.nvim_set_current_win(picked_window_id)
    end
end

function M.toggle_inlay_hints()
    local is_enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not is_enabled)
    vim.notify(
        is_enabled and "Inlay hints: Disabled" or "Inlay hints: Enabled",
        vim.log.levels.INFO
    )
end

function M.toggle_diagnostics_display()
    local config = vim.diagnostic.config()
    local use_virtual_lines = not config.virtual_lines

    vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = use_virtual_lines and { only_current_line = true } or false,
    })

    vim.notify(
        use_virtual_lines and "Diagnostics: Virtual Lines" or "Diagnostics: Inline",
        vim.log.levels.INFO
    )
end

-- Multicursor functions
function M.mc_add_cursor_next()
    require("multicursor-nvim").matchAddCursor(1)
end

function M.mc_add_cursor_prev()
    require("multicursor-nvim").matchAddCursor(-1)
end

function M.mc_match_all_cursors()
    require("multicursor-nvim").matchAllAddCursors()
end

function M.mc_clear_or_enable_cursors()
    local mc = require("multicursor-nvim")
    if not mc.cursorsEnabled() then
        mc.enableCursors()
    else
        mc.clearCursors()
    end
end

-- Flash functions
function M.flash_jump()
    require("flash").jump()
end

function M.flash_treesitter()
    require("flash").treesitter()
end

function M.toggle_peek_preview()
    local peek = require("peek")
    if peek.is_open() then
        peek.close()
    else
        peek.open()
    end
end

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

-- Dashboard URL opener (reads from gitignored dashboard-urls.lua)
function M.dashboard_open_url()
    local ok, urls = pcall(require, "config.dashboard-urls")
    if not ok or not urls or #urls == 0 then
        vim.notify("No URLs configured. Copy lua/config/dashboard-urls.example.lua to lua/config/dashboard-urls.lua", vim.log.levels.WARN)
        return
    end
    local items = {}
    for _, entry in ipairs(urls) do
        items[#items + 1] = entry.name .. "  " .. entry.url
    end
    vim.ui.select(items, { prompt = "Open URL" }, function(choice, idx)
        if choice and idx then
            vim.ui.open(urls[idx].url)
        end
    end)
end

-- ZealSearch smart docset mapping
local zealsearch_docset_map = {
    typescript = "TypeScript",
    javascript = "JavaScript",
    lua = "Lua",
    python = "Python",
    rust = "Rust",
    go = "Go",
    html = "HTML",
    css = "CSS",
    cs = "C#",
    csharp = "C#",
    cpp = "C++",
    c = "C",
    java = "Java",
    ruby = "Ruby",
    php = "PHP",
    sh = "Bash",
    bash = "Bash",
    zsh = "Zsh",
    vim = "Vim",
    nvim = "Neovim",
    sql = "SQL",
    dockerfile = "Docker",
    yaml = "YAML",
    json = "JSON",
    markdown = "Markdown",
    react = "React",
    vue = "Vue.js",
    angular = "Angular",
    svelte = "Svelte",
}

-- Store last query for repeat
local last_zeal_query = nil
local last_zeal_docset = nil

function M.zeal_search_input()
    vim.cmd("ZealSearchInput")
end

function M.zeal_search()
    local ft = vim.bo.filetype
    local docset = zealsearch_docset_map[ft]
    local query = vim.fn.expand("<cword>")

    -- Skip punctuation/symbols and get the actual word
    if query:match("^%W+$") then
        -- Save cursor position
        local save_pos = vim.fn.getpos(".")
        -- Search backward for a word character
        vim.cmd("normal! b")
        query = vim.fn.expand("<cword>")
        -- Restore cursor if we got another non-word
        if query:match("^%W+$") then
            vim.fn.setpos(".", save_pos)
            vim.notify("No word found to search", vim.log.levels.WARN)
            return
        end
        vim.fn.setpos(".", save_pos)
    end

    -- Store for repeat
    last_zeal_query = query
    last_zeal_docset = docset

    if docset then
        local zealsearch = require("zealsearch")
        local docsets = require("zealsearch.docsets")
        local all_docsets = docsets.discover(zealsearch.config.docsets_path)
        local found = false

        for _, ds in ipairs(all_docsets) do
            if ds.name:lower() == docset:lower() then
                found = true
                break
            end
        end

        if found then
            zealsearch.search_docset(docset, query)
            return
        end
    end

    -- Fallback: search all docsets
    require("zealsearch").search(query)
end

function M.zeal_search_all()
    local query = vim.fn.expand("<cword>")

    -- Skip punctuation/symbols and get the actual word
    if query:match("^%W+$") then
        -- Save cursor position
        local save_pos = vim.fn.getpos(".")
        -- Search backward for a word character
        vim.cmd("normal! b")
        query = vim.fn.expand("<cword>")
        -- Restore cursor if we got another non-word
        if query:match("^%W+$") then
            vim.fn.setpos(".", save_pos)
            vim.notify("No word found to search", vim.log.levels.WARN)
            return
        end
        vim.fn.setpos(".", save_pos)
    end

    -- Store for repeat
    last_zeal_query = query
    last_zeal_docset = nil

    require("zealsearch").search(query)
end

function M.zeal_search_repeat()
    if not last_zeal_query or last_zeal_query == "" then
        -- No last query, use word under cursor
        M.zeal_search()
        return
    end

    -- Repeat last search
    if last_zeal_docset then
        require("zealsearch").search_docset(last_zeal_docset, last_zeal_query)
    else
        require("zealsearch").search(last_zeal_query)
    end
end

-- Open external terminal in project root with opencode
function M.open_external_opencode()
    -- Find project root via git
    local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null")
    root = vim.fn.trim(root)
    if root == "" or vim.v.shell_error ~= 0 then
        root = vim.fn.getcwd()
    end

    -- Terminal preference: user-defined > auto-detect
    local preferred = vim.g.external_terminal
    local terminals = {
        "alacritty",
        "kitty",
        "wezterm",
        "gnome-terminal",
        "konsole",
        "xterm",
    }

    local terminal = nil
    if preferred and preferred ~= "" then
        if vim.fn.executable(preferred) == 1 then
            terminal = preferred
        else
            vim.notify(
                "Preferred terminal '" .. preferred .. "' not found, falling back to auto-detect",
                vim.log.levels.WARN
            )
        end
    end

    if not terminal then
        for _, term in ipairs(terminals) do
            if vim.fn.executable(term) == 1 then
                terminal = term
                break
            end
        end
    end

    if not terminal then
        vim.notify("No external terminal found (tried: alacritty, kitty, wezterm, gnome-terminal, konsole, xterm)", vim.log.levels.ERROR)
        return
    end

    -- Build command based on terminal
    local cmd
    if terminal == "alacritty" then
        cmd = { "alacritty", "--working-directory", root, "-e", "opencode" }
    elseif terminal == "kitty" then
        cmd = { "kitty", "--working-directory=" .. root, "opencode" }
    elseif terminal == "wezterm" then
        cmd = { "wezterm", "start", "--cwd", root, "opencode" }
    elseif terminal == "gnome-terminal" then
        cmd = { "gnome-terminal", "--working-directory=" .. root, "--", "opencode" }
    elseif terminal == "konsole" then
        cmd = { "konsole", "--workdir", root, "-e", "opencode" }
    elseif terminal == "xterm" then
        cmd = { "xterm", "-e", "cd " .. vim.fn.shellescape(root) .. " && opencode" }
    else
        -- Generic fallback
        cmd = { terminal, "-e", "cd " .. vim.fn.shellescape(root) .. " && opencode" }
    end

    vim.fn.jobstart(cmd, { detach = true })
    vim.notify("Opened opencode in " .. terminal .. " at " .. root, vim.log.levels.INFO)
end

return M
