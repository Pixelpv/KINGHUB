-- init.lua (99 Nights in the Forest)

local GameId = game.GameId
local Supported = {
    ["99Nights"] = 79546208627805 -- PlaceId do jogo
}

if GameId ~= Supported["99Nights"] then
    warn("KINGHUB: Este script não é para este jogo.")
    return
end

-- Carrega UI e Features
local ui = loadfile("games/99Nights/ui.lua")()
local features = loadfile("games/99Nights/features.lua")()

ui:CreateMain(features)
