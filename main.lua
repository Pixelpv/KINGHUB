-- KINGHUB main.lua
if not game:IsLoaded() then game.Loaded:Wait() end

-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Player local
local LocalPlayer = Players.LocalPlayer

-- Importa o módulo do jogo
local success, gameModule = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/games/99Nights.lua"))()
end)

if not success then
    warn("[KINGHUB] Failed to load game module:", gameModule)
    return
end

-- Inicializa
gameModule.Init()
