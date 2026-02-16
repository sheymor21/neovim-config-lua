local lsp_utils = require("lsp.utils")

local function get_root_dir(fname)
    return vim.fs.root(fname, {
        ".luarc.json",
        ".luarc.jsonc",
        ".stylua.toml",
        "stylua.toml",
        ".git",
    }) or vim.fn.expand("~/.config/nvim")
end

local lua_config = {
    name = "lua_ls",
    cmd = { "lua-language-server" },
    root_dir = get_root_dir,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function(args)
        vim.schedule(function()
            local bufnr = args.buf
            if not bufnr or type(bufnr) ~= "number" or not vim.api.nvim_buf_is_valid(bufnr) then
                return
            end
            
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local root_dir = lua_config.root_dir(fname)
            local config = vim.tbl_extend("force", lua_config, {
                root_dir = root_dir,
            })
            lsp_utils.start_lsp_client("lua_ls", bufnr, config)
        end)
    end,
})
