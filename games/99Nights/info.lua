
local Info = {}

Info.Name = "99 Nights in the Forest"
Info.Version = "1.0.0"
Info.Author = "Pixel & Team"
Info.Discord = "https://discord.gg/seulinkdiscord"
Info.GitHub = "https://github.com/Pixelpv/KINGHUB"

function Info:ShowInfo()
    print("=== KINGHUB - " .. self.Name .. " ===")
    print("Version: " .. self.Version)
    print("Author: " .. self.Author)
    print("Discord: " .. self.Discord)
    print("GitHub: " .. self.GitHub)
    print("=============================")
end

return Info
