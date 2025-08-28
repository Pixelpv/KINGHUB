-- features.lua (99 Nights in the Forest)

local Features = {}

function Features.AutoCollect()
    print("KINGHUB: Auto Collect iniciado...")
    -- Aqui entrariam as funções reais de auto coletar do jogo
    -- exemplo fictício:
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item:IsA("Part") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.CFrame
            wait(0.2)
        end
    end
end

return Features
