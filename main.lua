-- KINGHUB Main Loader
-- Detecta o jogo e carrega o GUI correspondente

local PlaceId = game.PlaceId
local GameName = game.Name

-- Tabela de jogos suportados
local Games = {
    [6016359] = "99Nights",   -- Coloque o PlaceId do jogo 99Nights
    [12345678] = "Outrojogo"  -- Coloque PlaceId do outro jogo
}

-- Função para carregar script do jogo
local function LoadGameScript(gameFolder)
    local scriptPath = ("games/%s/%s.lua"):format(gameFolder, gameFolder)
    
    -- Tenta carregar
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SeuUsuario/KINGHUB/main/"..scriptPath))()
    end)
    
    if success then
        print("[KINGHUB] GUI do jogo "..gameFolder.." carregado com sucesso!")
    else
        warn("[KINGHUB] Erro ao carregar GUI de "..gameFolder..": "..tostring(err))
    end
end

-- Detecta e carrega
if Games[PlaceId] then
    LoadGameScript(Games[PlaceId])
else
    warn("[KINGHUB] Jogo não suportado. PlaceId: "..PlaceId.." Nome: "..GameName)
end
