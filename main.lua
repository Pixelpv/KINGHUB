-- King Hub Main Script

if not Settings then
    Settings = {
        JoinTeam = "Pirates",
        Translator = false
    }
end

-- Selecionar time
if Settings.JoinTeam then
    local args = {
        [1] = "SetTeam",
        [2] = Settings.JoinTeam
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

-- Tradutor (placeholder)
if Settings.Translator == true then
    print("🌐 Tradutor ativado - (você pode adicionar tradução automática aqui)")
end

-- Carregar UI
loadstring(game:HttpGet("https://raw.githubusercontent.com/SeuUsuario/KINGHUB/main/ui.lua"))()
