return function(tab)
    local Paragraph = tab:AddParagraph({
        Title = "KingHub for 99 Nights in the Forest",
        Content = "A specialized script hub designed specifically for 99 Nights in the Forest. All features work in private instances without affecting other players."
    })
    
    tab:AddParagraph({
        Title = "Disclaimer",
        Content = "Use responsibly. The authors are not responsible for any issues caused by misuse."
    })
    
    local DiscordButton = tab:AddButton({
        Title = "Join Discord",
        Description = "Get support and updates",
        Callback = function()
            setclipboard("https://discord.gg/example")
        end
    })
    
    local GitHubButton = tab:AddButton({
        Title = "GitHub Repository",
        Description = "View source code and contribute",
        Callback = function()
            setclipboard("https://github.com/Pixelpv/KINGHUB")
        end
    })
    
    tab:AddParagraph({
        Title = "Version",
        Content = "1.0.0"
    })
    
    tab:AddParagraph({
        Title = "Author",
        Content = "YourName"
    })
end
