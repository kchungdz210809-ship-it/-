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
    ToolAction = ReplicatedStorage:WaitForChild('References'):WaitForChild('Comm'):WaitForChild('Events'):WaitForChild('ToolAction'),
    InventoryInteraction = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"),
    UpdateStorageChest = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("UpdateStorageChest"),
    SetSettings = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("SetSettings"),
    BuyWorldEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent"),
    ItemInteracted = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ItemInteracted"),
    CraftItem = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("CraftItem"),
    TradeTrader = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("TradeTrader"),
    KeyDoor = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("KeyDoor"),
    Sonar = ReplicatedStorage:WaitForChild('References'):WaitForChild('Comm'):WaitForChild('Events'):WaitForChild('Sonar')
}

local ALLITEMSTABLE = {
    "Wood", "Stone", "Iron", "Gold", "Diamond", "Coal", "Copper", "Tin",
    "Silver", "Platinum", "Ruby", "Sapphire", "Emerald", "Amethyst",
    "Leather", "Fur", "Feather", "Bone", "String", "Cloth", "Silk"
}

local SWITCHEDITEMSTABLE = {
    ["Raw Potato"] = 4, ["Watermelon"] = 5, ["Banana"] = 7,
    ["Redberry"] = 9, ["Coconut"] = 11, ["Baked Potato"] = 19,
    ["Carrot"] = 41, ["Cabbage"] = 42, ["Cooked Fish"] = 70,
    ["Cooked Meat"] = 103, ["Caveberry"] = 133, ["Slime Ball"] = 147,
    ["Lucky Fruit"] = 151
}

local DEFAULT_SIZE = Vector3.new(2, 2, 1)
local DEFAULT_TRANSPARENCY = 0
local DEFAULT_MATERIAL = Enum.Material.Plastic
local DEFAULT_CAN_COLLIDE = true

local hitboxSize = 10
local hitboxEnabled = false
local hitboxTeamCheck = false
local trackedPlayers = {}
local CurrentlyLocked = nil
local Whitelist_table = {}
local MyInventory = nil
local autoPickupEnabled = false

-- ===== TEAM CHECK HELPER =====
local function IsEnemy(player)
    if not player or not player.Character then return false end
    local char = player.Character

    local myChar = LocalPlayer.Character
    if not myChar then return false end

    local billboard = char:FindFirstChild("PlayerBillboard")
    local myBillboard = myChar:FindFirstChild("PlayerBillboard")
    if not billboard or not myBillboard then return true end

    local title = billboard:FindFirstChild("Title")
    local myTitle = myBillboard:FindFirstChild("Title")
    if not title or not myTitle then return true end

    local icon = title:FindFirstChild("Icon")
    local myIcon = myTitle:FindFirstChild("Icon")
    if not icon or not myIcon then return true end

    local NEUTRAL_COLOR = Color3.fromRGB(80, 63, 47)
    if icon.BackgroundColor3 == NEUTRAL_COLOR then
        return true
    end

    return icon.BackgroundColor3 ~= myIcon.BackgroundColor3
end

local function findMyInventory()
    local playerGui = LocalPlayer:FindFirstChild('PlayerGui')
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
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
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
    rootPart.Size = DEFAULT_SIZE
    rootPart.Transparency = DEFAULT_TRANSPARENCY
    rootPart.Material = DEFAULT_MATERIAL
    rootPart.CanCollide = DEFAULT_CAN_COLLIDE
end

