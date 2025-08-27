return function(tab)
    tab:AddSection("Configuration")
    
    local UIScaleSlider = tab:AddSlider("UIScaleSlider", {
        Title = "UI Scale",
        Description = "Adjust the interface size",
        Default = 100,
        Min = 50,
        Max = 150,
        Rounding = 0,
        Callback = function(value)
            -- Implementation for UI scaling
        end
    })
    
    local TransparencySlider = tab:AddSlider("TransparencySlider", {
        Title = "UI Transparency",
        Description = "Adjust interface transparency",
        Default = 0,
        Min = 0,
        Max = 80,
        Rounding = 0,
        Callback = function(value)
            -- Implementation for UI transparency
        end
    })
    
    tab:AddSection("Preferences")
    
    local AutoLoadToggle = tab:AddToggle("AutoLoadToggle", {
        Title = "Auto Load on Launch",
        Description = "Automatically load the script when game starts",
        Default = true,
        Callback = function(value)
            -- Implementation for auto load
        end
    })
    
    local SaveConfigButton = tab:AddButton({
        Title = "Save Configuration",
        Description = "Save current settings",
        Callback = function()
            -- Implementation for saving configuration
        end
    })
    
    local LoadConfigButton = tab:AddButton({
        Title = "Load Configuration",
        Description = "Load saved settings",
        Callback = function()
            -- Implementation for loading configuration
        end
    })
    
    tab:AddSection("Information")
    
    local UnloadButton = tab:AddButton({
        Title = "Unload KingHub",
        Description = "Close the interface",
        Callback = function()
            -- Implementation for unloading
        end
    })
end
