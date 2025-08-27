-- Inicializador do hub

print("KingHub inicializado!")

-- Carrega módulos principais
local ui = require("ui")
local coreLoader = require("core/loader")
local security = require("core/security")

-- Exemplo de inicialização
security.startProtections()
ui.init()
coreLoader.loadSelectedGame()

print("Hub pronto para uso.")