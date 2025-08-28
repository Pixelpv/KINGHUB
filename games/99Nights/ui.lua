-- 99Nights.lua (Fluent UI para 99 Nights in the Forest)

-- Carregar Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()

-- Criar janela principal
local Window = Fluent:CreateWindow({
    Title = "KINGHUB - 99 Nights",
    SubTitle = "Mobile Friendly",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Criar aba principal
local MainTab = Window:AddTab({ Title = "Principal", Icon = "home" })

-- Funções do jogo
local Features = {}
function Features.AutoCollect()
    -- Aqui você coloca a função real de pegar itens/missões
    print("Auto Collect iniciado!")
    Fluent:Notify({
        Title = "Auto Collect",
        Content = "Função iniciada!",
        Duration = 3
    })
end

-- Botão de Auto Collect
MainTab:AddButton({
    Title = "🚀 Auto Collect",
    Description = "Clique para iniciar",
    Callback = function()
        Features.AutoCollect()
    end
})

-- Toggle de Sistema
local toggleStatus = false
MainTab:AddToggle("AutoToggle", {
    Title = "🔥 Ativar Auto Collect",
    Description = "Liga/Desliga a função",
    Default = false,
    Callback = function(Value)
        toggleStatus = Value
        if Value then
            Fluent:Notify({ Title = "Ativado", Content = "Auto Collect ON", Duration = 2 })
        else
            Fluent:Notify({ Title = "Desativado", Content = "Auto Collect OFF", Duration = 2 })
        end
    end
})

-- Slider de Delay
MainTab:AddSlider("DelaySlider", {
    Title = "⏱️ Delay",
    Description = "Ajusta o intervalo do Auto Collect",
    Default = 1,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Callback = function(Value)
        print("Delay setado para: " .. Value .. "s")
    end
})

-- Notificação inicial
Fluent:Notify({
    Title = "KINGHUB Carregado!",
    Content = "Fluent UI carregada com sucesso!",
    Duration = 3
})

print("Fluent UI 99 Nights pronta!")
