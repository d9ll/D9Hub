-- Animations Module for D9Hub
local D9Hub = ... -- получаем доступ к API

local function playAnimation(id)
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. id
    local track = hum:LoadAnimation(anim)
    track:Play()
end

D9Hub:AddCategory("=== Animations ===")
D9Hub:AddButton("Backflip", function() playAnimation("507771428") end)
D9Hub:AddButton("Dab", function() playAnimation("507770000") end)
-- ... больше анимаций
