-- core/utils.lua
local Utils = {}

-- Log formatado
function Utils:Log(msg)
    print("[KINGHUB][INFO] " .. msg)
end

-- Aviso formatado
function Utils:Warn(msg)
    warn("[KINGHUB][WARN] " .. msg)
end

-- Erro formatado
function Utils:Error(msg)
    error("[KINGHUB][ERROR] " .. msg)
end

-- Verifica se uma instância existe
function Utils:SafeWaitFor(obj, child, timeout)
    local t = 0
    while not obj:FindFirstChild(child) and t < (timeout or 5) do
        task.wait(0.1)
        t += 0.1
    end
    return obj:FindFirstChild(child)
end

return Utils
