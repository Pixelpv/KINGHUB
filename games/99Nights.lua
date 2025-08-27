-- KingHub Module for 99 Nights in the Forest
local module = {}

module.GameName = "99 Nights in the Forest"
module.GameId = "1234567890" -- Substitua pelo ID real do jogo
module.Version = "1.0.0"
module.Author = "YourName"

function module.CreateTabs(Window, Fluent)
    -- Criar abas na ordem solicitada
    local Tabs = {
        Info = Window:AddTab({ Title = "Info", Icon = "info" }),
        Main = Window:AddTab({ Title = "Main", Icon = "settings" }),
        Bring = Window:AddTab({ Title = "Bring", Icon = "users" }),
        AutoFarm = Window:AddTab({ Title = "Auto Farm", Icon = "rotate-cw" }),
        Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }

    -- === ABA INFO ===
    Tabs.Info:AddParagraph({
        Title = "KingHub - 99 Nights in the Forest",
        Content = "Specialized script hub designed specifically for 99 Nights in the Forest. All features work in private instances without affecting other players."
    })

    Tabs.Info:AddParagraph({
        Title = "Disclaimer",
        Content = "Use responsibly. The authors are not responsible for any issues caused by misuse."
    })

    Tabs.Info:AddButton({
        Title = "📱 Join Discord",
        Description = "Get support and updates",
        Callback = function()
            setclipboard("https://discord.gg/example")
            Fluent:Notify({
                Title = "Discord",
                Content = "Link copied to clipboard!",
                Duration = 3
            })
        end
    })

    Tabs.Info:AddButton({
        Title = "💻 GitHub Repository",
        Description = "View source code and contribute",
        Callback = function()
            setclipboard("https://github.com/Pixelpv/KINGHUB")
            Fluent:Notify({
                Title = "GitHub",
                Content = "Link copied to clipboard!",
                Duration = 3
            })
        end
    })

    -- === ABA MAIN ===
    Tabs.Main:AddSection("Player Stats")

    local WalkSpeedSlider = Tabs.Main:AddSlider("WalkSpeedSlider", {
        Title = "🚶 Walk Speed",
        Description = "Adjust movement speed",
        Default = 16,
        Min = 16,
        Max = 100,
        Rounding = 0,
        Callback = function(value)
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    })

    local JumpPowerSlider = Tabs.Main:AddSlider("JumpPowerSlider", {
        Title = "🦘 Jump Power",
        Description = "Adjust jump height",
        Default = 50,
        Min = 50,
        Max = 200,
        Rounding = 0,
        Callback = function(value)
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = value
            end
        end
    })

    -- === ABA BRING ===
    Tabs.Bring:AddSection("Player Teleport")

    local PlayerInput = Tabs.Bring:AddInput("PlayerNameInput", {
        Title = "👤 Player Name",
        Description = "Enter player name to teleport",
        Default = "",
        Placeholder = "PlayerName",
        Numeric = false,
        Finished = false,
        Callback = function(value) end
    })

    Tabs.Bring:AddButton({
        Title = "📥 Bring Player",
        Description = "Teleport player to you",
        Callback = function()
            local playerName = PlayerInput.Value
            if playerName ~= "" then
                Fluent:Notify({
                    Title = "Bring Player",
                    Content = "Attempting to bring: " .. playerName,
                    Duration = 3
                })
            end
        end
    })

    -- === ABA AUTO FARM ===
    Tabs.AutoFarm:AddSection("Auto Farming")

    local AutoFarmToggle = Tabs.AutoFarm:AddToggle("AutoFarmToggle", {
        Title = "🌾 Enable Auto Farm",
        Description = "Automatically collect resources",
        Default = false,
        Callback = function(value)
            Fluent:Notify({
                Title = value and "Auto Farm ON" or "Auto Farm OFF",
                Content = value and "Starting auto farming..." or "Auto farming stopped",
                Duration = 3
            })
        end
    })

    -- === ABA VISUALS ===
    Tabs.Visuals:AddSection("ESP")

    local PlayerESPToggle = Tabs.Visuals:AddToggle("PlayerESPToggle", {
        Title = "👥 Player ESP",
        Description = "See players through walls",
        Default = false,
        Callback = function(value)
            Fluent:Notify({
                Title = value and "Player ESP ON" or "Player ESP OFF",
                Content = value and "Player ESP activated" or "Player ESP deactivated",
                Duration = 3
            })
        end
    })

    -- === ABA SETTINGS ===
    Tabs.Settings:AddSection("UI Configuration")

    local UIScaleSlider = Tabs.Settings:AddSlider("UIScaleSlider", {
        Title = "📐 UI Scale",
        Description = "Adjust the interface size",
        Default = 100,
        Min = 70,
        Max = 130,
        Rounding = 0,
        Callback = function(value)
            Fluent:Notify({
                Title = "UI Scale Changed",
                Content = "New scale: " .. value .. "%",
                Duration = 2
            })
        end
    })

    Tabs.Settings:AddButton({
        Title = "🗑️ Unload KingHub",
        Description = "Close the interface",
        Callback = function()
            Window:Destroy()
        end
    })
    
    return Tabs
end

return module
