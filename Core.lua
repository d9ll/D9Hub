-- D9Hub Core v2 (with tabs and modules)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- === НАСТРОЙКИ ===
local TABS = {
    {name = "🏠 Home", icon = "🏠"},
    {name = "🎮 Teleports", icon = "🎮"},
    {name = "💀 Combat", icon = "💀"},
    {name = "✨ Animations", icon = "✨"},
    {name = "📦 Modules", icon = "📦"},
    {name = "⚙️ Settings", icon = "⚙️"},
}

-- === ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ===
local function GetSafeGui()
    if gethui then return gethui() end
    return CoreGui
end

-- Удаляем старый GUI
local oldGui = GetSafeGui():FindFirstChild("D9Hub")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "D9Hub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = GetSafeGui()

-- === ГЛАВНОЕ ОКНО ===
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 700, 0, 500)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

-- === БОКОВАЯ ПАНЕЛЬ С ВКЛАДКАМИ ===
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 160, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 14)
sidebarCorner.Parent = sidebar

-- Список вкладок
local tabList = Instance.new("ScrollingFrame")
tabList.Size = UDim2.new(1, -10, 1, -50)
tabList.Position = UDim2.new(0, 5, 0, 45)
tabList.BackgroundTransparency = 1
tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
tabList.ScrollBarThickness = 4
tabList.Parent = sidebar

local tabLayout = Instance.new("UIListLayout")
tabLayout.Padding = UDim.new(0, 6)
tabLayout.Parent = tabList

-- Заголовок D9Hub на боковой панели
local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, -10, 0, 40)
logo.Position = UDim2.new(0, 5, 0, 5)
logo.BackgroundTransparency = 1
logo.Text = "D9 HUB"
logo.TextColor3 = Color3.fromRGB(255, 180, 80)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 20
logo.Parent = sidebar

-- === ОСНОВНАЯ ОБЛАСТЬ КОНТЕНТА ===
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -170, 1, -10)
contentFrame.Position = UDim2.new(0, 165, 0, 5)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Список кнопок внутри вкладки
local contentList = Instance.new("ScrollingFrame")
contentList.Size = UDim2.new(1, -10, 1, -10)
contentList.BackgroundTransparency = 1
contentList.CanvasSize = UDim2.new(0, 0, 0, 0)
contentList.ScrollBarThickness = 6
contentList.Parent = contentFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 8)
contentLayout.Parent = contentList

contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    contentList.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y)
end)

-- === ЗАГОЛОВОК ВКЛАДКИ ===
local tabTitle = Instance.new("TextLabel")
tabTitle.Size = UDim2.new(1, -10, 0, 40)
tabTitle.Position = UDim2.new(0, 5, 0, 5)
tabTitle.BackgroundTransparency = 1
tabTitle.Text = "Home"
tabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
tabTitle.Font = Enum.Font.GothamBold
tabTitle.TextSize = 22
tabTitle.TextXAlignment = Enum.TextXAlignment.Left
tabTitle.Parent = contentFrame

