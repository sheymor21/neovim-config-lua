local M = {}

local java_home = "/usr/lib/jvm/java-17-openjdk"
local active = false
local previous_java_home

local function set_java_17()
    if vim.fn.executable(java_home .. "/bin/java") ~= 1 then
        return
    end

    if not active then
        previous_java_home = vim.env.JAVA_HOME
    end

    vim.env.JAVA_HOME = java_home
    active = true
end

local function restore_java()
    if not active then
        return
    end

    if vim.env.JAVA_HOME == java_home then
        vim.env.JAVA_HOME = previous_java_home
    end

    previous_java_home = nil
    active = false
end

function M.sync()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].buftype ~= "" then
        return
    end

    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == "" or path:match("^[%w+.-]+://") then
        path = vim.uv.cwd()
    end

    local ok, root = pcall(vim.fs.root, path, { "gradlew" })
    if ok and root and vim.uv.fs_stat(vim.fs.joinpath(root, "gradlew")) then
        set_java_17()
    else
        restore_java()
    end
end

local group = vim.api.nvim_create_augroup("GradleJavaRuntime", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
    group = group,
    callback = M.sync,
})

M.sync()

return M