local function setHitbox(rootPart)
    if not rootPart or not rootPart.Parent then return end
    rootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
    rootPart.Transparency = 0.7
    rootPart.BrickColor = BrickColor.new("Really blue")
    rootPart.Material = Enum.Material.Neon
    rootPart.CanCollide = false
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
        local check = replicators:FindFirstChild('NonPassive') and 'NonPassive' or 'Passive'
        if IsPlayerAlive(LocalPlayer) then
            local AllPickups = {}
            local mypos = LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position
            local passive = replicators:FindFirstChild(check)
            if passive then
                for _, item in pairs(passive:GetChildren()) do
                    if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 18.5 and not string.find(item.Name:lower(), 'clue') then
                        if table.find(ALLITEMSTABLE, item.Name) then table.insert(AllPickups, item) end
                    end
                end
            end
            local both = replicators:FindFirstChild('Both')
            if both then
                for _, item in pairs(both:GetChildren()) do
                    if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 18.5 and not string.find(item.Name:lower(), 'clue') then
                        if table.find(ALLITEMSTABLE, item.Name) then table.insert(AllPickups, item) end
                    end
                end
            end
            for _, item in pairs(Workspace:GetChildren()) do
                if item:IsA("Model") and (mypos - item:GetPivot().Position).magnitude < 18.5 and not string.find(item.Name:lower(), 'clue') then
                    if table.find(ALLITEMSTABLE, item.Name) then table.insert(AllPickups, item) end
                end
            end
            if #AllPickups > 0 then
                for _, getitem in ipairs(AllPickups) do
                    if not autoPickupEnabled then break end
                    repeat task.wait()
                        local statusLabel = LocalPlayer:FindFirstChild('PlayerGui'):FindFirstChild('HUD'):FindFirstChild('Status'):FindFirstChild('Content'):FindFirstChild('Bag'):FindFirstChild('StatusLabel')
                        if not statusLabel then break end
                        local mybagspace = string.split(statusLabel.Text, '/')
                        if tonumber(mybagspace[1])+1 >= tonumber(mybagspace[2]) then break end
                        if IsPlayerAlive(LocalPlayer) then
                            if getitem.Parent then
                                RemoteEvents['ItemInteracted']:FireServer(getitem, "Pickup")
                                task.wait(0.1)
                            end
                        end
                    until not getitem.Parent or (LocalPlayer.Character.HumanoidRootPart.Position - getitem:GetPivot().Position).magnitude > 18.5 or tonumber(mybagspace[1])+1 >= tonumber(mybagspace[2]) or not IsPlayerAlive(LocalPlayer) or not autoPickupEnabled
                end
            end
        end
    end
end

-- ===== KILL AURA =====
function KillAura()
    while getgenv().configs.KillAura do
        task.wait()
        local function GetClosestKAPlayer()
            local range = 32
            local closest
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and not table.find(Whitelist_table, plr.Name) then
                    if IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) then
                        local char = plr.Character
                        if char:FindFirstChild("PlayerBillboard") and char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title') and char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon') then
                            if char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 == Color3.fromRGB(80, 63, 47) then
                                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude
                                if dist < range then range = dist closest = plr.Character end
                            else
                                if char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 ~= LocalPlayer.Character:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 then
                                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude
                                    if dist < range then range = dist closest = plr.Character end
                                end
                            end
                        end
                    end
                end
            end
            return closest
        end
        local NearestPlayer = GetClosestKAPlayer()
        if NearestPlayer then RemoteEvents['ToolAction']:FireServer(NearestPlayer) end
    end
end

