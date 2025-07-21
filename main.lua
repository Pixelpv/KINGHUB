-- KING HUB Main Loader
local Settings = getgenv().Settings or {
    JoinTeam = "Pirates",
    Translator = false
}

local success, response = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/core.lua")
end)

if success then
    loadstring(response)(Settings)
else
    warn("[KING HUB] Falha ao carregar o core.")
end
