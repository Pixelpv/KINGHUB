-- KING HUB | core.lua -- Autor: Pixelpv + ChatGPT -- Descrição: Script principal com sistema de GUI, toggle no logo, botão de fechar, compatível com mobile e PC

local Players = game:GetService("Players") local CoreGui = game:GetService("CoreGui") local player = Players.LocalPlayer local UserInputService = game:GetService("UserInputService")

-- Proteção para evitar duplicatas pcall(function() if CoreGui:FindFirstChild("KINGHUB_UI") then CoreGui:FindFirstChild("KINGHUB_UI"):Destroy() end end)

-- Criar GUI local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "KINGHUB_UI" ScreenGui.Parent = CoreGui ScreenGui.ResetOnSpawn = false

-- Logo (botão) local LogoButton = Instance.new("ImageButton") LogoButton.Name = "LogoButton" LogoButton.Size = UDim2.new(0, 100, 0, 100) LogoButton.Position = UDim2.new(0, 10, 0, 10) LogoButton.BackgroundTransparency = 1 LogoButton.Image = "https://cdn.discordapp.com/attachments/1370823988594475050/1396862496438222938/file_00000000da4461f8b9a9363b3df58125.png" LogoButton.Parent = ScreenGui

-- Main Frame (Menu) local MainFrame = Instance.new("Frame") MainFrame.Size = UDim2.new(0, 500, 0, 350) MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175) MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) MainFrame.BorderSizePixel = 0 MainFrame.Visible = false MainFrame.Active = true MainFrame.Draggable = true MainFrame.Parent = ScreenGui

-- UICorner local UICorner = Instance.new("UICorner") UICorner.CornerRadius = UDim.new(0, 8) UICorner.Parent = MainFrame

-- Botão Fechar local CloseButton = Instance.new("TextButton") CloseButton.Text = "X" CloseButton.Size = UDim2.new(0, 30, 0, 30) CloseButton.Position = UDim2.new(1, -35, 0, 5) CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60) CloseButton.TextColor3 = Color3.new(1, 1, 1) CloseButton.Font = Enum.Font.GothamBold CloseButton.TextSize = 16 CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Título local Title = Instance.new("TextLabel") Title.Text = "KING HUB" Title.Size = UDim2.new(1, 0, 0, 40) Title.Position = UDim2.new(0, 0, 0, 0) Title.BackgroundTransparency = 1 Title.TextColor3 = Color3.fromRGB(255, 215, 0) Title.Font = Enum.Font.GothamBlack Title.TextSize = 28 Title.Parent = MainFrame

-- Menu de abas (em cima) local TabBar = Instance.new("Frame") TabBar.Size = UDim2.new(1, -10, 0, 40) TabBar.Position = UDim2.new(0, 5, 0, 45) TabBar.BackgroundTransparency = 1 TabBar.Parent = MainFrame

local tabNames = { "Farmar", "Mar", "Ilhas", "Missões/Itens", "Fruta/Raid", "Hop", "Teleporte", "Status", "Visual", "Loja", "Diversos" }

local currentTab = nil local tabFrames = {}

for i, name in ipairs(tabNames) do local Tab = Instance.new("TextButton") Tab.Text = name Tab.Size = UDim2.new(0, 100, 0, 30) Tab.Position = UDim2.new(0, (i - 1) * 105, 0, 0) Tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40) Tab.TextColor3 = Color3.fromRGB(255, 255, 255) Tab.Font = Enum.Font.Gotham Tab.TextSize = 14 Tab.Parent = TabBar

local Content = Instance.new("Frame")
Content.Name = name .. "Tab"
Content.Size = UDim2.new(1, -10, 1, -90)
Content.Position = UDim2.new(0, 5, 0, 85)
Content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Content.Visible = false
Content.Parent = MainFrame

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 6)
Corner.Parent = Content

tabFrames[name] = Content

Tab.MouseButton1Click:Connect(function()
    if currentTab then tabFrames[currentTab].Visible = false end
    Content.Visible = true
    currentTab = name
end)

end

-- Clique na logo abre/fecha menu local visible = false LogoButton.MouseButton1Click:Connect(function() visible = not visible MainFrame.Visible = visible end)

-- Aviso de carregamento local Notify = Instance.new("TextLabel") Notify.Size = UDim2.new(0, 300, 0, 40) Notify.Position = UDim2.new(0.5, -150, 1, -60) Notify.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Notify.TextColor3 = Color3.fromRGB(255, 255, 255) Notify.Font = Enum.Font.GothamBold Notify.TextSize = 16 Notify.Text = "KING HUB carregado com sucesso!" Notify.Parent = ScreenGui

local NotifyCorner = Instance.new("UICorner") NotifyCorner.CornerRadius = UDim.new(0, 8) NotifyCorner.Parent = Notify

delay(4, function() if Notify then Notify:Destroy() end end)

-- Aqui você pode adicionar funcionalidades específicas para cada aba depois -- Ex: tabFrames["Farmar"]:AddChild(botões, etc)

print("[KING HUB] Script carregado.")