-- ===== PLAYER LOCK =====
function PlayerLock()
    local function Wallcheck(target)
        local ray = Ray.new(Camera.CFrame.Position, (target.Position - Camera.CFrame.Position).Unit * 1000)
        local part = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character}, false, true)
        if part then
            local humanoid = part.Parent:FindFirstChildOfClass('Humanoid') or part.Parent.Parent:FindFirstChildOfClass('Humanoid')
            if humanoid and target and humanoid.Parent == target.Parent then
                local pos, visible = Camera:WorldToScreenPoint(target.Position)
                if visible then return true end
            end
        end
        return false
    end
    local function GetNearestPlayerToMouse()
        if CurrentlyLocked and CurrentlyLocked.Humanoid.Health > 0 then return CurrentlyLocked end
        local dist = 150
        local closest
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and IsPlayerAlive(plr) and IsPlayerAlive(LocalPlayer) then
                local char = plr.Character
                local plrpos, onscreen = Camera:WorldToViewportPoint(char['HumanoidRootPart'].Position)
                if onscreen then
                    if char:FindFirstChild("PlayerBillboard") and char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title') and char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon') then
                        if char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 == Color3.fromRGB(80, 63, 47) then
                            local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                            local mag = (mousePos - Vector2.new(plrpos.X, plrpos.Y)).Magnitude
                            if mag < dist and (char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude < dist then
                                if Wallcheck(char:FindFirstChild('HumanoidRootPart')) then dist = mag closest = char end
                            end
                        else
                            if char:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 ~= LocalPlayer.Character:FindFirstChild('PlayerBillboard'):FindFirstChild('Title'):FindFirstChild('Icon').BackgroundColor3 then
                                local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                                local mag = (mousePos - Vector2.new(plrpos.X, plrpos.Y)).Magnitude
                                if mag < dist and (char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude < dist then
                                    if Wallcheck(char:FindFirstChild('HumanoidRootPart')) then dist = mag closest = char end
                                end
                            end
                        end
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
                        local SmoothSnap = TweenService:Create(Camera, TweenInfo.new(0.01, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, CurrentlyLocked:FindFirstChild('HumanoidRootPart').Position)})
                        SmoothSnap:Play()
                        SmoothSnap.Completed:Wait()
                    end
                else
                    if CurrentlyLocked ~= nil then CurrentlyLocked = nil end
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
            local hum = LocalPlayer.Character.Humanoid
            if hum.Health < 75 then RemoteEvents['InventoryInteraction']:FireServer(378, "Eat") end
        end
    end
end

-- ===== AUTO EAT =====
function AutoEat()
    local inventory = getMyInventory()
    if not inventory then return end
    local function GreatestFoodSource()
        local foodtable = {}
        local highestfood
        local greatestfoodpossible = -math.huge
        for _, food in pairs(inventory:GetChildren()) do
            if SWITCHEDITEMSTABLE[food.Name] then table.insert(foodtable, food) end
        end
        for _, food in pairs(foodtable) do
            local nameLabel = food:FindFirstChild('Top') and food.Top:FindFirstChild('NameLabel')
            if nameLabel then
                local foodamount = tonumber(string.match(nameLabel.Text, '%d+'))
                if foodamount and foodamount > greatestfoodpossible then
                    greatestfoodpossible = foodamount
                    highestfood = food.Name
                end
            end
        end
        return highestfood
    end
    local playerGui = LocalPlayer:FindFirstChild('PlayerGui')
    if not playerGui then return end
    local hud = playerGui:FindFirstChild('HUD')
    if not hud then return end
    local status = hud:FindFirstChild('Status')
    if not status then return end
    local content = status:FindFirstChild('Content')
    if not content then return end
    local hungerBar = content:FindFirstChild('Hunger')
    if not hungerBar then return end
    local healthBar = content:FindFirstChild('Health')
    if not healthBar then return end
    local maxhungerbar = hungerBar:FindFirstChild('Bar')
    if not maxhungerbar then return end
    local subbar = healthBar:FindFirstChild('Bar')
    if not subbar then return end
    subbar = subbar:FindFirstChild('Sub')
    if not subbar then return end

    while getgenv().configs.AutoEat do
        task.wait()
        local Food = GreatestFoodSource()
        if Food then
            if getgenv().configs.EatingType == 'AFK' then
                local currenthungerbar = hungerBar:FindFirstChild('Bar')
                if currenthungerbar and IsPlayerAlive(LocalPlayer) then
                    if (maxhungerbar.AbsoluteSize - currenthungerbar.AbsoluteSize).magnitude >= 20.7 then
                        RemoteEvents['InventoryInteraction']:FireServer(SWITCHEDITEMSTABLE[Food], 'Eat')
                        task.wait()
                    end
                end
            elseif getgenv().configs.EatingType == 'War' then
                local maxsubbar = subbar.Parent.AbsoluteSize
                if IsPlayerAlive(LocalPlayer) then
                    if (maxsubbar - subbar.AbsoluteSize).magnitude >= 20.7 then
                        RemoteEvents['InventoryInteraction']:FireServer(SWITCHEDITEMSTABLE[Food], 'Eat')
                        task.wait()
                    end
                end
            end
        end
    end
end

-- ===== UI =====
local HitboxSection = MainTab:CreateSection("Hitbox Editor")

local ToggleHitbox = MainTab:CreateToggle({
    Name = "Enable Hitbox",
    CurrentValue = false,
    Flag = "HitboxToggle",
    Callback = function(Value)
        hitboxEnabled = Value
        if not hitboxEnabled then restoreAll() end
    end,
})

local HitboxSlider = MainTab:CreateSlider({
    Name = "Hitbox Size",
    Range = {1, 50},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 10,
    Flag = "HitboxSize",
    Callback = function(Value)
        hitboxSize = Value
    end,
})

local ToggleHitboxTeamCheck = MainTab:CreateToggle({
    Name = "Hitbox Team Check (Enemies Only)",
    CurrentValue = false,
    Flag = "HitboxTeamCheck",
    Callback = function(Value)
        hitboxTeamCheck = Value
        if not Value and hitboxEnabled then
            restoreAll()
        end
    end,
})

local AutoPickupSection = MainTab:CreateSection("Auto Pickup")

local ToggleAutoPickup = MainTab:CreateToggle({
    Name = "Enable Auto Pickup",
    CurrentValue = false,
    Flag = "AutoPickupToggle",
    Callback = function(Value)
        autoPickupEnabled = Value
        if Value then task.spawn(AutoPickup) end
    end
})

local CombatSection = MainTab:CreateSection("Combat")

getgenv().configs = getgenv().configs or {}
getgenv().configs.KillAura = false
getgenv().configs.PlayerLock = false
getgenv().configs.Pumpkins = false
getgenv().configs.AutoEat = false
getgenv().configs.EatingType = 'AFK'

local ToggleKillAura = MainTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "KillAuraToggle",
    Callback = function(Value)
        getgenv().configs.KillAura = Value
        if Value then task.spawn(KillAura) end
    end
})

