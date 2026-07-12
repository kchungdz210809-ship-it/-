-- ===== Fluent UI Loader =====
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- ===== Window =====
local Window = Fluent:CreateWindow({
    Title = "🌴Island Tribes 🌴",
    SubTitle = "Made by Chung credit #Chungdz",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- ===== Tabs =====
local Tabs = {
    Main = Window:AddTab({ Title = "🏠 Main" }),
    Duping = Window:AddTab({ Title = "🤑 Duping" }),
    Crazy = Window:AddTab({ Title = "😵‍💫 Crazy Dupe" }),
    Armor = Window:AddTab({ Title = "🛡️ Armor & Weapons" }),
    OpenDrop = Window:AddTab({ Title = "📦 Open & Drop" }),
    Other = Window:AddTab({ Title = "🔧 Other" }),
    Autofarm = Window:AddTab({ Title = "🤖 Autofarm" })
}

-- ===== Services =====
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local MyInventory = LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:FindFirstChild("StarterGear")

-- ===== RemoteEvents =====
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

-- ===== Biến toàn cục =====
getgenv().configs = getgenv().configs or {}
getgenv().configs.AutoPickup = false
getgenv().configs.Hitbox = false
getgenv().configs.ConiferFarm = false
getgenv().configs.ObsidianBoss = false
getgenv().configs.ZenLuckBoss = false
getgenv().configs.SpiritBoss = false
getgenv().configs.LuckySlime = false
getgenv().configs.EvilSkeleton = false
getgenv().configs.Ogre = false
getgenv().configs.Squid = false
getgenv().configs.AutoRepairClub = false
getgenv().configs.UseSoulKeys = false
AutoAttackPlayer = false
KillAuraLoop = nil
healingEnabled = false
healTask = nil
getgenv().bypassing = false
getgenv().AutoPickupLoop = nil

-- ===== Shared Functions =====
local function IsPlayerAlive(player)
    return player and player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local ALLITEMSTABLE = {
    "Snow", "Candy", "Pumpkin", "Fruit", "Chest", "Glider", "Ore", "Stone", "Wood",
    "Leather", "Iron", "Gold", "Diamond", "Obsidian", "MoonStone", "Volcanic", "Lunar",
    "Stick", "Rock", "Berries", "Meat", "Fish", "Egg", "Milk", "Apple", "Pear",
    "Banana", "Orange", "Lemon", "Coconut", "Watermelon", "Soul", "Zen", "Lucky"
}

local function GetClosestChest()
    local closest, range = nil, math.huge
    local replicators = Workspace:FindFirstChild("Replicators")
    if not replicators then return nil end
    local chestFolder = replicators:FindFirstChild("NonPassive") or replicators:FindFirstChild("Passive")
    if not chestFolder then return nil end
    if IsPlayerAlive(LocalPlayer) then
        local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        for _, chest in pairs(chestFolder:GetChildren()) do
            if string.find(chest.Name, "Storage") and chest:FindFirstChildOfClass("MeshPart") then
                local part = chest:FindFirstChildOfClass("MeshPart")
                local dist = (hrp.Position - part.Position).Magnitude
                if dist < range then
                    range, closest = dist, chest
                end
            end
        end
    end
    return closest
end

-- ===== AutoPickup =====
local function StartAutoPickup()
    if getgenv().AutoPickupLoop then
        task.cancel(getgenv().AutoPickupLoop)
        getgenv().AutoPickupLoop = nil
    end
    if not getgenv().configs.AutoPickup then return end
    
    getgenv().AutoPickupLoop = task.spawn(function()
        while getgenv().configs.AutoPickup do
            task.wait(0.5)
            if not IsPlayerAlive(LocalPlayer) then task.wait(1) continue end
            local character = LocalPlayer.Character
            if not character then continue end
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart then continue end
            local mypos = rootPart.Position
            local AllPickups = {}
            
            for _, item in pairs(workspace:GetDescendants()) do
                if item:IsA("Model") and item ~= character then
                    local primary = item:FindFirstChild("HumanoidRootPart") or item:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        local pos = primary.Position
                        if pos and (mypos - pos).magnitude < 20 then
                            for _, name in pairs(ALLITEMSTABLE) do
                                if string.find(item.Name:lower(), name:lower()) then
                                    table.insert(AllPickups, item)
                                    break
                                end
                            end
                        end
                    end
                end
            end
            
            for _, item in ipairs(AllPickups) do
                if not getgenv().configs.AutoPickup then break end
                if not item.Parent then continue end
                if not IsPlayerAlive(LocalPlayer) then break end
                RemoteEvents['ItemInteracted']:FireServer(item, "Pickup")
                task.wait(0.05)
            end
        end
    end)
end

-- ===== Hitbox =====
function Hitbox()
    while getgenv().configs.Hitbox do
        task.wait(0.2)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and IsPlayerAlive(plr) then
                local hitbox = plr.Character:FindFirstChild('Hitbox')
                if hitbox and hitbox.Size ~= Vector3.new(20, 20, 20) then
                    hitbox.Size = Vector3.new(20, 20, 20)
                end
            end
        end
    end
end

-- ===== Anti-AFK =====
if not getgenv().Idling then
    getgenv().Idling = true
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(0.5)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end

-- ===== AUTOFARM FUNCTIONS =====
local function AutoPickupBoss()
    if not IsPlayerAlive(LocalPlayer) then return end
    local mypos = LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position
    for _, item in pairs(Workspace:GetDescendants()) do
        if item:IsA("Model") and item ~= LocalPlayer.Character then
            local primary = item:FindFirstChild("HumanoidRootPart") or item:FindFirstChildWhichIsA("BasePart")
            if primary then
                local pos = primary.Position
                if pos and (mypos - pos).magnitude < 20 then
                    for _, name in pairs(ALLITEMSTABLE) do
                        if string.find(item.Name:lower(), name:lower()) then
                            RemoteEvents['ItemInteracted']:FireServer(item, "Pickup")
                            task.wait(0.05)
                            break
                        end
                    end
                end
            end
        end
    end
end

function ConiferFarm()
    local function GetClosestTree()
        local range, closesttree = math.huge, nil
        for _, tree in pairs(Workspace:WaitForChild('Replicators'):WaitForChild('Both'):GetChildren()) do
            if tree.Name == 'Conifer' and IsPlayerAlive(LocalPlayer) then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - tree:GetPivot().Position).magnitude
                if dist < range then
                    range, closesttree = dist, tree
                end
            end
        end
        return closesttree
    end
    while getgenv().configs.ConiferFarm and task.wait() do
        if IsPlayerAlive(LocalPlayer) then
            local tree = GetClosestTree()
            if tree and tree.Parent then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(tree:GetPivot().Position)
                RemoteEvents['ToolAction']:FireServer(tree)
            else
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.X, 400, LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
            end
        end
    end
end

function ObsidianBoss()
    while getgenv().configs.ObsidianBoss do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Obsidian Golem')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not getgenv().AutoPickupOnObsidianDeath then
                    getgenv().AutoPickupOnObsidianDeath = Boss.AncestryChanged:Connect(function(golem, parent)
                        if not getgenv().configs.ObsidianBoss then
                            getgenv().AutoPickupOnObsidianDeath:Disconnect()
                            getgenv().AutoPickupOnObsidianDeath = nil
                        end
                        if not parent then
                            task.wait(0.2)
                            AutoPickupBoss()
                            if getgenv().AutoPickupOnObsidianDeath then
                                getgenv().AutoPickupOnObsidianDeath:Disconnect()
                                getgenv().AutoPickupOnObsidianDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(-8, 13.5, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 15, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            end
        end
    end
end

function ZenLuckBoss()
    local function AttackBoss()
        local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Zenyte Golem') or Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Lucky Golem')
        if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
            if not getgenv().AutoPickupOnZenLuckBossDeath then
                getgenv().AutoPickupOnZenLuckBossDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                    if not getgenv().configs.ZenLuckBoss then
                        getgenv().AutoPickupOnZenLuckBossDeath:Disconnect()
                        getgenv().AutoPickupOnZenLuckBossDeath = nil
                    end
                    if not parent then
                        task.wait(0.2)
                        AutoPickupBoss()
                        if getgenv().AutoPickupOnZenLuckBossDeath then
                            getgenv().AutoPickupOnZenLuckBossDeath:Disconnect()
                            getgenv().AutoPickupOnZenLuckBossDeath = nil
                        end
                    end
                end)
            end
            local bosspos = Boss.HumanoidRootPart.Position
            local myroot = LocalPlayer.Character.HumanoidRootPart
            if Boss.Humanoid.Health > 50 then
                myroot.CFrame = CFrame.new(bosspos + Vector3.new(-8, 13, 0))
            else
                myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 10, 0))
            end
            RemoteEvents['ToolAction']:FireServer(Boss)
        else
            if IsPlayerAlive(LocalPlayer) then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1663, -460, -4558)
                RemoteEvents['KeyDoor']:FireServer(Workspace:WaitForChild('Map'):WaitForChild("Zenyte Boss Cave"):WaitForChild("Cave Door (z)"))
            end
        end
    end
    while getgenv().configs.ZenLuckBoss do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Soul = MyInventory:FindFirstChild('Soul')
            if getgenv().configs.ObsidianBoss then
                if not Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Obsidian Golem') then
                    AttackBoss()
                end
            else
                AttackBoss()
            end
            if getgenv().configs.UseSoulKeys and Soul and Soul:FindFirstChild('Top') then
                local SoulAmount = string.match(Soul.Top.TextLabel.Text, '%d+')
                if tonumber(SoulAmount) >= 10 and not MyInventory:FindFirstChild('Soul Key') then
                    RemoteEvents['CraftItem']:FireServer(220)
                end
            end
        end
    end
