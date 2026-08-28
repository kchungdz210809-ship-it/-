local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "                                🌴Island Tribes 🌴",
    LoadingTitle = "WSP",
    LoadingSubtitle = "Made by Chungdz",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil,
       FileName = "Nigga 69"
    },
    KeySystem = false,
    KeySettings = {
       Title = "🌴Island Tribes 🌴",
       Subtitle = "Made by Chung credit #Chungdz",
       Note = "this guy is gay gbaox_01",
       FileName = "0",
       SaveKey = true,
       GrabKeyFromSite = true,
       Key = {"https://raw.githubusercontent.com/Chungdz09/Script-chung-dz/refs/heads/main/Key"}
    }
})

local MainTab = Window:CreateTab("🏠 Main", nil)
MainTab:CreateSection("Other Scripts")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

while not LocalPlayer do task.wait() LocalPlayer = Players.LocalPlayer end

local Camera = workspace.CurrentCamera
local Mouse = pcall(function() return LocalPlayer:GetMouse() end) and LocalPlayer:GetMouse() or UserInputService

local RemoteEvents = {
    ToolAction           = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction"),
    InventoryInteraction = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"),
    UpdateStorageChest   = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("UpdateStorageChest"),
    SetSettings          = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("SetSettings"),
    BuyWorldEvent        = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent"),
    ItemInteracted       = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ItemInteracted"),
    CraftItem            = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("CraftItem"),
    TradeTrader          = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("TradeTrader"),
    KeyDoor              = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("KeyDoor"),
    Sonar                = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("Sonar"),
}

local DEFAULT_SIZE         = Vector3.new(2, 2, 1)
local DEFAULT_TRANSPARENCY = 0
local DEFAULT_MATERIAL     = Enum.Material.Plastic
local DEFAULT_CAN_COLLIDE  = true

local hitboxSize      = 10
local hitboxEnabled   = false
local hitboxTeamCheck = false
local trackedPlayers  = {}
local CurrentlyLocked = nil

local espEnabled   = false
local espTeamCheck = false
local espScale     = UDim2.new(0, 120, 0, 50)
local espInstances = {}

-- aimPart locked to Head only, no dropdown
local aimEnabled    = false
local aimPart       = "Head"
local smoothness    = 0.05
local fovRadius     = 150
local aimTeamCheck  = true
local aiming        = false
local targetLocked  = false
local currentTarget = nil
local showTargetHUD = false

_G.SilentAim = false

-- ===== TEAM CHECK =====
local function IsEnemy(player)
    if not player or not player.Character then return false end
    local char   = player.Character
    local myChar = LocalPlayer.Character
    if not myChar then return false end
    local bb   = char:FindFirstChild("PlayerBillboard")
    local myBB = myChar:FindFirstChild("PlayerBillboard")
    if not bb or not myBB then return true end
    local icon   = bb:FindFirstChild("Title") and bb.Title:FindFirstChild("Icon")
    local myIcon = myBB:FindFirstChild("Title") and myBB.Title:FindFirstChild("Icon")
    if not icon or not myIcon then return true end
    if icon.BackgroundColor3 == Color3.fromRGB(80, 63, 47) then return true end
    return icon.BackgroundColor3 ~= myIcon.BackgroundColor3
end

-- ===== HELPERS =====
local function IsPlayerAlive(player)
    return player and player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end
local function getRootPart(player)
    local character = player.Character
    if not character then return nil end
    return character:FindFirstChild("HumanoidRootPart")
end
local function restoreRootPart(rootPart)
    if not rootPart or not rootPart.Parent then return end
    rootPart.Size = DEFAULT_SIZE rootPart.Transparency = DEFAULT_TRANSPARENCY
    rootPart.Material = DEFAULT_MATERIAL rootPart.CanCollide = DEFAULT_CAN_COLLIDE
end
local function setHitbox(rootPart)
    if not rootPart or not rootPart.Parent then return end
    rootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
    rootPart.Transparency = 0.7 rootPart.BrickColor = BrickColor.new("Really blue")
    rootPart.Material = Enum.Material.Neon rootPart.CanCollide = false
