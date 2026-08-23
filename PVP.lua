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
local MainSection = MainTab:CreateSection("Other Scripts")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

while not LocalPlayer do
    task.wait()
    LocalPlayer = Players.LocalPlayer
end

local Camera = workspace.CurrentCamera
local Mouse = pcall(function() return LocalPlayer:GetMouse() end) and LocalPlayer:GetMouse() or UserInputService

local RemoteEvents = {
    ToolAction         = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction"),
    InventoryInteraction = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"),
    UpdateStorageChest = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("UpdateStorageChest"),
    SetSettings        = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("SetSettings"),
    BuyWorldEvent      = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent"),
    ItemInteracted     = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ItemInteracted"),
    CraftItem          = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("CraftItem"),
    TradeTrader        = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("TradeTrader"),
    KeyDoor            = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("KeyDoor"),
    Sonar              = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("Sonar"),
}

local ALLITEMSTABLE = {
    "Wood", "Stone", "Iron", "Gold", "Diamond", "Coal", "Copper", "Tin",
    "Silver", "Platinum", "Ruby", "Sapphire", "Emerald", "Amethyst",
    "Leather", "Fur", "Feather", "Bone", "String", "Cloth", "Silk"
}

local SWITCHEDITEMSTABLE = {
    ["Raw Potato"] = 4,  ["Watermelon"] = 5,  ["Banana"] = 7,
    ["Redberry"]   = 9,  ["Coconut"]    = 11, ["Baked Potato"] = 19,
    ["Carrot"]     = 41, ["Cabbage"]    = 42, ["Cooked Fish"]  = 70,
    ["Cooked Meat"]= 103,["Caveberry"]  = 133,["Slime Ball"]   = 147,
    ["Lucky Fruit"]= 151
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
local Whitelist_table = {}
local MyInventory     = nil
local autoPickupEnabled = false

-- ===== ESP CONFIG =====
local espEnabled   = false
local espTeamCheck = false
local espScale     = UDim2.new(0, 120, 0, 50)
local espInstances = {}

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
    billboard.Name        = "_ESP_AXIOM"
    billboard.Adornee     = root
    billboard.AlwaysOnTop = true
    billboard.Size        = espScale
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.Parent      = root

    local nameLabel = Instance.new("TextLabel")
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size      = UDim2.new(1, 0, 0.35, 0)
    nameLabel.Position  = UDim2.new(0, 0, 0, 0)
    nameLabel.Text      = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font      = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0.4
    nameLabel.Parent    = billboard

    local healthBar = Instance.new("Frame")
    healthBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    healthBar.Size             = UDim2.new(1, 0, 0.12, 0)
    healthBar.Position         = UDim2.new(0, 0, 0.36, 0)
    healthBar.BorderSizePixel  = 0
    healthBar.Parent           = billboard
    Instance.new("UICorner", healthBar).CornerRadius = UDim.new(1, 0)

    local healthFill = Instance.new("Frame")
    healthFill.BackgroundColor3 = Color3.fromRGB(80, 220, 80)
    healthFill.Size             = UDim2.new(1, 0, 1, 0)
    healthFill.BorderSizePixel  = 0
    healthFill.Parent           = healthBar
    Instance.new("UICorner", healthFill).CornerRadius = UDim.new(1, 0)

    local healthLabel = Instance.new("TextLabel")
    healthLabel.BackgroundTransparency = 1
    healthLabel.Size      = UDim2.new(1, 0, 0.28, 0)
    healthLabel.Position  = UDim2.new(0, 0, 0.5, 0)
    healthLabel.TextColor3 = Color3.fromRGB(80, 220, 80)
    healthLabel.TextScaled = true
    healthLabel.Font      = Enum.Font.Gotham
    healthLabel.TextStrokeTransparency = 0.4
    healthLabel.Parent    = billboard

    local distLabel = Instance.new("TextLabel")
    distLabel.BackgroundTransparency = 1
    distLabel.Size      = UDim2.new(1, 0, 0.25, 0)
    distLabel.Position  = UDim2.new(0, 0, 0.75, 0)
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLabel.TextScaled = true
    distLabel.Font      = Enum.Font.Gotham
    distLabel.TextStrokeTransparency = 0.4
    distLabel.Parent    = billboard

    espInstances[player] = {
        billboard   = billboard,
        nameLabel   = nameLabel,
        healthLabel = healthLabel,
        distLabel   = distLabel,
        healthBar   = healthBar,
        healthFill  = healthFill,
    }
end

local function updateESPScale()
    for _, data in pairs(espInstances) do
        if data.billboard and data.billboard.Parent then
            data.billboard.Size = espScale
        end
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
            else
                createESP(player)
            end
        end
    end
end

-- ESP render
RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end

        local shouldShow = espEnabled and (not espTeamCheck or IsEnemy(player))
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")

        if not shouldShow or not root or not hum then
            removeESP(player)
            continue
        end

        if not espInstances[player] or not espInstances[player].billboard.Parent then
            createESP(player)
        end

        local data = espInstances[player]
        if not data then continue end

        if data.billboard.Adornee ~= root then
            data.billboard.Adornee = root
        end

        local hp      = math.floor(hum.Health)
        local maxHp   = math.max(hum.MaxHealth, 1)
        local hpRatio = math.clamp(hp / maxHp, 0, 1)
        local r = math.clamp(2 * (1 - hpRatio), 0, 1)
        local g = math.clamp(2 * hpRatio, 0, 1)

        data.healthLabel.Text             = "HP: " .. hp .. " / " .. math.floor(maxHp)
        data.healthLabel.TextColor3       = Color3.new(r, g, 0)
        data.healthFill.BackgroundColor3  = Color3.new(r, g, 0)
        data.healthFill.Size              = UDim2.new(hpRatio, 0, 1, 0)

        if myRoot then
            local dist = math.floor((myRoot.Position - root.Position).Magnitude)
            data.distLabel.Text = "Dist: " .. dist .. " studs"
        end

        data.nameLabel.TextColor3 = IsEnemy(player)
            and Color3.fromRGB(255, 80, 80)
            or  Color3.fromRGB(80, 220, 80)
    end
end)