end

function SpiritBoss()
    local function AttackBoss()
        local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Zenyte Golem') or Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Lucky Golem')
        if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
            if not getgenv().AutoPickupOnSpiritBossDeath then
                getgenv().AutoPickupOnSpiritBossDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                    if not getgenv().configs.SpiritBoss then
                        getgenv().AutoPickupOnSpiritBossDeath:Disconnect()
                        getgenv().AutoPickupOnSpiritBossDeath = nil
                    end
                    if not parent then
                        task.wait(0.2)
                        AutoPickupBoss()
                        if getgenv().AutoPickupOnSpiritBossDeath then
                            getgenv().AutoPickupOnSpiritBossDeath:Disconnect()
                            getgenv().AutoPickupOnSpiritBossDeath = nil
                        end
                    end
                end)
            end
            local bosspos = Boss.HumanoidRootPart.Position
            local myroot = LocalPlayer.Character.HumanoidRootPart
            if Boss.Humanoid.Health >= 50 then
                TweenService:Create(myroot, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {CFrame = CFrame.new(bosspos + Vector3.new(-13, 18, 0))}):Play()
            else
                TweenService:Create(myroot, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(bosspos + Vector3.new(0, 22, 0))}):Play()
            end
            RemoteEvents['ToolAction']:FireServer(Boss)
        else
            if IsPlayerAlive(LocalPlayer) then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1663, -460, -4558)
                RemoteEvents['KeyDoor']:FireServer(Workspace:WaitForChild('Map'):WaitForChild("Mushroom Boss Cave "):WaitForChild("Cave Door (d)"))
            end
        end
    end
    while getgenv().configs.SpiritBoss do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Soul = MyInventory:FindFirstChild('Soul')
            if getgenv().configs.ObsidianBoss then
                if not Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Obsidian Golem') then
                    AttackBoss()
                end
            else
                AttackBoss()
            end
            if getgenv().configs.UseSoulKeys and Soul and Soul:FindFirstChild('Top') then
                local SoulAmount = string.match(Soul.Top.TextLabel.Text, '%d+')
                if tonumber(SoulAmount) >= 10 and not MyInventory:FindFirstChild('Soul Key') then
                    RemoteEvents['CraftItem']:FireServer(220)
                end
            end
        end
    end