end
local function restoreAll()
    for _, player in ipairs(trackedPlayers) do restoreRootPart(getRootPart(player)) end
end
local function updatePlayerList()
    table.clear(trackedPlayers)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then table.insert(trackedPlayers, player) end
    end
end

if not getgenv().Idling then
    getgenv().Idling = true
    LocalPlayer.Idled:connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- ===== TARGET HUD =====
local targetGui = Instance.new("ScreenGui")
targetGui.Name = "TargetHUD" targetGui.ResetOnSpawn = false
targetGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
targetGui.Parent = game.CoreGui

local hudFrame = Instance.new("Frame")
hudFrame.Size = UDim2.new(0,180,0,52)
hudFrame.Position = UDim2.new(0.5,-90,0.15,0)
hudFrame.BackgroundColor3 = Color3.fromRGB(12,12,18)
hudFrame.BackgroundTransparency = 0.25
hudFrame.BorderSizePixel = 0
hudFrame.Visible = false hudFrame.Active = true
hudFrame.Parent = targetGui
Instance.new("UICorner", hudFrame).CornerRadius = UDim.new(0,8)
local hudStroke = Instance.new("UIStroke", hudFrame)
hudStroke.Color = Color3.fromRGB(80,130,255) hudStroke.Thickness = 1.2

local dragBar = Instance.new("Frame")
dragBar.Size = UDim2.new(1,0,0,16) dragBar.Position = UDim2.new(0,0,0,0)
dragBar.BackgroundColor3 = Color3.fromRGB(80,130,255)
dragBar.BackgroundTransparency = 0.5 dragBar.BorderSizePixel = 0
dragBar.Parent = hudFrame
Instance.new("UICorner", dragBar).CornerRadius = UDim.new(0,8)

local dragTitle = Instance.new("TextLabel")
dragTitle.Size = UDim2.new(1,0,1,0) dragTitle.BackgroundTransparency = 1
dragTitle.Text = "⚡ TARGET" dragTitle.TextColor3 = Color3.fromRGB(255,255,255)
dragTitle.TextScaled = true dragTitle.Font = Enum.Font.GothamBold
dragTitle.Parent = dragBar

local hudName = Instance.new("TextLabel")
hudName.Size = UDim2.new(1,-10,0,18) hudName.Position = UDim2.new(0,5,0,17)
hudName.BackgroundTransparency = 1 hudName.Text = "Target: —"
hudName.TextColor3 = Color3.fromRGB(255,255,255) hudName.TextScaled = true
hudName.Font = Enum.Font.GothamBold hudName.TextXAlignment = Enum.TextXAlignment.Left
hudName.Parent = hudFrame

local hudHP = Instance.new("TextLabel")
hudHP.Size = UDim2.new(1,-10,0,14) hudHP.Position = UDim2.new(0,5,0,35)
hudHP.BackgroundTransparency = 1 hudHP.Text = "HP: —"
hudHP.TextColor3 = Color3.fromRGB(80,220,80) hudHP.TextScaled = true
hudHP.Font = Enum.Font.Gotham hudHP.TextXAlignment = Enum.TextXAlignment.Left
hudHP.Parent = hudFrame

-- drag logic
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
local function updateDrag(input)
    local delta = input.Position - dragStart
    hudFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
dragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = hudFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
dragBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then updateDrag(input) end
end)

-- HUD update
RunService.RenderStepped:Connect(function()
    if not showTargetHUD or not hudFrame.Visible then return end
    if targetLocked and currentTarget then
        local char = currentTarget.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 then
            hudName.Text       = "🎯 " .. currentTarget.Name
            hudName.TextColor3 = Color3.fromRGB(255,80,80)
            local hp    = math.floor(hum.Health)
            local maxHp = math.floor(hum.MaxHealth)
            local ratio = math.clamp(hp / math.max(maxHp,1), 0, 1)
            local r = math.clamp(2*(1-ratio),0,1)
            local g = math.clamp(2*ratio,0,1)
            hudHP.Text       = "HP: " .. hp .. " / " .. maxHp
            hudHP.TextColor3 = Color3.new(r,g,0)
        else
            hudName.Text = "Target: —" hudName.TextColor3 = Color3.fromRGB(255,255,255)
            hudHP.Text = "HP: —" hudHP.TextColor3 = Color3.fromRGB(80,220,80)
        end
    else
        hudName.Text = "Target: —" hudName.TextColor3 = Color3.fromRGB(255,255,255)
        hudHP.Text = "HP: —" hudHP.TextColor3 = Color3.fromRGB(80,220,80)
    end
end)

