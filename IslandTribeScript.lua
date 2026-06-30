local player = game.Players.LocalPlayer

if not player then return end

local gui = Instance.new("ScreenGui")
gui.Name = "MaintenanceForce"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 200)
frame.Position = UDim2.new(0.5, -250, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.05
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 500, 0, 60)
title.Position = UDim2.new(0, 0, 0, 15)
title.BackgroundTransparency = 1
title.Text = "🚫 SCRIPT OFFLINE"
title.TextColor3 = Color3.fromRGB(255, 80, 80)
title.TextSize = 34
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(0, 500, 0, 50)
desc.Position = UDim2.new(0, 0, 0, 80)
desc.BackgroundTransparency = 1
desc.Text = "This script is currently under maintenance.\nPlease wait for the updated version to be released."
desc.TextColor3 = Color3.fromRGB(200, 200, 220)
desc.TextSize = 17
desc.Font = Enum.Font.SourceSans
desc.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0, 500, 0, 30)
status.Position = UDim2.new(0, 0, 0, 140)
status.BackgroundTransparency = 1
status.Text = "⏳ Auto-closing in 5 seconds..."
status.TextColor3 = Color3.fromRGB(150, 150, 170)
status.TextSize = 14
status.Font = Enum.Font.SourceSans
status.Parent = frame

local progress = Instance.new("Frame")
progress.Size = UDim2.new(0, 0, 0, 4)
progress.Position = UDim2.new(0, 0, 0, 172)
progress.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
progress.BorderSizePixel = 0
progress.Parent = frame

local bgBar = Instance.new("Frame")
bgBar.Size = UDim2.new(0, 400, 0, 4)
bgBar.Position = UDim2.new(0.5, -200, 0, 172)
bgBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
bgBar.BorderSizePixel = 0
bgBar.Parent = frame

-- Animation
for i = 1, 100 do
    task.wait(0.05)
    progress.Size = UDim2.new(i / 100, 0, 0, 4)
    status.Text = "⏳ Auto-closing in " .. math.ceil((100 - i) / 20) .. " seconds..."
end

-- Kick player
task.wait(0.5)
player:Kick("🔧 Script is currently under maintenance.\nPlease wait for the next update.")
