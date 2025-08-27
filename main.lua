-- KingHub Main Loader
-- Estrutura modular para múltiplos jogos

if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")

-- Configuração global
getgenv().KingHub = {
    Config = {
        AutoLoad = true,
        UITheme = "Darker",
        UIScale = 100,
        MinimizeKey = Enum.KeyCode.RightShift
    },
    Games = {},
    CurrentGame = nil
}

-- Carregar Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Função para criar a logo interativa
local function createLogo()
    local logoGui = Instance.new("ScreenGui")
    logoGui.Name = "KingHubLogo"
    logoGui.Parent = game.Players.LocalPlayer.PlayerGui
    logoGui.ResetOnSpawn = false
    
    local logoButton = Instance.new("ImageButton")
    logoButton.Size = UDim2.new(0, 60, 0, 60)
    logoButton.Position = UDim2.new(0, 20, 0, 20)
    logoButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    logoButton.BackgroundTransparency = 0.3
    logoButton.BorderSizePixel = 0
    logoButton.AutoButtonColor = false
    
    -- Substitua pelo URL da sua logo
    logoButton.Image = "rbxassetid://1234567890" 
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = logoButton
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(100, 100, 100)
    uiStroke.Thickness = 2
    uiStroke.Parent = logoButton
    
    logoButton.Parent = logoGui
    
    return logoButton, logoGui
end

-- Função para carregar o jogo específico
local function loadGameModule(gameId)
    local gameModulePath = "KINGHUB/games/" .. gameId .. ".lua"
    
    if isfile and isfile(gameModulePath) then
        local success, module = pcall(function()
            return loadstring(readfile(gameModulePath))()
        end)
        
        if success then
            return module
        else
            warn("Erro ao carregar módulo do jogo: " .. tostring(module))
        end
    else
        -- Fallback para carregamento remoto
        local success, module = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/games/" .. gameId .. ".lua"))()
        end)
        
        if success then
            return module
        end
    end
    
    return nil
end

-- Função principal
local function initializeKingHub()
    -- Detectar jogo atual
    local gameId = tostring(game.GameId)
    local gameModule = loadGameModule(gameId)
    
    if not gameModule then
        -- Tentar carregar módulo genérico ou mostrar erro
        gameModule = loadGameModule("Generic")
        if not gameModule then
            warn("KingHub: Nenhum módulo encontrado para este jogo")
            return
        end
    end
    
    -- Criar logo interativa
    local logoButton, logoGui = createLogo()
    local mainWindow = nil
    
    -- Função para toggle da janela
    local function toggleWindow()
        if mainWindow then
            mainWindow:Minimize()
            mainWindow = nil
        else
            -- Criar janela principal
            mainWindow = Fluent:CreateWindow({
                Title = "KingHub - " .. gameModule.GameName,
                SubTitle = "v" .. gameModule.Version,
                TabWidth = 130,
                Size = UDim2.fromOffset(500, 420),
                Acrylic = true,
                Theme = KingHub.Config.UITheme,
                MinimizeKey = KingHub.Config.MinimizeKey
            })
            
            -- Carregar abas do módulo do jogo
            gameModule.CreateTabs(mainWindow, Fluent)
            
            -- Selecionar primeira aba
            mainWindow:SelectTab(1)
            
            -- Notificação de inicialização
            Fluent:Notify({
                Title = "KingHub Loaded!",
                Content = gameModule.GameName .. " hub activated!",
                Duration = 4
            })
        end
    end
    
    -- Configurar clique na logo
    logoButton.MouseButton1Click:Connect(toggleWindow)
    
    -- Animação de hover na logo
    logoButton.MouseEnter:Connect(function()
        game.TweenService:Create(logoButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.1,
            Size = UDim2.new(0, 65, 0, 65)
        }):Play()
    end)
    
    logoButton.MouseLeave:Connect(function()
        game.TweenService:Create(logoButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.3,
            Size = UDim2.new(0, 60, 0, 60)
        }):Play()
    end)
    
    -- Auto-load se configurado
    if KingHub.Config.AutoLoad then
        toggleWindow()
    end
    
    print("KingHub initialized for " .. gameModule.GameName)
end

-- Inicializar
local success, err = pcall(initializeKingHub)
if not success then
    warn("KingHub Error: " .. tostring(err))
    
    -- Fallback: criar logo simples
    local logo = Instance.new("ScreenGui")
    logo.Name = "KingHubFallback"
    logo.Parent = game.Players.LocalPlayer.PlayerGui
    
    local textBtn = Instance.new("TextButton")
    textBtn.Size = UDim2.new(0, 60, 0, 60)
    textBtn.Position = UDim2.new(0, 20, 0, 20)
    textBtn.Text = "KH"
    textBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    textBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBtn.Parent = logo
    
    textBtn.MouseButton1Click:Connect(function()
        Fluent:Notify({
            Title = "KingHub Error",
            Content = "Failed to load: " .. tostring(err),
            Duration = 5
        })
    end)
end
