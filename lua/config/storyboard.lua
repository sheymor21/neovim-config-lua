local M = {}

M.repo_url = "https://github.com/sheymor21/DiaProject.git"
M.clone_dir = vim.fn.stdpath("data") .. "/storyboard"
M.binary = M.clone_dir .. "/server"
M.db_path = vim.fn.expand("~/Documents/Sheymor/storyboard.txt")
M.log_path = vim.fn.stdpath("log") .. "/storyboard.log"

M.job_id = nil
M.port = nil

-- Find a free TCP port using python3 (portable, no extra deps)
function M.find_free_port()
    local ok, result = pcall(function()
        return vim.fn.system("python3 -c 'import socket; s=socket.socket(); s.bind((\"\",0)); print(s.getsockname()[1]); s.close()'")
    end)
    if not ok then
        -- Fallback: try a random high port
        return tostring(math.random(30000, 50000))
    end
    local port = vim.fn.trim(result):match("%d+")
    return port or tostring(math.random(30000, 50000))
end

function M.is_cloned()
    return vim.fn.isdirectory(M.clone_dir .. "/.git") == 1
end

function M.has_binary()
    return vim.fn.filereadable(M.binary) == 1
end

function M.clone(callback)
    if M.is_cloned() then
        if callback then callback(0) end
        return
    end

    vim.notify("Cloning Story Board from GitHub...", vim.log.levels.INFO)
    vim.system({ "git", "clone", M.repo_url, M.clone_dir }, { text = true }, function(obj)
        vim.schedule(function()
            if obj.code == 0 then
                vim.notify("Story Board cloned successfully", vim.log.levels.INFO)
            else
                vim.notify("Clone failed: " .. (obj.stderr or ""), vim.log.levels.ERROR)
            end
            if callback then callback(obj.code) end
        end)
    end)
end

function M.build(callback)
    if not M.is_cloned() then
        vim.notify("Story Board not cloned. Run clone first.", vim.log.levels.ERROR)
        if callback then callback(1) end
        return
    end

    vim.notify("Building Story Board binary...", vim.log.levels.INFO)
    vim.system({ "go", "build", "./cmd/server" }, { cwd = M.clone_dir, text = true }, function(obj)
        vim.schedule(function()
            if obj.code == 0 then
                vim.notify("Story Board built successfully", vim.log.levels.INFO)
            else
                vim.notify("Build failed: " .. (obj.stderr or ""), vim.log.levels.ERROR)
            end
            if callback then callback(obj.code) end
        end)
    end)
end

function M.start(callback)
    if M.job_id then
        vim.notify("Story Board is already running on port " .. (M.port or "?"), vim.log.levels.WARN)
        if callback then callback(0) end
        return
    end

    local function do_start()
        M.port = M.find_free_port()

        -- Ensure db directory exists
        local db_dir = vim.fn.fnamemodify(M.db_path, ":h")
        if vim.fn.isdirectory(db_dir) == 0 then
            vim.fn.mkdir(db_dir, "p")
        end

        -- Ensure log directory exists
        local log_dir = vim.fn.fnamemodify(M.log_path, ":h")
        if vim.fn.isdirectory(log_dir) == 0 then
            vim.fn.mkdir(log_dir, "p")
        end

        local env = {
            STORYBOARD_PORT = ":" .. M.port,
            STORYBOARD_DB = M.db_path,
            STORYBOARD_LOG = M.log_path,
        }

        vim.notify("Starting Story Board on port " .. M.port .. "...", vim.log.levels.INFO)
        M.job_id = vim.fn.jobstart({ M.binary }, {
            cwd = M.clone_dir,
            env = env,
            detach = true,
            on_exit = function(_, code)
                vim.schedule(function()
                    M.job_id = nil
                    M.port = nil
                    if code ~= 0 then
                        vim.notify("Story Board exited with code " .. code, vim.log.levels.WARN)
                    end
                end)
            end,
        })

        if not M.job_id or M.job_id == 0 then
            M.job_id = nil
            M.port = nil
            vim.notify("Failed to start Story Board (jobstart failed)", vim.log.levels.ERROR)
            if callback then callback(1) end
            return
        end

        -- Wait for server to bind
        vim.wait(800, function()
            return false
        end)

        -- Verify it's responding
        vim.system({ "curl", "-s", "http://localhost:" .. M.port .. "/api/projects" }, { text = true }, function(obj)
            vim.schedule(function()
                if obj.code == 0 and obj.stdout and obj.stdout:match("%[") then
                    vim.notify("Story Board running at http://localhost:" .. M.port, vim.log.levels.INFO)
                else
                    vim.notify("Story Board started but API not responding yet", vim.log.levels.WARN)
                end
                if callback then callback(obj.code == 0 and 0 or 1) end
            end)
        end)
    end

    if not M.is_cloned() then
        M.clone(function(code)
            if code ~= 0 then
                if callback then callback(code) end
                return
            end
            M.build(function(code2)
                if code2 ~= 0 then
                    if callback then callback(code2) end
                    return
                end
                do_start()
            end)
        end)
    elseif not M.has_binary() then
        M.build(function(code)
            if code ~= 0 then
                if callback then callback(code) end
                return
            end
            do_start()
        end)
    else
        do_start()
    end
