-- King Hub UI Script

local Finity = loadstring(game:HttpGet("https://pastebin.com/raw/7V0bCkUz"))()()
Finity.Theme = "Dark"
local Category = Finity:Category("Blox Fruits")

local Farmar = Category:Sector("Farmar")
local Mar = Category:Sector("Mar")
local Ilhas = Category:Sector("Ilhas")
local MissoesItens = Category:Sector("Missões / Itens")
local FrutaRaid = Category:Sector("Fruta / Raid")
local Hop = Category:Sector("Hop")
local Teleporte = Category:Sector("Teleporte")
local Status = Category:Sector("Status")
local Visual = Category:Sector("Visual")
local Loja = Category:Sector("Loja")
local Diversos = Category:Sector("Diversos")
local Discord = Category:Sector("Discord")

getgenv().AutoFarm = false
getgenv().AutoHaki = false
getgenv().AutoQuest = false

Farmar:Cheat("Checkbox", "Auto Farm", function(State)
    getgenv().AutoFarm = State
end)

Farmar:Cheat("Checkbox", "Auto Haki", function(State)
    getgenv().AutoHaki = State
end)

Farmar:Cheat("Checkbox", "Auto Quest", function(State)
    getgenv().AutoQuest = State
end)

spawn(function()
    while true do
        wait(0.5)
        if getgenv().AutoFarm then
            pcall(function()
                for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,10,0)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    end
                end
            end)
        end
        if getgenv().AutoHaki then
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "B", false, game)
            wait(1)
        end
        if getgenv().AutoQuest then
            local args = {
                [1] = "StartQuest",
                [2] = "BanditQuest1",
                [3] = 1
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            wait(3)
        end
    end
end)

Teleporte:Cheat("Button", "Ir para Hydra Island", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5228, 25, -420)
end)

Teleporte:Cheat("Button", "Ir para Sea Castle", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-249, 25, 2200)
end)

Teleporte:Cheat("Button", "Ir para Mansion", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12500, 300, -8500)
end)

FrutaRaid:Cheat("Button", "Iniciar Raid (Flame)", function()
    local args = {
        [1] = "RaidsNpc",
        [2] = "Select",
        [3] = "Flame"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)

Hop:Cheat("Button", "Trocar de Servidor", function()
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    local PlaceID = game.PlaceId
    local servers = {}
    local req = syn and syn.request or http_request or request

    local function serverHop()
        local data = req({
            Url = "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"
        })
        local body = HttpService:JSONDecode(data.Body)
        for i,v in pairs(body.data) do
            if v.playing < v.maxPlayers then
                table.insert(servers, v.id)
            end
        end
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(PlaceID, servers[math.random(1, #servers)], game.Players.LocalPlayer)
        end
    end
    serverHop()
end)

Diversos:Cheat("Button", "Anti-AFK", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

Discord:Cheat("Label", "💬 Discord do King Hub: https://discord.gg/seulink")
