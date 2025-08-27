-- Cria interface Fluent UI

local fluent = require("libs/fluent")

local UI = {}

function UI.init()
    print("[UI] Inicializando Fluent UI...")
    fluent.createWindow("KingHub", {
        width = 600,
        height = 400,
        theme = "dark"
    })
end

return UI