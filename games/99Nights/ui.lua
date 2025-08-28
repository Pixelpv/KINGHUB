-- ui.lua (99 Nights in the Forest)

local UI = {}

function UI:CreateMain(features)
    -- Exemplo simples de Fluent UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KingHubUI"
    ScreenGui.Parent = game:GetService("CoreGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 400, 0, 300)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.Text = "KINGHUB - 99 Nights"
    Title.TextColor3 = Color3.fromRGB(0, 255, 150)
    Title.Parent = Frame

    -- Botão exemplo
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 120, 0, 30)
    Button.Position = UDim2.new(0, 20, 0, 60)
    Button.Text = "Auto Collect"
    Button.Parent = Frame

    Button.MouseButton1Click:Connect(function()
        features.AutoCollect()
    end)
end

return UI
