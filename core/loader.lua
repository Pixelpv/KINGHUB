local Loader = {}

function Loader.loadTabs(tabs)
    local gameFolder = "KINGHUB/games/99Nights/"
    
    -- Load each tab module
    if isfile(gameFolder .. "info.lua") then
        local success, result = pcall(function()
            return loadstring(readfile(gameFolder .. "info.lua"))()
        end)
        
        if success and type(result) == "function" then
            result(tabs.Info)
        end
    end
    
    if isfile(gameFolder .. "main.lua") then
        local success, result = pcall(function()
            return loadstring(readfile(gameFolder .. "main.lua"))()
        end)
        
        if success and type(result) == "function" then
            result(tabs.Main)
        end
    end
    
    -- Load other tabs similarly...
    local tabFiles = {
        Bring = "bring.lua",
        AutoFarm = "autoFarm.lua",
        Visuals = "visuals.lua",
        Settings = "settings.lua"
    }
    
    for tabName, file in pairs(tabFiles) do
        if isfile(gameFolder .. file) then
            local success, result = pcall(function()
                return loadstring(readfile(gameFolder .. file))()
            end)
            
            if success and type(result) == "function" then
                result(tabs[tabName])
            end
        end
    end
end

return Loader