-- ===== HELPERS =====
local function findMyInventory()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return nil end
    for _, v in pairs(playerGui:GetDescendants()) do
        if v.Name == "Inventory" and v:IsA("Frame") then
            MyInventory = v
            return v
        end
    end
    return nil
end

local function getMyInventory()
    if MyInventory and MyInventory.Parent then return MyInventory end
    return findMyInventory()
end

if not getgenv().Idling then
    getgenv().Idling = true
    LocalPlayer.Idled:connect(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end

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
    rootPart.Size        = DEFAULT_SIZE
    rootPart.Transparency = DEFAULT_TRANSPARENCY
    rootPart.Material    = DEFAULT_MATERIAL
    rootPart.CanCollide  = DEFAULT_CAN_COLLIDE
end

local function setHitbox(rootPart)
    if not rootPart or not rootPart.Parent then return end
    rootPart.Size        = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
    rootPart.Transparency = 0.7
    rootPart.BrickColor  = BrickColor.new("Really blue")
    rootPart.Material    = Enum.Material.Neon
    rootPart.CanCollide  = false
end

local function restoreAll()
    for _, player in ipairs(trackedPlayers) do
        restoreRootPart(getRootPart(player))
    end
end

local function updatePlayerList()
    table.clear(trackedPlayers)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(trackedPlayers, player)
        end
    end
end

-- ===== AUTO PICKUP =====
function AutoPickup()
    while autoPickupEnabled do
        task.wait(0.5)
        local replicators = Workspace:FindFirstChild("Replicators")
        if not replicators then return end
        local check = replicators:FindFirstChild("NonPassive") and "NonPassive" or "Passive"
        if IsPlayerAlive(LocalPlayer) then
            local AllPickups = {}
            local mypos = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
            for _, folder in ipairs({replicators:FindFirstChild(check), replicators:FindFirstChild("Both")}) do
                if folder then
                    for _, item in pairs(folder:GetChildren()) do
                        if item:IsA("Model") and (mypos - item:GetPivot().Position).Magnitude < 18.5
                            and not string.find(item.Name:lower(), "clue")
                            and table.find(ALLITEMSTABLE, item.Name) then
                            table.insert(AllPickups, item)
                        end
                    end
                end
            end
            for _, item in pairs(Workspace:GetChildren()) do
                if item:IsA("Model") and (mypos - item:GetPivot().Position).Magnitude < 18.5
                    and not string.find(item.Name:lower(), "clue")
                    and table.find(ALLITEMSTABLE, item.Name) then
                    table.insert(AllPickups, item)
                end
            end
            for _, getitem in ipairs(AllPickups) do
                if not autoPickupEnabled then break end
                repeat
                    task.wait()
                    local statusLabel = LocalPlayer.PlayerGui:FindFirstChild("HUD")
                        and LocalPlayer.PlayerGui.HUD:FindFirstChild("Status")
                        and LocalPlayer.PlayerGui.HUD.Status:FindFirstChild("Content")
                        and LocalPlayer.PlayerGui.HUD.Status.Content:FindFirstChild("Bag")
                        and LocalPlayer.PlayerGui.HUD.Status.Content.Bag:FindFirstChild("StatusLabel")
                    if not statusLabel then break end
                    local split = string.split(statusLabel.Text, "/")
                    if tonumber(split[1]) + 1 >= tonumber(split[2]) then break end
                    if IsPlayerAlive(LocalPlayer) and getitem.Parent then
                        RemoteEvents.ItemInteracted:FireServer(getitem, "Pickup")
                        task.wait(0.1)
                    end
                until not getitem.Parent
                    or (LocalPlayer.Character.HumanoidRootPart.Position - getitem:GetPivot().Position).Magnitude > 18.5
                    or not autoPickupEnabled
            end
        end
    end
end

-- ===== KILL AURA =====
function KillAura()
    while getgenv().configs.KillAura do
        task.wait()
        local range, closest = 32, nil
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and not table.find(Whitelist_table, plr.Name) then
                if IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) then
                    if IsEnemy(plr) then
                        local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                        if dist < range then range = dist closest = plr.Character end
                    end
                end
            end
        end
        if closest then RemoteEvents.ToolAction:FireServer(closest) end
    end
