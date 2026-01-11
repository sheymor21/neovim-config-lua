return {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
        log_level = "info",
        enabled = true,

        auto_save = true,
        auto_restore = true,
        auto_restore_last_session = false,

        root_dir = vim.fn.stdpath("data") .. "/sessions/",
        bypass_save_filetypes = { "alpha", "snacks_dashboard" },

        session_lens = {
            load_on_setup = false,
        },

        auto_session_use_git_branch = false,

        -- 🔑 LA PIEZA QUE FALTABA
        cwd_change_handling = {
            restore_upcoming_session = true,
            pre_cwd_changed_hook = function()
                require("auto-session").save_session()
            end,
            post_cwd_changed_hook = function()
                require("auto-session").restore_session()
            end,
        },

        pre_save_cmds = {
            function()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    local ft = vim.bo[buf].filetype
                    if ft:match("^snacks_") then
                        vim.api.nvim_buf_delete(buf, { force = true })
                    end
                end
            end,
        },

        continue_restore_on_setup = false,
    },

    config = function(_, opts)
        vim.o.sessionoptions =
        "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

        local function is_empty_start()
            return vim.fn.argc() == 0 and not vim.g.started_with_stdin
        end

        if is_empty_start() then
            opts.auto_restore = false
        end

        require("auto-session").setup(opts)
    end,
}
