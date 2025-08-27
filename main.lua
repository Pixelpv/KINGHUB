-- main.lua
local function import(file)
    local url = "https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/" .. file
    return loadstring(game:HttpGet(url))()
end

local player = game.Players.LocalPlayer
while not player or not player:FindFirstChild("PlayerGui") do
    task.wait(0.1)
end
task.wait(1)

-- importa UI e inicializa
local UI = import("ui.lua")
UI:Init(player.PlayerGui)