end

-- ===== PLAYER LOCK =====
function PlayerLock()
    local function Wallcheck(target)
        local ray  = Ray.new(Camera.CFrame.Position, (target.Position - Camera.CFrame.Position).Unit * 1000)
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
                    local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(plrpos.X, plrpos.Y)).Magnitude
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
                        snap:Play()
                        snap.Completed:Wait()
                    end
                else
                    CurrentlyLocked = nil
                end
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

-- ===== AUTO EAT =====
function AutoEat()
    local inventory = getMyInventory()
    if not inventory then return end

    local function GreatestFoodSource()
        local highestfood, best = nil, -math.huge
        for _, food in pairs(inventory:GetChildren()) do
            if SWITCHEDITEMSTABLE[food.Name] then
                local nameLabel = food:FindFirstChild("Top") and food.Top:FindFirstChild("NameLabel")
                if nameLabel then
                    local amt = tonumber(string.match(nameLabel.Text, "%d+"))
                    if amt and amt > best then best = amt highestfood = food.Name end
                end
            end
        end
        return highestfood
    end

    local gui        = LocalPlayer:FindFirstChild("PlayerGui")
    local hud        = gui and gui:FindFirstChild("HUD")
    local hungerBar  = hud and hud:FindFirstChild("Status") and hud.Status:FindFirstChild("Content") and hud.Status.Content:FindFirstChild("Hunger")
    local healthBar  = hud and hud.Status and hud.Status.Content and hud.Status.Content:FindFirstChild("Health")
    local maxHunger  = hungerBar and hungerBar:FindFirstChild("Bar")
    local subbar     = healthBar and healthBar:FindFirstChild("Bar") and healthBar.Bar:FindFirstChild("Sub")
    if not maxHunger or not subbar then return end

    while getgenv().configs.AutoEat do
        task.wait()
        local Food = GreatestFoodSource()
        if Food then
            if getgenv().configs.EatingType == "AFK" then
                local cur = hungerBar:FindFirstChild("Bar")
                if cur and IsPlayerAlive(LocalPlayer) then
                    if (maxHunger.AbsoluteSize - cur.AbsoluteSize).Magnitude >= 20.7 then
                        RemoteEvents.InventoryInteraction:FireServer(SWITCHEDITEMSTABLE[Food], "Eat")
                        task.wait()
                    end
                end
            elseif getgenv().configs.EatingType == "War" then
                if IsPlayerAlive(LocalPlayer) then
                    if (subbar.Parent.AbsoluteSize - subbar.AbsoluteSize).Magnitude >= 20.7 then
                        RemoteEvents.InventoryInteraction:FireServer(SWITCHEDITEMSTABLE[Food], "Eat")
                        task.wait()
                    end
                end
            end
        end
    end
