local M = {}

---@class LspServerEntry
---@field name string
---@field module string

---@type LspServerEntry[]
M.servers = {
    { name = "gopls", module = "lsp.gopls" },
    { name = "lua_ls", module = "lsp.lua-lsp" },
    { name = "vtsls", module = "lsp.vtsls" },
    { name = "html", module = "lsp.html" },
    { name = "cssls", module = "lsp.css" },
    { name = "marksman", module = "lsp.markdown" },
}

---@param name string
---@return LspServerEntry|nil
function M.get(name)
    for _, server in ipairs(M.servers) do
        if server.name == name then
            return server
        end
    end
end

return M
