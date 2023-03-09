local M = {}
function M.setup()
    vim.api.nvim_create_user_command("MDServer", function(ctx)
        local file = ctx.args
        
        if file == "." then
            file = vim.api.nvim_buf_get_name(0);
        end
        local stdout = vim.loop.new_pipe()
        local stderr = vim.loop.new_pipe()
        local stdin = vim.loop.new_pipe()
        vim.loop.read_start(stdout, function(_, data)
            print(string.format("STDOUT: %s", data))
        end)
        vim.loop.read_start(stderr, function(_, data)
            print(string.format("STDERR: %s", data))
        end)
        vim.loop.spawn("remarko", {
            args = { file },
            stdio = { stdin, stdout, stderr },
        })
    end, {
        nargs = 1,
    })
end
return M
