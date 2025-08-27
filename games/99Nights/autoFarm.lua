return function(tab)
    tab:AddSection("Auto Farm")
    
    local AutoFarmToggle = tab:AddToggle("AutoFarmToggle", {
        Title = "Enable Auto Farm",
        Description = "Automatically collect resources",
        Default = false,
        Callback = function(value)
            -- Implementation for auto farm
        end
    })
    
    local FarmSpeedSlider = tab:AddSlider("FarmSpeedSlider", {
        Title = "Farm Speed",
        Description = "Adjust farming speed",
        Default = 1,
        Min = 1,
        Max = 10,
        Rounding = 1,
        Callback = function(value)
            -- Implementation for farm speed adjustment
        end
    })
    
    tab:AddSection("Resources")
    
    local WoodToggle = tab:AddToggle("WoodToggle", {
        Title = "Farm Wood",
        Description = "Automatically collect wood",
        Default = false,
        Callback = function(value)
            -- Implementation for wood farming
        end
    })
    
    local StoneToggle = tab:AddToggle("StoneToggle", {
        Title = "Farm Stone",
        Description = "Automatically collect stone",
        Default = false,
        Callback = function(value)
            -- Implementation for stone farming
        end
    })
    
    local OreToggle = tab:AddToggle("OreToggle", {
        Title = "Farm Ore",
        Description = "Automatically collect ore",
        Default = false,
        Callback = function(value)
            -- Implementation for ore farming
        end
    })
end
