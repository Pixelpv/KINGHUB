-- KINGHUB - 99 Nights in the Forest
-- Apenas Tab "Info"

local Library = {}

-- Criar GUI estilo Fluent (simples por enquanto)
function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KINGHUB_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 400, 0, 250)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -125)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(0, 255, 170)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.Parent = Frame

    return Frame
end

local InfoTab = {}

function InfoTab:Init()
    local window = Library:CreateWindow("KingHub - 99 Nights")

    local Info = Instance.new("TextLabel")
    Info.Size = UDim2.new(1, -20, 1, -60)
    Info.Position = UDim2.new(0, 10, 0, 50)
    Info.BackgroundTransparency = 1
    Info.TextColor3 = Color3.fromRGB(220, 220, 220)
    Info.TextSize = 16
    Info.Font = Enum.Font.Gotham
    Info.TextWrapped = true
    Info.TextYAlignment = Enum.TextYAlignment.Top
    Info.Text = [[
👑 KingHub - 99 Nights in the Forest
Version: 1.0
Author: Pixelpv
Discord: discord.gg/xxxxx
GitHub: github.com/Pixelpv/KINGHUB
    ]]
    Info.Parent = window
end

local Module = {}

function Module.Init()
    InfoTab:Init()
end

return Module
