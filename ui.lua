-- ui.lua
local FluentLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/libs/fluent.lua"))()

local Loader = import("core/loader.lua")

local UI = {}
local MainWindow

function UI:Init(PlayerGui)
    MainWindow = FluentLib:CreateWindow({
        Name = "KingHub - 99 Nights",
        Parent = PlayerGui,
        IntroText = "Bem-vindo ao KingHub!"
    })

    -- carrega as abas do jogo
    Loader:LoadGame("99Nights", MainWindow)
end

return UI
