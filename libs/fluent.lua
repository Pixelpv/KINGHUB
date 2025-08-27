-- Custom Fluent UI modifications if needed
-- This file can extend or modify the default Fluent library

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Add mobile compatibility enhancements
function Fluent:MobileOptimize()
    if not iswindowactive then
        -- Adjust UI for touch devices
        self.Options.TabWidth = 200
        self.Options.Size = UDim2.fromOffset(700, 500)
    end
end

return Fluent
