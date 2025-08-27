-- main.lua
local function import(file)
    local url = "https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/" .. file
    return loadstring(game:HttpGet(url))()
end

-- Espera o PlayerGui estar disponível
local player = game.Players.LocalPlayer
while not player or not player:FindFirstChild("PlayerGui") do
    task.wait(0.1)
end
local PlayerGui = player.PlayerGui

-- Pequena espera extra para garantir estabilidade
task.wait(1)

-- importa e inicializa UI
local UI = import("ui.lua")
UI:Init(PlayerGui)