end

function LuckySlime()
    while getgenv().configs.LuckySlime do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):WaitForChild('Both'):FindFirstChild('Lucky Slime')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not getgenv().AutoPickuponLuckySlimeDeath then
                    getgenv().AutoPickuponLuckySlimeDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                        if not getgenv().configs.LuckySlime then
                            getgenv().AutoPickuponLuckySlimeDeath:Disconnect()
                            getgenv().AutoPickuponLuckySlimeDeath = nil
                        end
                        if not parent then
                            task.wait(0.2)
                            AutoPickupBoss()
                            if getgenv().AutoPickuponLuckySlimeDeath then
                                getgenv().AutoPickuponLuckySlimeDeath:Disconnect()
                                getgenv().AutoPickuponLuckySlimeDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(-8, 13.5, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 15, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            end
        end
    end
end

function EvilSkeleton()
    while getgenv().configs.EvilSkeleton do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Evil Skeleton')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not getgenv().AutoPickupOnSkeletonDeath then
                    getgenv().AutoPickupOnSkeletonDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                        if not getgenv().configs.EvilSkeleton then
                            getgenv().AutoPickupOnSkeletonDeath:Disconnect()
                            getgenv().AutoPickupOnSkeletonDeath = nil
                        end
                        if not parent then
                            task.wait(0.2)
                            AutoPickupBoss()
                            if getgenv().AutoPickupOnSkeletonDeath then
                                getgenv().AutoPickupOnSkeletonDeath:Disconnect()
                                getgenv().AutoPickupOnSkeletonDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, -15, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 17.5, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            end
        end
    end
end

function Ogre()
    while getgenv().configs.Ogre do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Ogre')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not getgenv().AutoPickupOnOgreDeath then
                    getgenv().AutoPickupOnOgreDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                        if not getgenv().configs.Ogre then
                            getgenv().AutoPickupOnOgreDeath:Disconnect()
                            getgenv().AutoPickupOnOgreDeath = nil
                        end
                        if not parent then
                            task.wait(0.2)
                            AutoPickupBoss()
                            if getgenv().AutoPickupOnOgreDeath then
                                getgenv().AutoPickupOnOgreDeath:Disconnect()
                                getgenv().AutoPickupOnOgreDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(-8, 13.5, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 15, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            end
        end
    end
end

function Squid()
    while getgenv().configs.Squid do
        task.wait()
        if IsPlayerAlive(LocalPlayer) then
            local Boss = Workspace:WaitForChild('Replicators'):FindFirstChild('NonPassive'):FindFirstChild('Captain Squid')
            if Boss and Boss:FindFirstChild('HumanoidRootPart') and Boss:FindFirstChild('Humanoid') and Boss:FindFirstChild('Humanoid').Health > 0 then
                if not getgenv().AutoPickupOnSquidDeath then
                    getgenv().AutoPickupOnSquidDeath = Boss.AncestryChanged:Connect(function(slime, parent)
                        if not getgenv().configs.Squid then
                            getgenv().AutoPickupOnSquidDeath:Disconnect()
                            getgenv().AutoPickupOnSquidDeath = nil
                        end
                        if not parent then
                            task.wait(0.2)
                            AutoPickupBoss()
                            if getgenv().AutoPickupOnSquidDeath then
                                getgenv().AutoPickupOnSquidDeath:Disconnect()
                                getgenv().AutoPickupOnSquidDeath = nil
                            end
                        end
                    end)
                end
                local bosspos = Boss.HumanoidRootPart.Position
                local myroot = LocalPlayer.Character.HumanoidRootPart
                if Boss.Humanoid.Health > 50 then
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, -15, 0))
                else
                    myroot.CFrame = CFrame.new(bosspos + Vector3.new(0, 17.5, 0))
                end
                RemoteEvents['ToolAction']:FireServer(Boss)
            end
        end
    end
