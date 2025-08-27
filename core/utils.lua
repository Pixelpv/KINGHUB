-- Funções auxiliares

local Utils = {}

function Utils.tableLength(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

return Utils
