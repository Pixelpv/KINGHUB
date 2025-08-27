-- core/loader.lua
local Loader = {}
local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/core/utils.lua"))()

-- Carrega todas as abas de um jogo
function Loader:LoadGame(gameName, MainWindow)
    local baseUrl = "https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/games/" .. gameName .. "/"
    local tabs = {"principal.lua", "trazer.lua", "auto.lua", "visuais.lua", "configs.lua"}

    for _, file in ipairs(tabs) do
        local success, module = pcall(function()
            return loadstring(game:HttpGet(baseUrl .. file))()
        end)

        if success and module and module.Init then
            Utils:Log("Carregando " .. file .. " para " .. gameName)
            module:Init(MainWindow)
        else
            Utils:Warn("Falha ao carregar " .. file .. " (" .. gameName .. ")")
        end
    end
end

return Loader
