-- ui.lua
local FluentLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/libs/fluent.lua"))()

local Loader = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/core/loader.lua"))()

local UI = {}
local MainWindow

function UI:Init(PlayerGui)
    -- cria janela principal Fluent UI
    MainWindow = FluentLib:CreateWindow({
        Name = "KINGHUB - 99 Nights",
        Parent = PlayerGui,
        IntroText = "Welcome to KINGHUB!"
    })

    -- carrega todas as abas do jogo 99Nights
    Loader:LoadGame("99Nights", MainWindow)
end

return UI
