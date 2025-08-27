return function(tab)
    -- Player section
    tab:AddSection("Player")
    
    local WalkSpeedSlider = tab:AddSlider("WalkSpeedSlider", {
        Title = "Walk Speed",
        Description = "Adjust your movement speed",
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
    
    local JumpPowerSlider = tab:AddSlider("JumpPowerSlider", {
        Title = "Jump Power",
        Description = "Adjust your jump height",
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
    
    -- Game section
    tab:AddSection("Game")
    
    local InfMoneyToggle = tab:AddToggle("InfMoneyToggle", {
        Title = "Infinite Money",
        Description = "Gain unlimited currency",
        Default = false,
        Callback = function(value)
            -- Implementation for infinite money
        end
    })
    
    local NoClipToggle = tab:AddToggle("NoClipToggle", {
        Title = "NoClip",
        Description = "Walk through walls",
        Default = false,
        Callback = function(value)
            -- Implementation for noclip
        end
    })
    
    local GodModeToggle = tab:AddToggle("GodModeToggle", {
        Title = "God Mode",
        Description = "Become invincible",
        Default = false,
        Callback = function(value)
            -- Implementation for god mode
        end
    })
end
