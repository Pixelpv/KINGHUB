-- main.lua

local Games = {
    [79546208627805] = "99Nights",
    -- Adicione outros jogos aqui
}

local placeId = game.PlaceId
local gameFolder = Games[placeId]

if gameFolder then
    print("[KINGHUB] Carregando GUI para 99 Nights in the Forest")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixelpv/KINGHUB/main/games/" .. gameFolder .. "/" .. gameFolder .. ".lua"))()
else
    warn("[KINGHUB] Jogo não suportado. PlaceId:", placeId)
end
