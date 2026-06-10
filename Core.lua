-- D9Hub Core Engine
local D9Hub = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local function GetSafeGui()
    return (gethui and gethui()) or CoreGui
end

local gui = Instance.new("ScreenGui")
gui.Name = "D9Hub"
gui.Parent = GetSafeGui()

-- Создание GUI (сокращённо, полную версию возьми из предыдущего ответа)
local mainFrame, list, listLayout

-- Функция для добавления кнопки извне
function D9Hub:AddButton(text, callback)
    local btn = Instance.new("TextButton")
    -- ... (оформление кнопки)
    btn.MouseButton1Click:Connect(callback)
    btn.Parent = list
    task.wait()
    list.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

function D9Hub:AddCategory(name)
    -- Для группировки кнопок (опционально)
    local label = Instance.new("TextLabel")
    label.Text = name
    label.Parent = list
    -- ... оформление
end

-- Экспортируем для других модулей
return D9Hub
