local assetId = 16138018021
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local function loadAsset(id)
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. id)[1]
    end)
    
    if success and result then
        return result
    else
        return nil
    end
end

local model = loadAsset(assetId)

if model then
    model.Name = "BlizzardEffect"
    model.Parent = workspace
    local targetCFrame = root.CFrame
    
    if model:IsA("Model") then
        model:SetPrimaryPartCFrame(targetCFrame)
        
        if not model.PrimaryPart then
            local parts = model:GetChildren()
            for _, part in pairs(parts) do
                if part:IsA("BasePart") then
                    part.CFrame = targetCFrame
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = root
                    weld.Part1 = part
                    weld.Parent = part
                    part.Transparency = 1
                    part.CanCollide = false
                    part.Massless = true
                end
            end
        else
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = root
            weld.Part1 = model.PrimaryPart
            weld.Parent = model.PrimaryPart
            model.PrimaryPart.Transparency = 1
            model.PrimaryPart.CanCollide = false
            model.PrimaryPart.Massless = true
        end
        
    elseif model:IsA("BasePart") then
        model.CFrame = targetCFrame
        model.Transparency = 1
        model.CanCollide = false
        model.Massless = true
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = root
        weld.Part1 = model
        weld.Parent = model
    end
end

return model
