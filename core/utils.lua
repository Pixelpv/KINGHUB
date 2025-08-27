local Utils = {}

-- Toggle function
function Utils.ToggleFunction(name, callback)
    local enabled = false
    return function()
        enabled = not enabled
        callback(enabled)
        return enabled
    end
end

-- Create button with confirmation
function Utils.ConfirmButton(button, text, callback)
    button:SetText("Confirm " .. text)
    task.wait(3)
    button:SetText(text)
    button.OnClick:Connect(callback)
end

-- Safe teleport
function Utils.SafeTeleport(cframe)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = cframe
    end
end

-- Find player
function Utils.FindPlayer(name)
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name:lower():find(name:lower()) or player.DisplayName:lower():find(name:lower()) then
            return player
        end
    end
    return nil
end

return Utils
