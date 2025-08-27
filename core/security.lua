-- core/security.lua
local Security = {}
local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/core/utils.lua"))()

-- Protege contra erros inesperados
function Security:SafeCall(func, ...)
    local args = {...}
    local ok, result = pcall(function()
        return func(unpack(args))
    end)
    if not ok then
        Utils:Warn("Erro capturado: " .. tostring(result))
    end
    return ok, result
end

-- Protege contra loops infinitos (timeout em segundos)
function Security:Timeout(func, timeout)
    local finished = false
    local result

    task.spawn(function()
        local ok, res = pcall(func)
        if ok then
            result = res
        end
        finished = true
    end)

    local t = 0
    while not finished and t < timeout do
        task.wait(0.1)
        t += 0.1
    end

    if not finished then
        Utils:Warn("Timeout atingido em função")
    end

    return result
end

return Security
