-- KingHub Main Loader
-- Designed specifically for 99 Nights in the Forest
-- Author: ntzinho
-- Version: 1.0.0

if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")

local success, err = pcall(function()
    -- Load Fluent UI library
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    
    -- Load our custom Fluent modifications if needed
    if isfile("KINGHUB/libs/fluent.lua") then
        Fluent = loadstring(readfile("KINGHUB/libs/fluent.lua"))() or Fluent
    end
    
    -- Load core modules
    local Utils = loadstring(readfile("KINGHUB/core/utils.lua"))()
    local Security = loadstring(readfile("KINGHUB/core/security.lua"))()
    local Loader = loadstring(readfile("KINGHUB/core/loader.lua"))()
    
    -- Initialize security checks
    if not Security.initialize() then
        return
    end
    
    -- Load UI
    loadstring(readfile("KINGHUB/ui.lua"))(Fluent, Utils, Loader)
end)

if not success then
    warn("KingHub Error: " .. tostring(err))
end
