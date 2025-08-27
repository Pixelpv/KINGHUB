-- ui.lua
local FluentLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/libs/fluent.lua"))()

local Loader = require(script.Parent.core.loader)

local UI = {}
local MainWindow

function UI:Init(PlayerGui)
    -- cria janela principal Fluent UI
    MainWindow = FluentLib:CreateWindow({
        Name = "KingHub - 99 Nights",
        Parent = PlayerGui,
        IntroText = "Bem-vindo ao KingHub!"
    })

    -- chama o loader do jogo 99 Nights
    Loader:LoadGame("99Nights", MainWindow)
end

return UI