end

-- ===== TAB 1: Main =====
Tabs.Main:AddSection("Other Scripts")

Tabs.Main:AddButton({
    Title = "Ctrl + click TP",
    Description = "Teleport by clicking",
    Callback = function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Click%20Teleport.txt"))()
    end
})

Tabs.Main:AddButton({
    Title = "Infinite Yield",
    Description = "Admin commands",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

Tabs.Main:AddButton({
    Title = "Dark Dex",
    Description = "Explorer",
    Callback = function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
    end
})

Tabs.Main:AddButton({
    Title = "ESP",
    Description = "Wallhack",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/ESP.lua"))()
    end
})

Tabs.Main:AddButton({
    Title = "Shiftlock Mobile",
    Description = "Enables shiftlock",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/ltseverydayyou/uuuuuuu/blob/main/shiftlock?raw=true"))()
    end
})

Tabs.Main:AddSection("Anti-Cheat Bypass")

Tabs.Main:AddButton({
    Title = "AC Bypass",
    Description = "Bypass Anti-Cheat using Sonar spam",
    Callback = function()
        if not IsPlayerAlive(LocalPlayer) then
            Fluent:Notify({ Title = "Not alive", Content = "Maybe click the play button?", Duration = 5 })
            return
        end
        local oldpos = LocalPlayer.Character.HumanoidRootPart.CFrame
        local myroot = LocalPlayer.Character.HumanoidRootPart
        for i = 1, 100 do
            myroot.CFrame = CFrame.new(7562, 221, 18946)
            RemoteEvents['Sonar']:FireServer()
            myroot.CFrame = oldpos
        end
        Fluent:Notify({ Title = "Success", Content = "Bypassed AntiCheat", Duration = 4 })
    end
})

if not getgenv().bypassing then
    getgenv().bypassing = true
    local bypassac
    bypassac = hookmetamethod(game, '__namecall', function(self, ...)
        if not checkcaller() and self == RemoteEvents['Sonar'] then
            return nil
        end
        return bypassac(self, ...)
    end)
end

Tabs.Main:AddSection("Toggles")

Tabs.Main:AddToggle("KillAura", {
    Title = "Kill Aura",
    Description = "Auto attack nearest player",
    Default = false,
    Callback = function(value)
        AutoAttackPlayer = value
        if AutoAttackPlayer then
            if KillAuraLoop then return end
            KillAuraLoop = task.spawn(function()
                while AutoAttackPlayer do
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    if HumanoidRootPart then
                        local closestPlayer, closestDistance = nil, 30
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHRP = player.Character.HumanoidRootPart
                                local dist = (targetHRP.Position - HumanoidRootPart.Position).Magnitude
                                if dist <= closestDistance then
                                    closestPlayer, closestDistance = player.Character, dist
                                end
                            end
                        end
                        if closestPlayer then
                            RemoteEvents['ToolAction']:FireServer(closestPlayer)
                        end
                    end
                    task.wait(0.01)
                end
                KillAuraLoop = nil
            end)
        else
            if KillAuraLoop then task.cancel(KillAuraLoop) KillAuraLoop = nil end
        end
    end
})

Tabs.Main:AddToggle("InfJump", {
    Title = "Infinite Jump",
    Description = "Jump forever",
    Default = false,
    Callback = function(value)
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Infinite%20Jump.txt"))()
    end
})

local craftToggle = Tabs.Main:AddToggle("AutoCraft", {
    Title = "Auto Craft Closest Player [R]",
    Description = "Press R to toggle",
    Default = false,
    Callback = function(value)
        getgenv().AutoCraftClosestPlayer = value
        task.spawn(function()
            while getgenv().AutoCraftClosestPlayer do
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart then
                    local closestPlayer, closestDistance = nil, 40
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local targetHRP = player.Character.HumanoidRootPart
                            local dist = (targetHRP.Position - HumanoidRootPart.Position).Magnitude
                            if dist <= closestDistance then
                                closestPlayer, closestDistance = player.Character, dist
                            end
                        end
                    end
                    if closestPlayer then
                        local pos = closestPlayer.HumanoidRootPart.Position
                        RemoteEvents['CraftItem']:FireServer(264, vector.create(pos.X, pos.Y - 3, pos.Z), 0)
                    end
                end
                task.wait(0.5)
            end
        end)
    end
})

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.R then
        getgenv().AutoCraftClosestPlayer = not getgenv().AutoCraftClosestPlayer
        craftToggle:SetValue(getgenv().AutoCraftClosestPlayer)
    end
end)

Tabs.Main:AddToggle("HealPumpkin", {
    Title = "Spam Pumpkin If <100HP",
    Description = "Eat pumpkin when health low",
    Default = false,
    Callback = function(value)
        healingEnabled = value
        if not healingEnabled then
            healTask = nil
            return
        end
        if not healTask then
            healTask = task.spawn(function()
                while healingEnabled do
                    task.wait(0.01)
                    if not IsPlayerAlive(LocalPlayer) then break end
                    local hum = LocalPlayer.Character.Humanoid
                    if hum.Health < 100 then
                        RemoteEvents['InventoryInteraction']:FireServer(378, "Eat")
                    end
                end
            end)
        end
    end
})

Tabs.Main:AddToggle("AutoPickup", {
    Title = "Auto Pickup",
    Description = "Auto pickup items nearby",
    Default = false,
    Callback = function(value)
        getgenv().configs.AutoPickup = value
        StartAutoPickup()
    end
})

Tabs.Main:AddToggle("Hitbox", {
    Title = "Big Hitbox",
    Description = "Enlarge enemy hitbox to 20x20x20",
    Default = false,
    Callback = function(value)
        getgenv().configs.Hitbox = value
        if value then task.spawn(Hitbox) end
    end
})

Tabs.Main:AddSlider("WalkSpeed", {
    Title = "WalkSpeed",
    Description = "Adjust movement speed",
    Default = 16,
    Min = 1,
    Max = 350,
    Rounding = 1,
    Callback = function(value)
        if LocalPlayer.Character then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

Tabs.Main:AddSlider("JumpPower", {
    Title = "JumpPower",
    Description = "Adjust jump height",
    Default = 16,
    Min = 1,
    Max = 350,
    Rounding = 1,
    Callback = function(value)
        if LocalPlayer.Character then
            LocalPlayer.Character.Humanoid.JumpPower = value
        end
    end
})

-- ===== TAB 2: Duping =====
Tabs.Duping:AddSection("Start Duping")

Tabs.Duping:AddButton({
    Title = "🏁 Start Dupe",
    Description = "Begin duplication process",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", { Title = "Dupe Started", Text = "Dupe process started.", Duration = 4 })
        RemoteEvents['SetSettings']:FireServer(RemoteEvents['SetSettings'])
    end
})

local function createPackButton(tab, name, itemID, count, putOut)
    tab:AddButton({
        Title = name,
        Description = (putOut and "PutOut " or "PutIn ") .. count .. "x",
        Callback = function()
            local chest = GetClosestChest()
            if not chest then return end
            for i = 1, count do
                RemoteEvents['UpdateStorageChest']:FireServer(chest, not putOut, itemID)
            end
        end
    })
end

Tabs.Duping:AddSection("Packs")
createPackButton(Tabs.Duping, "Snow Pack 500x", 346, 500, false)
createPackButton(Tabs.Duping, "PutOut Snow Pack 500x", 346, 500, true)
createPackButton(Tabs.Duping, "Candy Poion 500x", 372, 500, false)
createPackButton(Tabs.Duping, "PutOut Candy Poion 500x", 372, 500, true)
createPackButton(Tabs.Duping, "Chest pack 500x", 382, 500, false)
createPackButton(Tabs.Duping, "Putout Chest pack 25x", 382, 25, true)
createPackButton(Tabs.Duping, "Candypack 500x 😊", 188, 500, false)
createPackButton(Tabs.Duping, "PutOut Candypack 500x 😊", 188, 500, true)
createPackButton(Tabs.Duping, "Fruit pack 25x", 325, 25, false)
createPackButton(Tabs.Duping, "PutOut Fruit pack 25x", 325, 25, true)
createPackButton(Tabs.Duping, "Prot. pack 25x", 317, 25, false)
createPackButton(Tabs.Duping, "Warr. pack 25x", 318, 25, false)

Tabs.Duping:AddButton({
    Title = "Zen Pack 500x",
    Description = "PutIn Zen",
    Callback = function()
        local localChest = Workspace.Replicators.NonPassive["Obsidian Storage Chest"]
        if not localChest then return end
        for i = 1, 500 do RemoteEvents['UpdateStorageChest']:FireServer(localChest, true, 327) end
    end
})

Tabs.Duping:AddButton({
    Title = "Diamond Pack 500x",
    Description = "PutIn Diamond",
    Callback = function()
        local localChest = Workspace.Replicators.NonPassive["Obsidian Storage Chest"]
        if not localChest then return end
        for i = 1, 500 do RemoteEvents['UpdateStorageChest']:FireServer(localChest, true, 326) end
    end
})

createPackButton(Tabs.Duping, "Fresh pack 25x", 111, 25, false)
createPackButton(Tabs.Duping, "Stone pack 25x", 112, 25, false)

Tabs.Duping:AddButton({
    Title = "Dupe All x500",
    Description = "Multiple items",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then return end
        local ids = {203,204,216,188,325,272,301,271}
        for i = 1, 499 do
            for _, id in ipairs(ids) do RemoteEvents['UpdateStorageChest']:FireServer(chest, true, id) end
        end
    end
})

Tabs.Duping:AddButton({
    Title = "Dupe All2 x500",
    Description = "Another set",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then return end
        local ids = {112,382,378,225,226,227,228,201,202}
        for i = 1, 499 do
            for _, id in ipairs(ids) do RemoteEvents['UpdateStorageChest']:FireServer(chest, true, id) end
        end
    end
})

-- ===== TAB 3: Crazy Dupe =====
Tabs.Crazy:AddSection("Gliders 🪁")
Tabs.Crazy:AddButton({ Title = "Easter Glider", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 272) end end })
Tabs.Crazy:AddButton({ Title = "Glider", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 301) end end })

Tabs.Crazy:AddSection("Others")
Tabs.Crazy:AddButton({ Title = "Portal Book", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 313) end end })
Tabs.Crazy:AddButton({ Title = "Deflect Book", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 323) end end })
Tabs.Crazy:AddButton({ Title = "Freezio Book", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 310) end end })
Tabs.Crazy:AddButton({ Title = "Oofio Book", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 309) end end })
Tabs.Crazy:AddButton({ Title = "Pumpkin Shield 10x", Description = "PutIn", Callback = function() local c = GetClosestChest() if c then for i=1,10 do RemoteEvents['UpdateStorageChest']:FireServer(c, true, 379) end end end })
createPackButton(Tabs.Crazy, "Easter Candy 500x", 271, 500, false)
createPackButton(Tabs.Crazy, "PutOut Easter Candy 500x", 271, 500, true)
createPackButton(Tabs.Crazy, "Pumpkin 500x", 378, 500, false)
createPackButton(Tabs.Crazy, "PutOut Pumpkin 500x", 378, 500, true)
createPackButton(Tabs.Crazy, "Hard Chest 25x", 168, 25, false)
createPackButton(Tabs.Crazy, "PutOut Hard Chest 25x", 168, 25, true)