-- ===== ESP =====
local function removeESP(player)
    if espInstances[player] then
        if espInstances[player].billboard and espInstances[player].billboard.Parent then
            espInstances[player].billboard:Destroy()
        end
        espInstances[player] = nil
    end
end
local function createESP(player)
    if not player.Character then return end
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    removeESP(player)

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "_ESP_AXIOM" billboard.Adornee = root
    billboard.AlwaysOnTop = true billboard.Size = espScale
    billboard.StudsOffset = Vector3.new(0,3.5,0) billboard.Parent = root

    local nameLabel = Instance.new("TextLabel")
    nameLabel.BackgroundTransparency = 1 nameLabel.Size = UDim2.new(1,0,0.35,0)
    nameLabel.Position = UDim2.new(0,0,0,0) nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255,255,255) nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold nameLabel.TextStrokeTransparency = 0.4
    nameLabel.Parent = billboard

    local healthBar = Instance.new("Frame")
    healthBar.BackgroundColor3 = Color3.fromRGB(40,40,40) healthBar.Size = UDim2.new(1,0,0.12,0)
    healthBar.Position = UDim2.new(0,0,0.36,0) healthBar.BorderSizePixel = 0
    healthBar.Parent = billboard
    Instance.new("UICorner", healthBar).CornerRadius = UDim.new(1,0)

    local healthFill = Instance.new("Frame")
    healthFill.BackgroundColor3 = Color3.fromRGB(80,220,80) healthFill.Size = UDim2.new(1,0,1,0)
    healthFill.BorderSizePixel = 0 healthFill.Parent = healthBar
    Instance.new("UICorner", healthFill).CornerRadius = UDim.new(1,0)

    local healthLabel = Instance.new("TextLabel")
    healthLabel.BackgroundTransparency = 1 healthLabel.Size = UDim2.new(1,0,0.28,0)
    healthLabel.Position = UDim2.new(0,0,0.5,0) healthLabel.TextColor3 = Color3.fromRGB(80,220,80)
    healthLabel.TextScaled = true healthLabel.Font = Enum.Font.Gotham
    healthLabel.TextStrokeTransparency = 0.4 healthLabel.Parent = billboard

    local distLabel = Instance.new("TextLabel")
    distLabel.BackgroundTransparency = 1 distLabel.Size = UDim2.new(1,0,0.25,0)
    distLabel.Position = UDim2.new(0,0,0.75,0) distLabel.TextColor3 = Color3.fromRGB(200,200,200)
    distLabel.TextScaled = true distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeTransparency = 0.4 distLabel.Parent = billboard

    espInstances[player] = { billboard=billboard, nameLabel=nameLabel, healthLabel=healthLabel, distLabel=distLabel, healthBar=healthBar, healthFill=healthFill }
end
local function updateESPScale()
    for _, data in pairs(espInstances) do
        if data.billboard and data.billboard.Parent then data.billboard.Size = espScale end
    end
end
local function clearAllESP()
    for player in pairs(espInstances) do removeESP(player) end
