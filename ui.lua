return function(Fluent, Utils, Loader)
    -- Create the interface window
    local Window = Fluent:CreateWindow({
        Title = "KingHub - 99 Nights in the Forest",
        SubTitle = "v1.0.0",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.RightShift
    })
    
    -- Create tabs
    local Tabs = {
        Info = Window:AddTab({Title = "Info", Icon = "info"}),
        Main = Window:AddTab({Title = "Main", Icon = "settings"}),
        Bring = Window:AddTab({Title = "Bring", Icon = "users"}),
        AutoFarm = Window:AddTab({Title = "Auto Farm", Icon = "rotate-cw"}),
        Visuals = Window:AddTab({Title = "Visuals", Icon = "eye"}),
        Settings = Window:AddTab({Title = "Settings", Icon = "settings"})
    }
    
    -- Load game-specific modules
    Loader.loadTabs(Tabs)
    
    -- Select the Info tab by default
    Window:SelectTab(1)
    
    -- Apply settings from configuration
    Fluent:ApplyTheme(Window)
end