end

-- ===== UI =====
local ESPSection = MainTab:CreateSection("ESP")

MainTab:CreateToggle({
    Name = "Enable ESP", CurrentValue = false, Flag = "ESPToggle",
    Callback = function(Value)
        espEnabled = Value
        if Value then rebuildAllESP() else clearAllESP() end
    end,
})

MainTab:CreateToggle({
    Name = "ESP Team Check (Enemies Only)", CurrentValue = false, Flag = "ESPTeamCheck",
    Callback = function(Value)
        espTeamCheck = Value
        rebuildAllESP()
    end,
})

MainTab:CreateSlider({
    Name = "ESP Width", Range = {60, 300}, Increment = 5, Suffix = "px", CurrentValue = 120, Flag = "ESPWidth",
    Callback = function(Value)
        espScale = UDim2.new(0, Value, 0, espScale.Y.Offset)
        updateESPScale()
    end,
})

MainTab:CreateSlider({
    Name = "ESP Height", Range = {30, 200}, Increment = 5, Suffix = "px", CurrentValue = 50, Flag = "ESPHeight",
    Callback = function(Value)
        espScale = UDim2.new(0, espScale.X.Offset, 0, Value)
        updateESPScale()
    end,
})

local HitboxSection = MainTab:CreateSection("Hitbox Editor")

MainTab:CreateToggle({
    Name = "Enable Hitbox", CurrentValue = false, Flag = "HitboxToggle",
    Callback = function(Value)
        hitboxEnabled = Value
        if not hitboxEnabled then restoreAll() end
    end,
})

MainTab:CreateSlider({
    Name = "Hitbox Size", Range = {1, 50}, Increment = 1, Suffix = "Studs", CurrentValue = 10, Flag = "HitboxSize",
    Callback = function(Value) hitboxSize = Value end,
})

MainTab:CreateToggle({
    Name = "Hitbox Team Check (Enemies Only)", CurrentValue = false, Flag = "HitboxTeamCheck",
    Callback = function(Value)
        hitboxTeamCheck = Value
        if not Value and hitboxEnabled then restoreAll() end
    end,
})

local AutoPickupSection = MainTab:CreateSection("Auto Pickup")

MainTab:CreateToggle({
    Name = "Enable Auto Pickup", CurrentValue = false, Flag = "AutoPickupToggle",
    Callback = function(Value)
        autoPickupEnabled = Value
        if Value then task.spawn(AutoPickup) end
    end,
})

local CombatSection = MainTab:CreateSection("Combat")

getgenv().configs = getgenv().configs or {}
getgenv().configs.KillAura  = false
getgenv().configs.PlayerLock = false
getgenv().configs.Pumpkins  = false
getgenv().configs.AutoEat   = false
getgenv().configs.EatingType = "AFK"

MainTab:CreateToggle({
    Name = "Kill Aura", CurrentValue = false, Flag = "KillAuraToggle",
    Callback = function(Value)
        getgenv().configs.KillAura = Value
        if Value then task.spawn(KillAura) end
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

MainTab:CreateToggle({
    Name = "Auto Eat", CurrentValue = false, Flag = "AutoEatToggle",
    Callback = function(Value)
        getgenv().configs.AutoEat = Value
        if Value then task.spawn(AutoEat) end
    end,
})

MainTab:CreateDropdown({
    Name = "Eating Type", Options = {"AFK", "War"}, CurrentOption = "AFK", Flag = "EatingType",
    Callback = function(Value) getgenv().configs.EatingType = Value end,
})

-- ===== HITBOX RENDER LOOP =====
RunService.RenderStepped:Connect(function()
    if not hitboxEnabled then return end
    for _, player in ipairs(trackedPlayers) do
        local rootPart = getRootPart(player)
        if rootPart then
            if hitboxTeamCheck then
                if IsEnemy(player) then setHitbox(rootPart) else restoreRootPart(rootPart) end
            else
                setHitbox(rootPart)
            end
        end
    end
end)

-- ===== PLAYER EVENTS =====
Players.PlayerAdded:Connect(function(player)
    updatePlayerList()
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if espEnabled and (not espTeamCheck or IsEnemy(player)) then
            createESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
    updatePlayerList()
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            task.wait(1)
            if espEnabled and (not espTeamCheck or IsEnemy(player)) then
                createESP(player)
            end
        end)
    end
end

updatePlayerList()
