local M = {}

local servers = require("lsp.servers")
local lsp_utils = require("lsp.utils")

local AUGROUP_PREFIX = "LspServerAutocmds_"
local ATTACH_GROUP = AUGROUP_PREFIX .. "attach"

---@class LspServerConfig
---@field name string
---@field cmd string[]
---@field filetypes string[]
---@field root_dir fun(fname: string): string|nil
---@field settings table|nil
---@field single_file_support boolean|nil
---@field defer boolean|nil

---Return the augroup name used for a specific server.
---@param server_name string
---@return string
local function server_group(server_name)
    return AUGROUP_PREFIX .. server_name
end

---Clear all LSP autocmds created by this module.
function M.clear_autocmds()
    vim.api.nvim_create_augroup(ATTACH_GROUP, { clear = true })

    for _, entry in ipairs(servers.servers) do
        vim.api.nvim_create_augroup(server_group(entry.name), { clear = true })
    end
end

---Clear autocmds for a single server.
---@param server_name string
function M.clear_server_autocmds(server_name)
    vim.api.nvim_create_augroup(server_group(server_name), { clear = true })
end

---Register a FileType autocmd that starts the given LSP server.
---@param config LspServerConfig
function M.register_server(config)
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup(server_group(config.name), { clear = false }),
        pattern = config.filetypes,
        callback = function(args)
            local bufnr = args.buf

            local run = function()
                if not vim.api.nvim_buf_is_valid(bufnr) then
                    return
                end

                local fname = vim.api.nvim_buf_get_name(bufnr)
                local root_dir = config.root_dir(fname)
                local server_config = vim.tbl_extend("force", config, {
                    root_dir = root_dir,
                })

                lsp_utils.start_lsp_client(config.name, bufnr, server_config)
            end

            if config.defer then
                vim.schedule(run)
            else
                run()
            end
        end,
    })
end

---Register the global LspAttach handler and all configured servers.
function M.setup()
    M.clear_autocmds()

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup(ATTACH_GROUP, { clear = false }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local bufnr = args.buf
            if not client then
                return
            end
            require("lsp.on_attach")(client, bufnr)
        end,
    })

    for _, entry in ipairs(servers.servers) do
        local ok, config = pcall(require, entry.module)
        if ok then
            M.register_server(config)
        else
            vim.notify("Failed to load LSP config " .. entry.module .. ": " .. tostring(config), vim.log.levels.WARN)
        end
    end
end

return M