-- ===== TAB 4: Armor and Weapons =====
Tabs.Armor:AddSection("Armor")
Tabs.Armor:AddButton({ Title = "🌋 Dupe Obsidian Armor", Description = "Full set", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({225,226,227,228,235}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "🦴 Soul Duping", Description = "Soul items", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({204,202,201,203,218,216}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "MoonStone Set Duping", Description = "Moon set", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({369,366,365,364,363}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "Starter Pack Duping", Description = "Starter", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({354,355,356,357,358,359}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })

Tabs.Armor:AddSection("Sword And Bow")
Tabs.Armor:AddButton({ Title = "MoonSword And ObClub", Description = "Weapons", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({369,230}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "MoonBow, ZenBow And DiaBow", Description = "Bows", Callback = function() local c=GetClosestChest() if c then for _,id in pairs({199,198,376}) do RemoteEvents['UpdateStorageChest']:FireServer(c, true, id) end end end })
Tabs.Armor:AddButton({ Title = "Vision Staff", Description = "Staff", Callback = function() local c=GetClosestChest() if c then RemoteEvents['UpdateStorageChest']:FireServer(c, true, 293) end end })

-- ===== TAB 5: Open and Drop =====
Tabs.OpenDrop:AddSection("Open Chest")
Tabs.OpenDrop:AddButton({ Title = "Open Easy Chest", Description = "Open", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(166, "Open") end })
Tabs.OpenDrop:AddButton({ Title = "Open Medium Chest", Description = "Open", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(167, "Open") end })
Tabs.OpenDrop:AddButton({ Title = "Open Hard Chest", Description = "Open", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(168, "Open") end })

Tabs.OpenDrop:AddSection("Teleport")
Tabs.OpenDrop:AddButton({ Title = "Leaderboard Place", Description = "TP to coords", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5313,4,-5508) end end })

Tabs.OpenDrop:AddSection("Drop")
local function dropButton(title, id)
    Tabs.OpenDrop:AddButton({ Title = title, Description = "Drop", Callback = function() RemoteEvents['InventoryInteraction']:FireServer(id, "Drop") end })
end
dropButton("Glider", 301)
dropButton("Candy Pack", 188)
dropButton("Warrior Pack", 318)
dropButton("Fruit Pack", 325)
dropButton("Chest Pack", 382)
dropButton("Drop Easy Chest", 166)
dropButton("Drop Medium Chest", 167)
dropButton("Drop Hard Chest", 168)
dropButton("Drop Lunar Arrow", 377)
dropButton("Ob Snowball", 352)

-- ===== TAB 6: Other =====
Tabs.Other:AddSection("Moon And Ob")
createPackButton(Tabs.Other, "Volcanic Ore x200", 223, 200, false)
createPackButton(Tabs.Other, "Obsidian x200", 224, 200, false)
createPackButton(Tabs.Other, "Lunar Ore x200", 360, 200, false)
createPackButton(Tabs.Other, "PutOut Lunar Ore x200", 360, 200, true)
createPackButton(Tabs.Other, "MoonStone x200", 361, 200, false)
createPackButton(Tabs.Other, "jack lantern", 337, 200, false)

Tabs.Other:AddButton({
    Title = "Snowball Drop",
    Description = "Drop many",
    Callback = function()
        local c = GetClosestChest()
        if not c then return end
        local ids = {352,353}
        for i=1,500 do
            for _,id in ipairs(ids) do RemoteEvents['UpdateStorageChest']:FireServer(c, false, id) end
        end
    end
})

Tabs.Other:AddSection("Spawn And Craft")
Tabs.Other:AddButton({
    Title = "Craft Pumpshield",
    Description = "Load pump script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/pump"))()
    end
})

-- ===== TAB 7: Autofarm =====
Tabs.Autofarm:AddSection("Tree Farm")

Tabs.Autofarm:AddToggle("ConiferFarm", {
    Title = "🌲 Conifer Farm",
    Description = "Auto chop Conifer trees",
    Default = false,
    Callback = function(value)
        getgenv().configs.ConiferFarm = value
        if value then task.spawn(ConiferFarm) end
    end
})

Tabs.Autofarm:AddSection("Boss Farm")

Tabs.Autofarm:AddToggle("ObsidianBoss", {
    Title = "🪨 Obsidian Golem",
    Description = "Auto farm Obsidian Golem boss",
    Default = false,
    Callback = function(value)
        getgenv().configs.ObsidianBoss = value
        if value then task.spawn(ObsidianBoss) end
    end
})

Tabs.Autofarm:AddToggle("ZenLuckBoss", {
    Title = "🍀 Zen/Lucky Golem",
    Description = "Auto farm Zenyte or Lucky Golem",
    Default = false,
    Callback = function(value)
        getgenv().configs.ZenLuckBoss = value
        if value then task.spawn(ZenLuckBoss) end
    end
})

Tabs.Autofarm:AddToggle("SpiritBoss", {
    Title = "👻 Spirit Boss",
    Description = "Auto farm Spirit Boss",
    Default = false,
    Callback = function(value)
        getgenv().configs.SpiritBoss = value
        if value then task.spawn(SpiritBoss) end
    end
})

Tabs.Autofarm:AddToggle("LuckySlime", {
    Title = "🟢 Lucky Slime",
    Description = "Auto farm Lucky Slime",
    Default = false,
    Callback = function(value)
        getgenv().configs.LuckySlime = value
        if value then task.spawn(LuckySlime) end
    end
})

Tabs.Autofarm:AddToggle("EvilSkeleton", {
    Title = "💀 Evil Skeleton",
    Description = "Auto farm Evil Skeleton",
    Default = false,
    Callback = function(value)
        getgenv().configs.EvilSkeleton = value
        if value then task.spawn(EvilSkeleton) end
    end
})

Tabs.Autofarm:AddToggle("Ogre", {
    Title = "👹 Ogre",
    Description = "Auto farm Ogre",
    Default = false,
    Callback = function(value)
        getgenv().configs.Ogre = value
        if value then task.spawn(Ogre) end
    end
})

Tabs.Autofarm:AddToggle("Squid", {
    Title = "🦑 Captain Squid",
    Description = "Auto farm Captain Squid",
    Default = false,
    Callback = function(value)
        getgenv().configs.Squid = value
        if value then task.spawn(Squid) end
    end
})

Tabs.Autofarm:AddSection("Auto Repair")

Tabs.Autofarm:AddToggle("AutoRepairClub", {
    Title = "🔧 Auto Repair Club",
    Description = "Auto repair Obsidian Club when durability < 50%",
    Default = false,
    Callback = function(value)
        getgenv().configs.AutoRepairClub = value
    end
})

Tabs.Autofarm:AddToggle("UseSoulKeys", {
    Title = "🔑 Use Soul Keys",
    Description = "Auto craft Soul Keys when have 10+ souls",
    Default = false,
    Callback = function(value)
        getgenv().configs.UseSoulKeys = value
    end
})

-- ===== Notify & Init =====
Fluent:Notify({
    Title = "WSP",
    Content = "Made by Chungdz",
    Duration = 5
})

Window:SelectTab(1)
Fluent:Notify({
    Title = "🌴Island Tribes 🌴",
    Content = "Loaded with all features!",
    Duration = 3
})

-- ===== SaveManager =====
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("IslandTribes")
SaveManager:BuildConfigSection(Window)
InterfaceManager:BuildInterfaceSection(Window)
SaveManager:LoadAutoloadConfig()