-- === ФУНКЦИЯ ОЧИСТКИ КОНТЕНТА ===
local function clearContent()
    for _, child in pairs(contentList:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end

-- === ФУНКЦИЯ ДОБАВЛЕНИЯ КНОПКИ ===
local function addButton(text, callback, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.BackgroundColor3 = color or Color3.fromRGB(35, 35, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = contentList
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = color or Color3.fromRGB(35, 35, 50)
    end)
end

local function addCategory(name)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = "─── " .. name .. " ───"
    label.TextColor3 = Color3.fromRGB(180, 180, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Parent = contentList
end

-- === СОДЕРЖИМОЕ ВКЛАДОК ===

local tabContents = {}

-- Home вкладка
tabContents["🏠 Home"] = function()
    clearContent()
    addCategory("Welcome to D9Hub")
    addButton("📖 Open Documentation", function()
        print("D9Hub: Docs - github.com/d9ll/D9Hub")
    end, Color3.fromRGB(30, 60, 90))
    addCategory("Quick Actions")
    addButton("🟢 Respawn (if enabled)", function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Health = 0
        end
    end)
    addButton("🔵 Rejoin (same server)", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end)
end

-- Teleports вкладка
tabContents["🎮 Teleports"] = function()
    clearContent()
    addCategory("Teleport to Spots")
    addButton("📍 Middle of Map", function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        end
    end)
    addButton("⬆️ Sky (1000 studs)", function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(0, 1000, 0)
        end
    end)
    addCategory("Custom")
    addButton("✏️ Teleport to Player (type name)", function()
        local name = (function()
            -- простой диалог
            return "PlayerName"  -- заглушка
        end)()
        for _, v in pairs(Players:GetPlayers()) do
            if v.Name:lower():match(name:lower()) then
                if LocalPlayer.Character and v.Character then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end)
end

-- Combat вкладка
tabContents["💀 Combat"] = function()
    clearContent()
    addCategory("Combat Features")
    addButton("⚔️ Infinite Yield (admin)", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end)
    addButton("👊 Auto Click (toggle)", function()
        print("Auto click not implemented yet")
    end)
end

-- Animations вкладка
tabContents["✨ Animations"] = function()
    clearContent()
    addCategory("Emotes & Animations")
    addButton("🕺 Dance 1", function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            -- можно вставить ID анимации
        end
    end)
    addButton("💃 Dance 2", function() end)
    addButton("🪩 Default Animation Pack", function()
        -- заглушка
    end)
end

-- Modules вкладка (с поиском!)
tabContents["📦 Modules"] = function()
    clearContent()
    addCategory("Module Store")
    
    -- Поисковая строка (упрощённая)
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, -10, 0, 35)
    searchBox.PlaceholderText = "🔍 Search module..."
    searchBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 14
    searchBox.Parent = contentList
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 8)
    searchCorner.Parent = searchBox
    
    -- Список модулей (хардкод для примера)
    local modules = {
        {name = "Infinite Yield", desc = "Admin commands", url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
        {name = "Dex Explorer", desc = "Explore game objects", url = "https://raw.githubusercontent.com/anti999000/roblox-scripts/main/Dex%20Explorer.lua"},
        {name = "Remote Spy", desc = "Spy remote events", url = "https://raw.githubusercontent.com/exxtremestuffs/SimpleSpy/master/SimpleSpy"},
        {name = "Orbital Hub", desc = "Animation hub", url = "https://raw.githubusercontent.com/zzerexx/orbital/main/loader.lua"},
    }
    
    local function refreshModules(filter)
        -- удаляем старые кнопки модулей (но оставляем searchBox)
        for _, child in pairs(contentList:GetChildren()) do
            if child ~= searchBox and child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        for _, mod in pairs(modules) do
            if filter == "" or mod.name:lower():find(filter) or mod.desc:lower():find(filter) then
                addButton("📦 " .. mod.name .. " — " .. mod.desc, function()
                    loadstring(game:HttpGet(mod.url))()
                end, Color3.fromRGB(40, 40, 60))
            end
        end
    end
    
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        refreshModules(searchBox.Text:lower())
    end)
    
    refreshModules("")
end

-- Settings вкладка
tabContents["⚙️ Settings"] = function()
    clearContent()
    addCategory("UI Settings")
    addButton("🔴 Close D9Hub", function()
        gui:Destroy()
    end, Color3.fromRGB(120, 40, 40))
    addButton("🔄 Reload D9Hub", function()
        gui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/d9ll/D9Hub/main/Core.lua"))()
    end)
end

-- === СОЗДАНИЕ КНОПОК ВКЛАДОК ===
local tabButtons = {}

for _, tab in pairs(TABS) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    btn.Text = tab.name
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = tabList
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        -- Подсветка активной вкладки
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
            b.TextColor3 = Color3.fromRGB(200, 200, 220)
        end
        btn.BackgroundColor3 = Color3.fromRGB(50, 70, 100)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        tabTitle.Text = tab.name
        if tabContents[tab.name] then
            tabContents[tab.name]()
        else
            clearContent()
            addButton("Coming soon...", function() end)
        end
    end)
    
    tabButtons[btn] = btn
end

-- Авто-обновление высоты списка вкладок
tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    tabList.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 20)
end)

-- Активируем первую вкладку по умолчанию
if tabButtons[1] then
    tabButtons[1].MouseButton1Click:Connect(function() end) -- dummy
    tabButtons[1].MouseButton1Click:Fire()
end

print("D9Hub v2 loaded! Enjoy the tabs and modules.")
