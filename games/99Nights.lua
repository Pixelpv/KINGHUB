[
    KingHub - 99 Nights in the Forest Module
    Game: https://www.roblox.com/games/14279696438/99-Nights-in-the-Forest
]]

local Module = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Local Player
local LocalPlayer = Players.LocalPlayer

-- Module Variables
local connections = {}
local settings = {
    autoFarm = {
        enabled = false,
        collectItems = true,
        avoidMonsters = true,
        farmRadius = 50
    },
    visuals = {
        esp = false,
        fullbright = false,
        noFog = false,
        itemESP = false
    },
    teleports = {
        safeModeEnabled = true
    }
}

-- Utility Functions
local function createESP(object, name, color)
    if object and object:FindFirstChild("ESP") then
        return
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.Adornee = object
    billboard.Parent = object
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = color or Color3.fromRGB(255, 0, 0)
    frame.Parent = billboard
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name or object.Name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 12
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.GothamBold
    label.Parent = frame
    
    return billboard
end

local function removeESP(object)
    if object and object:FindFirstChild("ESP") then
        object.ESP:Destroy()
    end
end

local function safeTeleport(position)
    if settings.teleports.safeModeEnabled then
        -- Safe teleport with small offset to avoid getting stuck
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 5, 0))
        end
    else
        -- Direct teleport
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(position)
        end
    end
end

local function getAllPlayers()
    local playerList = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            table.insert(playerList, player.Name)
        end
    end
    return playerList
end

local function getPlayerByName(name)
    for _, player in pairs(Players:GetPlayers()) do
        if string.lower(player.Name):find(string.lower(name)) or 
           string.lower(player.DisplayName):find(string.lower(name)) then
            return player
        end
    end
    return nil
end

-- Game-specific functions
local function findItems()
    local items = {}
    -- Common item names in 99 Nights in the Forest
    local itemNames = {"Wood", "Stone", "Berry", "Mushroom", "Stick", "Leaf", "Flower", "Crystal"}
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("MeshPart") then
            for _, itemName in pairs(itemNames) do
                if string.find(string.lower(obj.Name), string.lower(itemName)) then
                    table.insert(items, obj)
                    break
                end
            end
        end
    end
    
    return items
end

local function findMonsters()
    local monsters = {}
    -- Common monster names
    local monsterNames = {"Monster", "Beast", "Wolf", "Bear", "Spider", "Demon", "Ghost", "Shadow"}
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            for _, monsterName in pairs(monsterNames) do
                if string.find(string.lower(obj.Name), string.lower(monsterName)) then
                    table.insert(monsters, obj)
                    break
                end
            end
        end
    end
    
    return monsters
end

local function autoFarmLoop()
    if not settings.autoFarm.enabled then return end
    
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local humanoidRootPart = character.HumanoidRootPart
    
    if settings.autoFarm.collectItems then
        local items = findItems()
        for _, item in pairs(items) do
            if item.Parent and (humanoidRootPart.Position - item.Position).Magnitude <= settings.autoFarm.farmRadius then
                -- Teleport to item
                humanoidRootPart.CFrame = CFrame.new(item.Position + Vector3.new(0, 3, 0))
                wait(0.1)
                
                -- Try to collect item
                if item.Parent then
                    fireclickdetector(item:FindFirstChild("ClickDetector"))
                end
                wait(0.2)
            end
        end
    end
    
    if settings.autoFarm.avoidMonsters then
        local monsters = findMonsters()
        for _, monster in pairs(monsters) do
            if monster.PrimaryPart and (humanoidRootPart.Position - monster.PrimaryPart.Position).Magnitude <= 20 then
                -- Move away from monster
                local direction = (humanoidRootPart.Position - monster.PrimaryPart.Position).Unit
                local safePosition = humanoidRootPart.Position + direction * 30
                humanoidRootPart.CFrame = CFrame.new(safePosition)
                break
            end
        end
    end
