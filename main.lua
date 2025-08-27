--[[
    KingHub - Universal Game Hub
    Author: YourName
    Version: 1.0.0
    GitHub: https://github.com/Pixelpv/KINGHUB.git
]]

local KingHub = {}
KingHub.Version = "1.0.0"
KingHub.Author = "YourName"
KingHub.Discord = "https://discord.gg/your-discord"
KingHub.GitHub = "https://github.com/Pixelpv/KINGHUB.git"

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Local Player
local LocalPlayer = Players.LocalPlayer

-- Game Detection
local function detectGame()
    local placeId = game.PlaceId
    local gameConfigs = {
        [14279696438] = "99Nights", -- 99 Nights in the Forest
        -- Add more games here
    }
    
    return gameConfigs[placeId]
end

-- Load Game-Specific Module
local function loadGameModule(gameName)
    local success, gameModule = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/games/" .. gameName .. ".lua"))()
    end)
    
    if success and gameModule then
        return gameModule
    else
        warn("Failed to load game module:", gameName)
        return nil
    end
end

-- Mobile Detection
local function isMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

-- Fluent UI Library (Simplified version)
local FluentUI = {}

function FluentUI:CreateWindow(config)
    local window = {
        Title = config.Title or "KingHub",
        Tabs = {},
        ActiveTab = nil,
        GUI = nil
    }
    
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KingHub"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    
    -- Check if running in CoreGui or PlayerGui
    local success = pcall(function()
        screenGui.Parent = CoreGui
    end)
    if not success then
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- Corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- Shadow effect
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.8
    shadow.BorderSizePixel = 0
    shadow.ZIndex = -1
    shadow.Parent = mainFrame
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 12)
    shadowCorner.Parent = shadow
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    -- Fix title bar corners
    local titleFix = Instance.new("Frame")
    titleFix.Size = UDim2.new(1, 0, 0, 12)
    titleFix.Position = UDim2.new(0, 0, 1, -12)
    titleFix.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleFix.BorderSizePixel = 0
    titleFix.Parent = titleBar
    
    -- Title Label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = window.Title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.Parent = titleBar
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 96, 92)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Tab Container
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(0, 120, 1, -40)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = mainFrame
    
    -- Content Container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(1, -120, 1, -40)
    contentContainer.Position = UDim2.new(0, 120, 0, 40)
    contentContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    contentContainer.BorderSizePixel = 0
    contentContainer.Parent = mainFrame
    
    -- Content corner
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 0)
    contentCorner.Parent = contentContainer
    
    window.GUI = screenGui
    window.MainFrame = mainFrame
    window.TabContainer = tabContainer
    window.ContentContainer = contentContainer
    
    -- Tab functions
    function window:AddTab(config)
        local tab = {
            Name = config.Name or "Tab",
            Icon = config.Icon or "",
            Elements = {},
            Frame = nil,
            Button = nil
        }
        
        -- Tab Button
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tab.Name .. "Button"
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.Position = UDim2.new(0, 0, 0, #self.Tabs * 40)
        tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tabButton.BorderSizePixel = 0
        tabButton.Text = tab.Icon .. " " .. tab.Name
        tabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
        tabButton.TextSize = 14
        tabButton.TextXAlignment = Enum.TextXAlignment.Left
        tabButton.Font = Enum.Font.Gotham
        tabButton.Parent = self.TabContainer
        
        -- Tab button padding
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 15)
        padding.Parent = tabButton
        
        -- Tab Content Frame
        local tabFrame = Instance.new("ScrollingFrame")
        tabFrame.Name = tab.Name .. "Frame"
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.BorderSizePixel = 0
        tabFrame.ScrollBarThickness = 6
        tabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabFrame.Visible = false
        tabFrame.Parent = self.ContentContainer
        
        -- Auto-resize canvas
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabFrame
        
        layout.Changed:Connect(function()
            tabFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
        end)
        
        -- Padding for content
        local contentPadding = Instance.new("UIPadding")
        contentPadding.PaddingTop = UDim.new(0, 10)
        contentPadding.PaddingLeft = UDim.new(0, 15)
        contentPadding.PaddingRight = UDim.new(0, 15)
        contentPadding.Parent = tabFrame
        
        tab.Frame = tabFrame
        tab.Button = tabButton
        
        -- Tab switching
        tabButton.MouseButton1Click:Connect(function()
            self:SelectTab(tab.Name)
        end)
        
        -- Tab element creation functions
        function tab:AddButton(config)
            local button = Instance.new("TextButton")
            button.Name = config.Name or "Button"
            button.Size = UDim2.new(1, -30, 0, 35)
            button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            button.BorderSizePixel = 0
            button.Text = config.Title or "Button"
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.TextSize = 14
            button.Font = Enum.Font.Gotham
            button.Parent = self.Frame
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 6)
            buttonCorner.Parent = button
            
            if config.Callback then
                button.MouseButton1Click:Connect(config.Callback)
            end
            
            return button
        end
        
        function tab:AddToggle(config)
            local toggle = {
                Name = config.Name or "Toggle",
                Value = config.Default or false,
                Callback = config.Callback
            }
            
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Name = toggle.Name .. "Frame"
            toggleFrame.Size = UDim2.new(1, -30, 0, 35)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            toggleFrame.BorderSizePixel = 0
            toggleFrame.Parent = self.Frame
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggleFrame
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(1, -50, 1, 0)
            toggleLabel.Position = UDim2.new(0, 15, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = config.Title or "Toggle"
            toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleLabel.TextSize = 14
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.Parent = toggleFrame
            
            local toggleButton = Instance.new("TextButton")
            toggleButton.Size = UDim2.new(0, 40, 0, 20)
            toggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            toggleButton.BackgroundColor3 = toggle.Value and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(60, 60, 60)
            toggleButton.BorderSizePixel = 0
            toggleButton.Text = ""
            toggleButton.Parent = toggleFrame
            
            local toggleButtonCorner = Instance.new("UICorner")
            toggleButtonCorner.CornerRadius = UDim.new(0, 10)
            toggleButtonCorner.Parent = toggleButton
            
            local toggleIndicator = Instance.new("Frame")
            toggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            toggleIndicator.Position = toggle.Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleIndicator.BorderSizePixel = 0
            toggleIndicator.Parent = toggleButton
            
            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 8)
            indicatorCorner.Parent = toggleIndicator
            
            local function updateToggle()
                local targetColor = toggle.Value and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(60, 60, 60)
                local targetPosition = toggle.Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                
                TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(0.2), {Position = targetPosition}):Play()
                
                if toggle.Callback then
                    toggle.Callback(toggle.Value)
                end
            end
            
            toggleButton.MouseButton1Click:Connect(function()
                toggle.Value = not toggle.Value
                updateToggle()
            end)
            
            function toggle:Set(value)
                self.Value = value
                updateToggle()
            end
            
            return toggle
        end
        
        function tab:AddLabel(config)
            local label = Instance.new("TextLabel")
            label.Name = config.Name or "Label"
            label.Size = UDim2.new(1, -30, 0, 25)
            label.BackgroundTransparency = 1
            label.Text = config.Text or "Label"
            label.TextColor3 = Color3.fromRGB(200, 200, 200)
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Font = Enum.Font.Gotham
            label.Parent = self.Frame
            
            return label
        end
        
        table.insert(self.Tabs, tab)
        
        -- Select first tab by default
        if #self.Tabs == 1 then
            self:SelectTab(tab.Name)
        end
        
        return tab
    end
    
    function window:SelectTab(tabName)
        for _, tab in pairs(self.Tabs) do
            if tab.Name == tabName then
                -- Show selected tab
                tab.Frame.Visible = true
                tab.Button.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
                tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                self.ActiveTab = tab
            else
                -- Hide other tabs
                tab.Frame.Visible = false
                tab.Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                tab.Button.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
    end
    
    return window
end

-- Initialize KingHub
local function initializeKingHub()
    local detectedGame = detectGame()
    
    if not detectedGame then
        warn("Game not supported by KingHub")
        return
    end
    
    -- Create main window
    local window = FluentUI:CreateWindow({
        Title = "KingHub v" .. KingHub.Version
    })
    
    -- Load game-specific module
    local gameModule = loadGameModule(detectedGame)
    
    if gameModule then
        -- Initialize game module with window
        gameModule.init(window, KingHub)
    else
        -- Create basic info tab if game module fails
        local infoTab = window:AddTab({
            Name = "Info",
            Icon = "ℹ️"
        })
        
        infoTab:AddLabel({Text = "KingHub v" .. KingHub.Version})
        infoTab:AddLabel({Text = "Author: " .. KingHub.Author})
        infoTab:AddLabel({Text = "Game module failed to load"})
    end
    
    return window
end

-- Auto-execute
if game:IsLoaded() then
    initializeKingHub()
else
    game.Loaded:Wait()
    initializeKingHub()
end