end

function M.stop(callback)
    if not M.job_id then
        vim.notify("Story Board is not running", vim.log.levels.WARN)
        if callback then callback(0) end
        return
    end

    local port = M.port or "8080"
    vim.notify("Shutting down Story Board...", vim.log.levels.INFO)

    vim.system({ "curl", "-s", "-X", "POST", "http://localhost:" .. port .. "/api/shutdown" }, { text = true }, function(obj)
        vim.schedule(function()
            vim.wait(500, function() return false end)

            if M.job_id then
                pcall(vim.fn.jobstop, M.job_id)
                M.job_id = nil
            end
            M.port = nil

            vim.notify("Story Board stopped", vim.log.levels.INFO)
            if callback then callback(0) end
        end)
    end)
end

function M.get_port()
    return M.port
end

function M.is_running()
    if not M.job_id then
        return false
    end
    -- Check if process is alive via jobwait with zero timeout
    local alive = vim.fn.jobwait({ M.job_id }, 0)[1] == -1
    return alive
end

-- API helpers (async with callbacks)
function M.api_get(path, callback)
    local port = M.port or "8080"
    vim.system({ "curl", "-s", "http://localhost:" .. port .. path }, { text = true }, function(obj)
        vim.schedule(function()
            if obj.code ~= 0 then
                if callback then callback(nil, obj.stderr or "curl failed") end
                return
            end
            local ok, data = pcall(vim.json.decode, obj.stdout)
            if not ok then
                if callback then callback(nil, "JSON decode failed: " .. tostring(data)) end
                return
            end
            if callback then callback(data, nil) end
        end)
    end)
end

function M.api_post(path, body, callback)
    local port = M.port or "8080"
    local json_body = type(body) == "string" and body or vim.json.encode(body)
    vim.system({
        "curl", "-s", "-X", "POST",
        "-H", "Content-Type: application/json",
        "-d", json_body,
        "http://localhost:" .. port .. path,
    }, { text = true }, function(obj)
        vim.schedule(function()
            if obj.code ~= 0 then
                if callback then callback(nil, obj.stderr or "curl failed") end
                return
            end
            local ok, data = pcall(vim.json.decode, obj.stdout)
            if not ok then
                if callback then callback(nil, "JSON decode failed: " .. tostring(data)) end
                return
            end
            if callback then callback(data, nil) end
        end)
    end)
end

function M.api_delete(path, callback)
    local port = M.port or "8080"
    vim.system({
        "curl", "-s", "-X", "DELETE",
        "http://localhost:" .. port .. path,
    }, { text = true }, function(obj)
        vim.schedule(function()
            if obj.code ~= 0 then
                if callback then callback(nil, obj.stderr or "curl failed") end
                return
            end
            local ok, data = pcall(vim.json.decode, obj.stdout)
            if not ok then
                -- Some DELETEs return empty body, which is ok
                if callback then callback({}, nil) end
                return
            end
            if callback then callback(data, nil) end
        end)
    end)
end

return M
