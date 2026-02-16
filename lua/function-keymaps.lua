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
    require("telescope.builtin").grep_string({
        search = "- [ ]",
        cwd = vim.fn.expand("~/notes"),
        prompt_title = "Pending tasks",
    })
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

function M.toggle_diagnostics_display()
    local config = vim.diagnostic.config()
    local use_virtual_lines = not config.virtual_lines
    
    vim.diagnostic.config({
        virtual_text = not use_virtual_lines,
        virtual_lines = use_virtual_lines and { only_current_line = true } or false,
    })
    
    vim.notify(
        use_virtual_lines and "Diagnostics: Virtual Lines" or "Diagnostics: Virtual Text",
        vim.log.levels.INFO
    )
end

return M