end
local function rebuildAllESP()
    clearAllESP()
    if not espEnabled then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if espTeamCheck then
                if IsEnemy(player) then createESP(player) end
            else createESP(player) end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local shouldShow = not espTeamCheck or IsEnemy(player)
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not shouldShow or not root or not hum then removeESP(player) continue end
        if not espInstances[player] or not espInstances[player].billboard.Parent then createESP(player) end
        local data = espInstances[player]
        if not data then continue end
        if data.billboard.Adornee ~= root then data.billboard.Adornee = root end
        local hp = math.floor(hum.Health) local maxHp = math.max(hum.MaxHealth,1)
        local hpRatio = math.clamp(hp/maxHp,0,1)
        local r = math.clamp(2*(1-hpRatio),0,1) local g = math.clamp(2*hpRatio,0,1)
        data.healthLabel.Text = "HP: "..hp.." / "..math.floor(maxHp)
        data.healthLabel.TextColor3 = Color3.new(r,g,0)
        data.healthFill.BackgroundColor3 = Color3.new(r,g,0)
        data.healthFill.Size = UDim2.new(hpRatio,0,1,0)
        if myRoot then data.distLabel.Text = "Dist: "..math.floor((myRoot.Position-root.Position).Magnitude).." studs" end
        data.nameLabel.TextColor3 = IsEnemy(player) and Color3.fromRGB(255,80,80) or Color3.fromRGB(80,220,80)
    end
end)

-- ===== AIMBOT =====
local fovDraw = nil
if Drawing then
    fovDraw = Drawing.new("Circle")
    fovDraw.Visible = false fovDraw.Thickness = 1
    fovDraw.Color = Color3.fromRGB(255,80,80) fovDraw.Filled = false
    fovDraw.Radius = fovRadius
    fovDraw.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
end

local function GetClosestPlayerToMouse()
    local closest, minDist = nil, math.huge
    local mousePos = UserInputService:GetMouseLocation()
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if aimTeamCheck and not IsEnemy(player) then continue end
        local char = player.Character
        -- aim at Head specifically
        local head = char and char:FindFirstChild("Head")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not head or not hum or hum.Health <= 0 then continue end
        local screenPos, onScreen = Camera:WorldToScreenPoint(head.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(mousePos.X,mousePos.Y) - Vector2.new(screenPos.X,screenPos.Y)).Magnitude
        if dist < fovRadius and dist < minDist then minDist = dist closest = player end
    end
    return closest
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = true
    elseif input.KeyCode == Enum.KeyCode.LeftControl and aimEnabled then
        if targetLocked then
            currentTarget = nil targetLocked = false
        else
            currentTarget = GetClosestPlayerToMouse()
            if currentTarget then targetLocked = true end
        end
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then aiming = false end
end)

RunService.RenderStepped:Connect(function()
    if fovDraw and fovDraw.Visible then
        fovDraw.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    end
    if targetLocked and currentTarget then
        local char = currentTarget.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not char or not hum or hum.Health <= 0 then
            currentTarget = nil targetLocked = false
        end
    end
    -- locked to Head only
    if aiming and aimEnabled and targetLocked and currentTarget then
        local char = currentTarget.Character
        local head = char and char:FindFirstChild("Head")
        if head then
            TweenService:Create(Camera, TweenInfo.new(smoothness, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
            }):Play()
        end
    end
end)