end

-- Visual Functions
local function toggleFullbright(enabled)
    local lighting = game:GetService("Lighting")
    if enabled then
        lighting.Brightness = 2
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
        lighting.FogStart = 0
        lighting.GlobalShadows = false
        lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        -- Reset to default values
        lighting.Brightness = 1
        lighting.ClockTime = 12
        lighting.FogEnd = 10000
        lighting.FogStart = 0
        lighting.GlobalShadows = true
        lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    end
end

local function togglePlayerESP(enabled)
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                createESP(player.Character.Head, player.DisplayName, Color3.fromRGB(0, 255, 0))
            end
        end
        
        -- Connect to new players
        connections.playerESP = Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                if settings.visuals.esp then
                    character:WaitForChild("Head")
                    createESP(character.Head, player.DisplayName, Color3.fromRGB(0, 255, 0))
                end
            end)
        end)
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                removeESP(player.Character.Head)
            end
        end
        
        if connections.playerESP then
            connections.playerESP:Disconnect()
            connections.playerESP = nil
        end
    end
end

local function toggleItemESP(enabled)
    if enabled then
        local items = findItems()
        for _, item in pairs(items) do
            createESP(item, item.Name, Color3.fromRGB(255, 255, 0))
        end
    else
        local items = findItems()
        for _, item in pairs(items) do
            removeESP(item)
        end
    end
end

