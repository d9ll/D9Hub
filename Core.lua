-- D9Hub Core Engine (fixed)
local D9Hub = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Надёжный способ получить гуи (работает везде)
local function GetSafeGui()
    if gethui and type(gethui) == "function" then
        local hui = gethui()
        if hui and hui.Parent then return hui end
    end
    if syn and syn.protect_gui then
        -- для старых Synapse
        return CoreGui
    end
    return CoreGui
end

-- Удаляем старый D9Hub, если был
local oldGui = GetSafeGui():FindFirstChild("D9Hub")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "D9Hub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = GetSafeGui()

-- Защита от закрытия (опционально)
pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(gui)
    end
end)

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
mainFrame.Active = true
mainFrame.Draggable = true  -- чтобы можно было таскать окно

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Обводка для красоты
local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(80, 150, 200)
stroke.Transparency = 0.7
stroke.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "D9Hub | Beta"
title.TextColor3 = Color3.fromRGB(255, 200, 100)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = mainFrame

-- Контейнер для кнопок
local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -20, 1, -60)
list.Position = UDim2.new(0, 10, 0, 50)
list.BackgroundTransparency = 1
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.ScrollBarThickness = 6
list.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = list

-- Авто-обновление высоты скролла
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    list.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end)

-- Функция добавления кнопки (доступна для других модулей)
function D9Hub:AddButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = list
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    -- Анимация наведения
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    end)
end

function D9Hub:AddCategory(name)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = "─── " .. name .. " ───"
    label.TextColor3 = Color3.fromRGB(150, 150, 180)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.Parent = list
end

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -40, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- === ДЕМО-КНОПКИ (убери или оставь) ===
D9Hub:AddCategory("Testing")
D9Hub:AddButton("🟢 Teleport to 0,10,0", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
    end
end)
D9Hub:AddButton("🔴 Kill Character", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 0
    end
end)
D9Hub:AddCategory("Info")
D9Hub:AddButton("📋 Print Server Players", function()
    local names = ""
    for _, v in pairs(Players:GetPlayers()) do
        names = names .. v.Name .. ", "
    end
    print("Players in server: " .. names)
end)

print("D9Hub loaded! Look for the window.")
