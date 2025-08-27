return function(tab)
    tab:AddSection("Teleport")
    
    local PlayerTextBox = tab:AddInput("PlayerName", {
        Title = "Player Name",
        Placeholder = "Enter player name",
        Default = "",
        Numeric = false,
        Finished = false,
        Callback = function(value) end
    })
    
    local BringButton = tab:AddButton({
        Title = "Bring Player",
        Description = "Teleport player to you",
        Callback = function()
            -- Implementation to bring player
        end
    })
    
    local GotoButton = tab:AddButton({
        Title = "Go to Player",
        Description = "Teleport to player",
        Callback = function()
            -- Implementation to go to player
        end
    })
    
    tab:AddSection("Locations")
    
    local LocationsDropdown = tab:AddDropdown("LocationsDropdown", {
        Title = "Predefined Locations",
        Description = "Teleport to important locations",
        Values = {"Spawn", "Forest", "Cave", "Village", "Lake"},
        Default = 1,
        Callback = function(value)
            -- Implementation for location teleport
        end
    })
    
    local TeleportButton = tab:AddButton({
        Title = "Teleport to Location",
        Description = "Go to selected location",
        Callback = function()
            local location = LocationsDropdown.Value
            -- Implementation for location teleport
        end
    })
end