local TogglePlayerLock = MainTab:CreateToggle({
    Name = "Player Lock (Right Click)",
    CurrentValue = false,
    Flag = "PlayerLockToggle",
    Callback = function(Value)
        getgenv().configs.PlayerLock = Value
        if Value then PlayerLock() end
    end
})

local TogglePumpkins = MainTab:CreateToggle({
    Name = "Auto Pumpkins (Health < 75)",
    CurrentValue = false,
    Flag = "PumpkinsToggle",
    Callback = function(Value)
        getgenv().configs.Pumpkins = Value
        if Value then task.spawn(Pumpkins) end
    end
})

local ToggleAutoEat = MainTab:CreateToggle({
    Name = "Auto Eat",
    CurrentValue = false,
    Flag = "AutoEatToggle",
    Callback = function(Value)
        getgenv().configs.AutoEat = Value
        if Value then task.spawn(AutoEat) end
    end
})

local EatingTypeDropdown = MainTab:CreateDropdown({
    Name = "Eating Type",
    Options = {"AFK", "War"},
    CurrentOption = "AFK",
    Flag = "EatingType",
    Callback = function(Value)
        getgenv().configs.EatingType = Value
    end
})

-- ===== RENDER LOOP =====
RunService.RenderStepped:Connect(function()
    if not hitboxEnabled then return end
    for _, player in ipairs(trackedPlayers) do
        local rootPart = getRootPart(player)
        if rootPart then
            if hitboxTeamCheck then
                -- Team check ON: only expand enemies, restore teammates
                if IsEnemy(player) then
                    setHitbox(rootPart)
                else
                    restoreRootPart(rootPart)
                end
            else
                -- Team check OFF: expand everyone
                setHitbox(rootPart)
            end
        end
    end
end)

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()
