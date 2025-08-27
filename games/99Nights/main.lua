local Main = {}
local Info = require(script.Parent.info)

function Main:Init(MainWindow)
    -- Cria todas as abas na ordem correta
    local InfoTab = MainWindow:NewTab("Info")
    local MainTab = MainWindow:NewTab("Main")
    local BringTab = MainWindow:NewTab("Bring")
    local AutoFarmTab = MainWindow:NewTab("Auto Farm")
    local VisualsTab = MainWindow:NewTab("Visuals")
    local SettingsTab = MainWindow:NewTab("Settings")

    -- Aba Info (abre por padrão)
    InfoTab:AddParagraph({
        Title = "KINGHUB - " .. Info.Name,
        Content = "Version: " .. Info.Version ..
                  "\nAuthor: " .. Info.Author ..
                  "\nDiscord: " .. Info.Discord ..
                  "\nGitHub: " .. Info.GitHub
    })
    InfoTab:AddButton({
        Title = "Show in Console",
        Callback = function()
            Info:ShowInfo()
        end
    })

    MainWindow:SelectTab(InfoTab)

    -- Abas de teste para exemplo
    MainTab:AddButton({Title = "Test Main", Callback = function() print("Main tab working") end})
    BringTab:AddButton({Title = "Test Bring", Callback = function() print("Bring tab working") end})
    AutoFarmTab:AddButton({Title = "Test Auto Farm", Callback = function() print("Auto Farm working") end})
    VisualsTab:AddButton({Title = "Test Visuals", Callback = function() print("Visuals working") end})
    SettingsTab:AddButton({Title = "Test Settings", Callback = function() print("Settings working") end})
end

return Main