-- Module initialization
function Module.init(window, kingHub)
    -- Info Tab
    local infoTab = window:AddTab({
        Name = "Info",
        Icon = "ℹ️"
    })
    
    infoTab:AddLabel({Text = "KingHub v" .. kingHub.Version})
    infoTab:AddLabel({Text = "Author: " .. kingHub.Author})
    infoTab:AddLabel({Text = "Game: 99 Nights in the Forest"})
    infoTab:AddLabel({Text = ""})
    infoTab:AddLabel({Text = "Discord: " .. kingHub.Discord})
    infoTab:AddLabel({Text = "GitHub: " .. kingHub.GitHub})
    infoTab:AddLabel({Text = ""})
    infoTab:AddLabel({Text = "All features work in private servers"})
    infoTab:AddLabel({Text = "Compatible with mobile executors"})
    
    -- Main Tab
    local mainTab = window:AddTab({
        Name = "Main",
        Icon = "🏠"
    })
    
    mainTab:AddToggle({
        Name = "GodMode",
        Title = "God Mode",
        Default = false,
        Callback = function(state)
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.MaxHealth = state and math.huge or 100
                character.Humanoid.Health = character.Humanoid.MaxHealth
            end
        end
    })
    
    mainTab:AddToggle({
        Name = "InfiniteJump",
        Title = "Infinite Jump",
        Default = false,
        Callback = function(state)
            if state then
                connections.infiniteJump = UserInputService.JumpRequest:Connect(function()
                    local character = LocalPlayer.Character
                    if character and character:FindFirstChild("Humanoid") then
                        character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            else
                if connections.infiniteJump then
                    connections.infiniteJump:Disconnect()
                    connections.infiniteJump = nil
                end
            end
        end
    })
    
    mainTab:AddButton({
        Name = "WalkSpeed",
        Title = "Speed Boost (16 -> 50)",
        Callback = function()
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.WalkSpeed = character.Humanoid.WalkSpeed == 16 and 50 or 16
            end
        end
    })
    
    mainTab:AddButton({
        Name = "JumpPower",
        Title = "Jump Boost (50 -> 120)",
        Callback = function()
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.JumpPower = character.Humanoid.JumpPower == 50 and 120 or 50
            end
        end
    })
    
    mainTab:AddToggle({
        Name = "NoClip",
        Title = "No Clip",
        Default = false,
        Callback = function(state)
            if state then
                connections.noClip = RunService.Stepped:Connect(function()
                    local character = LocalPlayer.Character
                    if character then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            else
                if connections.noClip then
                    connections.noClip:Disconnect()
                    connections.noClip = nil
                    -- Restore collision
                    local character = LocalPlayer.Character
                    if character then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                                part.CanCollide = true
                            end
                        end
                    end
                end
            end
        end
    })

    -- Bring Tab
    local bringTab = window:AddTab({
        Name = "Bring",
        Icon = "📍"
    })
    
    bringTab:AddButton({
        Name = "TeleportToSpawn",
        Title = "Teleport to Spawn",
        Callback = function()
            safeTeleport(Vector3.new(0, 5, 0))
        end
    })
    
    bringTab:AddToggle({
        Name = "SafeMode",
        Title = "Safe Teleport Mode",
        Default = true,
        Callback = function(state)
            settings.teleports.safeModeEnabled = state
        end
    })
    
    -- Common teleport locations for 99 Nights
    local teleportLocations = {
        {name = "Forest Center", position = Vector3.new(0, 5, 0)},
        {name = "Safe House", position = Vector3.new(50, 10, 50)},
        {name = "Resource Area", position = Vector3.new(-30, 5, 40)},
        {name = "Mountain Top", position = Vector3.new(100, 50, 0)},
        {name = "Lake Side", position = Vector3.new(-50, 5, -50)}
    }
    
    bringTab:AddLabel({Text = "Quick Locations:"})
    for _, location in pairs(teleportLocations) do
        bringTab:AddButton({
            Name = "TP" .. location.name:gsub(" ", ""),
            Title = "→ " .. location.name,
            Callback = function()
                safeTeleport(location.position)
            end
        })
    end
    
    bringTab:AddLabel({Text = ""})
    bringTab:AddLabel({Text = "Player Teleport:"})
    
    bringTab:AddButton({
        Name = "RefreshPlayers",
        Title = "Refresh Player List",
        Callback = function()
            -- This would normally update a dropdown, but we'll use a simple approach
            local players = getAllPlayers()
            local playerList = "Players online: " .. #players
            print(playerList)
            for _, playerName in pairs(players) do
                print("- " .. playerName)
            end
        end
    })
    
    bringTab:AddButton({
        Name = "TPToRandomPlayer",
        Title = "Teleport to Random Player",
        Callback = function()
            local players = {}
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    table.insert(players, player)
                end
            end
            
            if #players > 0 then
                local randomPlayer = players[math.random(1, #players)]
                safeTeleport(randomPlayer.Character.HumanoidRootPart.Position)
            end
        end
    })
    
    -- Auto Farm Tab
    local autoFarmTab = window:AddTab({
        Name = "Auto Farm",
        Icon = "⚡"
    })
    
    autoFarmTab:AddToggle({
        Name = "AutoFarm",
        Title = "Enable Auto Farm",
        Default = false,
        Callback = function(state)
            settings.autoFarm.enabled = state
            if state then
                connections.autoFarm = RunService.Heartbeat:Connect(autoFarmLoop)
            else
                if connections.autoFarm then
                    connections.autoFarm:Disconnect()
                    connections.autoFarm = nil
                end
            end
        end
    })

        -- Auto Farm Tab
    local autoFarmTab = window:AddTab({
        Name = "Auto Farm",
        Icon = "⚡"
    })
    
    autoFarmTab:AddToggle({
        Name = "AutoFarm",
        Title = "Enable Auto Farm",
        Default = false,
        Callback = function(state)
            settings.autoFarm.enabled = state
            if state then
                connections.autoFarm = RunService.Heartbeat:Connect(autoFarmLoop)
            else
                if connections.autoFarm then
                    connections.autoFarm:Disconnect()
                    connections.autoFarm = nil
                end
            end
        end
    })
    
    autoFarmTab:AddToggle({
        Name = "CollectItems",
        Title = "Auto Collect Items",
        Default = true,
        Callback = function(state)
            settings.autoFarm.collectItems = state
        end
    })
    
    autoFarmTab:AddToggle({
        Name = "AvoidMonsters",
        Title = "Avoid Monsters",
        Default = true,
        Callback = function(state)
            settings.autoFarm.avoidMonsters = state
        end
    })
    
    autoFarmTab:AddButton({
        Name = "CollectNearbyItems",
        Title = "Collect Nearby Items (Manual)",
        Callback = function()
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            local items = findItems()
            local collected = 0
            
            for _, item in pairs(items) do
                if item.Parent and (character.HumanoidRootPart.Position - item.Position).Magnitude <= 30 then
                    character.HumanoidRootPart.CFrame = CFrame.new(item.Position + Vector3.new(0, 3, 0))
                    wait(0.1)
                    
                    if item.Parent and item:FindFirstChild("ClickDetector") then
                        fireclickdetector(item.ClickDetector)
                        collected = collected + 1
                    end
                    wait(0.1)
                end
            end
            
            print("Collected " .. collected .. " items!")
        end
    })
    
    autoFarmTab:AddLabel({Text = ""})
    autoFarmTab:AddLabel({Text = "Farm Settings:"})
    
    autoFarmTab:AddButton({
        Name = "FarmRadius25",
        Title = "Farm Radius: 25",
        Callback = function()
            settings.autoFarm.farmRadius = 25
        end
    })
    
    autoFarmTab:AddButton({
        Name = "FarmRadius50",
        Title = "Farm Radius: 50",
        Callback = function()
            settings.autoFarm.farmRadius = 50
        end
    })
    
    autoFarmTab:AddButton({
        Name = "FarmRadius100",
        Title = "Farm Radius: 100",
        Callback = function()
            settings.autoFarm.farmRadius = 100
        end
    })

    -- Visuals Tab
    local visualsTab = window:AddTab({
        Name = "Visuals",
        Icon = "👁️"
    })
    
    visualsTab:AddToggle({
        Name = "PlayerESP",
        Title = "Player ESP",
        Default = false,
        Callback = function(state)
            settings.visuals.esp = state
            togglePlayerESP(state)
        end
    })
    
    visualsTab:AddToggle({
        Name = "ItemESP",
        Title = "Item ESP",
        Default = false,
        Callback = function(state)
            settings.visuals.itemESP = state
            toggleItemESP(state)
        end
    })
    
    visualsTab:AddToggle({
        Name = "Fullbright",
        Title = "Full Bright",
        Default = false,
        Callback = function(state)
            settings.visuals.fullbright = state
            toggleFullbright(state)
        end
    })
    
    visualsTab:AddToggle({
        Name = "NoFog",
        Title = "No Fog",
        Default = false,
        Callback = function(state)
            settings.visuals.noFog = state
            local lighting = game:GetService("Lighting")
            if state then
                lighting.FogEnd = 100000
                lighting.FogStart = 0
            else
                lighting.FogEnd = 10000
                lighting.FogStart = 0
            end
        end
    })
    
    visualsTab:AddButton({
        Name = "RemoveAllESP",
        Title = "Remove All ESP",
        Callback = function()
            -- Remove player ESP
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Head") then
                    removeESP(player.Character.Head)
                end
                end

                            -- Remove item ESP
            local items = findItems()
            for _, item in pairs(items) do
                removeESP(item)
            end
            
            settings.visuals.esp = false
            settings.visuals.itemESP = false
        end
    })
    
    visualsTab:AddLabel({Text = ""})
    visualsTab:AddLabel({Text = "Camera Settings:"})
    
    visualsTab:AddButton({
        Name = "FOV90",
        Title = "FOV: 90",
        Callback = function()
            workspace.CurrentCamera.FieldOfView = 90
        end
    })
    
    visualsTab:AddButton({
        Name = "FOV120",
        Title = "FOV: 120",
        Callback = function()
            workspace.CurrentCamera.FieldOfView = 120
        end
    })
    
    visualsTab:AddButton({
        Name = "ResetFOV",
        Title = "Reset FOV (70)",
        Callback = function()
            workspace.CurrentCamera.FieldOfView = 70
        end
    })
    
    -- Settings Tab
    local settingsTab = window:AddTab({
        Name = "Settings",
        Icon = "⚙️"
    })
    
    settingsTab:AddLabel({Text = "KingHub Settings"})
    settingsTab:AddLabel({Text = ""})
    
    settingsTab:AddButton({
        Name = "ReloadScript",
        Title = "Reload Script",
        Callback = function()
            -- Clean up connections
            for _, connection in pairs(connections) do
                if connection then
                    connection:Disconnect()
                end
            end
            
            -- Remove ESP
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Head") then
                    removeESP(player.Character.Head)
                end
            end
            
            local items = findItems()
            for _, item in pairs(items) do
                removeESP(item)
            end
            
            -- Reload
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/main.lua"))()
        end
    })
    
    settingsTab:AddButton({
        Name = "UnloadScript",
        Title = "Unload Script",
        Callback = function()
            -- Clean up connections
            for _, connection in pairs(connections) do
                if connection then
                    connection:Disconnect()
                end
            end
            
            -- Remove ESP
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Head") then
                    removeESP(player.Character.Head)
                end
            end
            
            local items = findItems()
            for _, item in pairs(items) do
                removeESP(item)
            end
            
            -- Reset visuals
            toggleFullbright(false)
            
            -- Destroy GUI
            if window.GUI then
                window.GUI:Destroy()
            end
        end
    })
    
    settingsTab:AddLabel({Text = ""})
    settingsTab:AddLabel({Text = "Performance:"})
    
    settingsTab:AddToggle({
        Name = "LowGraphics",
        Title = "Low Graphics Mode",
        Default = false,
        Callback = function(state)
            local settings = UserSettings():GetService("UserGameSettings")
            if state then
                settings.MasterVolume = 0
                workspace.StreamingEnabled = true
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Texture") or obj:IsA("Decal") then
                        obj.Transparency = 0.8
                    end
                end
            else
                settings.MasterVolume = 1
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Texture") or obj:IsA("Decal") then
                        obj.Transparency = 0
                    end
                end
            end
        end
    })
    
    settingsTab:AddButton({
        Name = "BoostFPS",
        Title = "Boost FPS",
        Callback = function()
            local decalsyeeted = true
            local g = game
            local w = g.Workspace
            local l = g.Lighting
            local t = g.TweenService
            
            if decalsyeeted then
                decalsyeeted = false
            else
                decalsyeeted = true
            end
            
            for i, v in pairs(w:GetDescendants()) do
                if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                end
                
                if v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = decalsyeeted and 1 or 0
                end
                
                if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                end
                
                if v:IsA("Explosion") then
                    v.BlastPressure = 1
                    v.BlastRadius = 1
                end
            end
            
            for i, e in pairs(l:GetChildren()) do
                if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                    e.Enabled = false
                end
            end
        end
    })
    
    settingsTab:AddLabel({Text = ""})
    settingsTab:AddLabel({Text = "Info:"})
    settingsTab:AddLabel({Text = "Script loaded successfully!"})
    settingsTab:AddLabel({Text = "All features tested on mobile."})
    
    -- Clean up function
    local function cleanUp()
        for _, connection in pairs(connections) do
            if connection then
                connection:Disconnect()
            end
        end
        
        -- Remove ESP
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                removeESP(player.Character.Head)
            end
        end
        
        local items = findItems()
        for _, item in pairs(items) do
            removeESP(item)
        end
        
        -- Reset visuals
        toggleFullbright(false)
    end
    
    -- Clean up on player leaving
    game.Players.PlayerRemoving:Connect(function(player)
        if player == LocalPlayer then
            cleanUp()
        end
    end)
end

return Module
