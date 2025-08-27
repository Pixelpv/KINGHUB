-- Implementação local do Fluent UI

local Fluent = {}

function Fluent.createWindow(title, options)
    print(string.format("[Fluent] Criando janela '%s' (%dx%d, tema: %s)", title, options.width, options.height, options.theme))
end

return Fluent