return {
    "gvanderclay/android-workbench.nvim",
    version = "v0.3.0",
    cmd = "Android",
    init = function()
        local sdk = vim.env.ANDROID_HOME
        if not sdk or sdk == "" then
            sdk = vim.env.ANDROID_SDK_ROOT
        end
        if not sdk or sdk == "" then
            sdk = vim.fn.expand("~/Android/Sdk")
        end

        vim.env.ANDROID_HOME = sdk
        vim.env.ANDROID_SDK_ROOT = sdk

        local path = vim.split(vim.env.PATH or "", ":", { plain = true })
        for _, dir in ipairs({ sdk .. "/emulator", sdk .. "/platform-tools" }) do
            if vim.fn.isdirectory(dir) == 1 and not vim.tbl_contains(path, dir) then
                table.insert(path, 1, dir)
            end
        end
        vim.env.PATH = table.concat(path, ":")
    end,
}