-- ===== KILL AURA =====
function KillAura()
    while getgenv().configs.KillAura do
        task.wait()
        local range, closest = 32, nil
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if myRoot then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr == LocalPlayer or not IsEnemy(plr) then continue end
                if IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) then
                    local dist = (myRoot.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                    if dist < range then range = dist closest = plr.Character end
                end
            end
        end
        if closest then RemoteEvents.ToolAction:FireServer(closest) end
    end
end

-- ===== PLAYER LOCK =====
function PlayerLock()
    local function Wallcheck(target)
        local ray = Ray.new(Camera.CFrame.Position, (target.Position - Camera.CFrame.Position).Unit * 1000)
        local part = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character}, false, true)
        if part then
            local hum = part.Parent:FindFirstChildOfClass("Humanoid") or part.Parent.Parent:FindFirstChildOfClass("Humanoid")
            if hum and hum.Parent == target.Parent then
                local _, visible = Camera:WorldToScreenPoint(target.Position)
                return visible
            end
        end
        return false
    end
    local function GetNearestPlayerToMouse()
        if CurrentlyLocked and CurrentlyLocked.Humanoid.Health > 0 then return CurrentlyLocked end
        local dist, closest = 150, nil
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) and IsEnemy(plr) then
                local char = plr.Character
                local plrpos, onscreen = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
                if onscreen then
                    local mag = (Vector2.new(Mouse.X,Mouse.Y) - Vector2.new(plrpos.X,plrpos.Y)).Magnitude
                    if mag < dist and (char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < dist then
                        if Wallcheck(char.HumanoidRootPart) then dist = mag closest = char end
                    end
                end
            end
        end
        return closest
    end
    if not getgenv().Updater then
        getgenv().Updater = RunService.RenderStepped:Connect(function()
            if getgenv().configs.PlayerLock then
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                    local target = GetNearestPlayerToMouse()
                    if target then
                        CurrentlyLocked = target
                        local snap = TweenService:Create(Camera, TweenInfo.new(0.01, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            CFrame = CFrame.new(Camera.CFrame.Position, CurrentlyLocked.HumanoidRootPart.Position)
                        })
                        snap:Play() snap.Completed:Wait()
                    end
                else CurrentlyLocked = nil end
            end
        end)
    end
end

-- ===== PUMPKINS =====
function Pumpkins()
    while getgenv().configs.Pumpkins do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            if LocalPlayer.Character.Humanoid.Health < 75 then
                RemoteEvents.InventoryInteraction:FireServer(378, "Eat")
            end
        end
    end
end

-- ===== UI: ESP =====
MainTab:CreateSection("ESP")
MainTab:CreateToggle({
    Name = "Enable ESP", CurrentValue = false, Flag = "ESPToggle",
    Callback = function(Value) espEnabled = Value if Value then rebuildAllESP() else clearAllESP() end end,
})
MainTab:CreateToggle({
    Name = "ESP Team Check (Enemies Only)", CurrentValue = false, Flag = "ESPTeamCheck",
    Callback = function(Value) espTeamCheck = Value rebuildAllESP() end,
})
MainTab:CreateSlider({
    Name = "ESP Width", Range = {60,300}, Increment = 5, Suffix = "px", CurrentValue = 120, Flag = "ESPWidth",
    Callback = function(Value) espScale = UDim2.new(0,Value,0,espScale.Y.Offset) updateESPScale() end,
})
MainTab:CreateSlider({
    Name = "ESP Height", Range = {30,200}, Increment = 5, Suffix = "px", CurrentValue = 50, Flag = "ESPHeight",
    Callback = function(Value) espScale = UDim2.new(0,espScale.X.Offset,0,Value) updateESPScale() end,
})

-- ===== UI: AIMBOT =====
MainTab:CreateSection("Aimbot")
MainTab:CreateToggle({
    Name = "Enable Aimbot (Hold RMB → Head)", CurrentValue = false, Flag = "AimbotToggle",
    Callback = function(Value)
        aimEnabled = Value
        if not Value then targetLocked = false currentTarget = nil end
    end,
})
MainTab:CreateToggle({
    Name = "Show Target HUD", CurrentValue = false, Flag = "TargetHUDToggle",
    Callback = function(Value)
        showTargetHUD = Value
        hudFrame.Visible = Value
    end,
})
MainTab:CreateToggle({
    Name = "Aimbot Team Check (Enemies Only)", CurrentValue = true, Flag = "AimbotTeamCheck",
    Callback = function(Value)
        aimTeamCheck = Value
        if aimTeamCheck and targetLocked and currentTarget and not IsEnemy(currentTarget) then
            currentTarget = nil targetLocked = false
        end
    end,
})
MainTab:CreateToggle({
    Name = "Show FOV Circle", CurrentValue = false, Flag = "FOVCircleToggle",
    Callback = function(Value) if fovDraw then fovDraw.Visible = Value end end,
})
MainTab:CreateSlider({
    Name = "FOV Radius", Range = {25,500}, Increment = 25, Suffix = "px", CurrentValue = 150, Flag = "FOVRadius",
    Callback = function(Value)
        fovRadius = Value
        if fovDraw then fovDraw.Radius = Value end
    end,
})
MainTab:CreateSlider({
    Name = "Aimbot Smoothness", Range = {1,20}, Increment = 1, Suffix = "", CurrentValue = 5, Flag = "AimbotSmooth",
    Callback = function(Value) smoothness = Value / 100 end,
})

-- ===== UI: HITBOX =====
MainTab:CreateSection("Hitbox Editor")
MainTab:CreateToggle({
    Name = "Enable Hitbox", CurrentValue = false, Flag = "HitboxToggle",
    Callback = function(Value) hitboxEnabled = Value if not hitboxEnabled then restoreAll() end end,
})
MainTab:CreateSlider({
    Name = "Hitbox Size", Range = {1,50}, Increment = 1, Suffix = "Studs", CurrentValue = 10, Flag = "HitboxSize",
    Callback = function(Value) hitboxSize = Value end,
})
MainTab:CreateToggle({
    Name = "Hitbox Team Check (Enemies Only)", CurrentValue = false, Flag = "HitboxTeamCheck",
    Callback = function(Value)
        hitboxTeamCheck = Value
        if not Value and hitboxEnabled then restoreAll() end
    end,
})

-- ===== UI: COMBAT =====
MainTab:CreateSection("Combat")
getgenv().configs = getgenv().configs or {}
getgenv().configs.KillAura   = false
getgenv().configs.PlayerLock = false
getgenv().configs.Pumpkins   = false

MainTab:CreateToggle({
    Name = "Kill Aura", CurrentValue = false, Flag = "KillAuraToggle",
    Callback = function(Value)
        getgenv().configs.KillAura = Value
        if Value then task.spawn(KillAura) end
    end,
})

-- Silent Aim: 1 target, 0.7s interval, team checked
MainTab:CreateToggle({
    Name = "Silent Aim (nearest enemy, 0.7s)", CurrentValue = false, Flag = "SilentAimToggle",
    Callback = function(Value)
        _G.SilentAim = Value
        if Value then
            task.spawn(function()
                while _G.SilentAim do
                    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if myRoot then
                        -- find single nearest enemy only
                        local nearest, minDist = nil, math.huge
                        for _, player in pairs(Players:GetPlayers()) do
                            if player == LocalPlayer then continue end
                            if not IsEnemy(player) then continue end
                            local char = player.Character
                            local root = char and char:FindFirstChild("HumanoidRootPart")
                            local hum  = char and char:FindFirstChildOfClass("Humanoid")
                            if not root or not hum or hum.Health <= 0 then continue end
                            local dist = (myRoot.Position - root.Position).Magnitude
                            if dist < minDist then
                                minDist = dist
                                nearest = player
                            end
                        end
                        -- fire once at that one target only
                        if nearest and nearest.Character then
                            RemoteEvents.ToolAction:FireServer(nearest.Character)
                        end
                    end
                    task.wait(0.7) -- 0.7s between hits
                end
            end)
        end
    end,
})

MainTab:CreateToggle({
    Name = "Player Lock (Right Click)", CurrentValue = false, Flag = "PlayerLockToggle",
    Callback = function(Value)
        getgenv().configs.PlayerLock = Value
        if Value then PlayerLock() end
    end,
})
MainTab:CreateToggle({
    Name = "Auto Pumpkins (Health < 75)", CurrentValue = false, Flag = "PumpkinsToggle",
    Callback = function(Value)
        getgenv().configs.Pumpkins = Value
        if Value then task.spawn(Pumpkins) end
    end,
})

-- ===== HITBOX RENDER =====
RunService.RenderStepped:Connect(function()
    if not hitboxEnabled then return end
    for _, player in ipairs(trackedPlayers) do
        local rootPart = getRootPart(player)
        if rootPart then
            if hitboxTeamCheck then
                if IsEnemy(player) then setHitbox(rootPart) else restoreRootPart(rootPart) end
            else setHitbox(rootPart) end
        end
    end
end)

-- ===== PLAYER EVENTS =====
Players.PlayerAdded:Connect(function(player)
    updatePlayerList()
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if espEnabled and (not espTeamCheck or IsEnemy(player)) then createESP(player) end
    end)
end)
Players.PlayerRemoving:Connect(function(player)
    removeESP(player) updatePlayerList()
end)
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            task.wait(1)
            if espEnabled and (not espTeamCheck or IsEnemy(player)) then createESP(player) end
        end)
    end
end

updatePlayerList()
