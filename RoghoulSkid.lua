-- DashBoostSolora.lua - Full Deobfuscated + Combat/PVP
-- Made By '@zeypheri' on Discord

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- ============================================
-- VARIABLES
-- ============================================
_G.AutoFarm = false
_G.TargetType = "NPC"
_G.Distance = 15
_G.UseSkills = false
_G.BossFarm = false
_G.AutoHeal = false
_G.AutoPickup = false

-- ====== THÊM VARIABLES COMBAT/PVP ======
_G.PVP = false
_G.Aimbot = false
_G.SilentAim = false
_G.AimPart = "HumanoidRootPart"
_G.AimDistance = 100
_G.AimKey = "MouseButton2" -- Right click
_G.AutoDodge = false

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================
local function GetClosestPlayer()
    local closest = nil
    local minDist = math.huge
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local targetRoot = player.Character:FindFirstChild(_G.AimPart) or player.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local dist = (root.Position - targetRoot.Position).Magnitude
                if dist < minDist and dist < _G.AimDistance then
                    minDist = dist
                    closest = player
                end
            end
        end
    end
    return closest
end

local function GetClosestNPC()
    local closest = nil
    local minDist = math.huge
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local npcSpawns = Workspace:FindFirstChild("NPCSpawns")
    if not npcSpawns then return nil end
    
    for _, npc in pairs(npcSpawns:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            local npcRoot = npc:FindFirstChild("HumanoidRootPart")
            if npcRoot then
                local dist = (root.Position - npcRoot.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = npc
                end
            end
        end
    end
    return closest
end

local function GetClosestBoss()
    local closest = nil
    local minDist = math.huge
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local bossSpawns = Workspace:FindFirstChild("BossSpawns")
    if not bossSpawns then return nil end
    
    for _, boss in pairs(bossSpawns:GetChildren()) do
        if boss:IsA("Model") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
            local bossRoot = boss:FindFirstChild("HumanoidRootPart")
            if bossRoot then
                local dist = (root.Position - bossRoot.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = boss
                end
            end
        end
    end
    return closest
end

local function IsAlive()
    local char = LocalPlayer.Character
    if not char then return false end
    local hum = char:FindFirstChild("Humanoid")
    return hum and hum.Health > 0
end

local function GetItemsNearby()
    local items = {}
    local char = LocalPlayer.Character
    if not char then return items end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return items end
    
    for _, item in pairs(Workspace:GetDescendants()) do
        if item:IsA("Model") and item:FindFirstChildOfClass("BasePart") then
            local part = item:FindFirstChildOfClass("BasePart")
            if part then
                local dist = (root.Position - part.Position).Magnitude
                if dist < 20 then
                    table.insert(items, item)
                end
            end
        end
    end
    return items
end

-- ============================================
-- PVP / AIMBOT LOOP
-- ============================================
task.spawn(function()
    while true do
        task.wait(0.05)
        
        if not _G.PVP and not _G.Aimbot then
            task.wait(1)
            continue
        end
        
        if not IsAlive() then
            task.wait(2)
            continue
        end
        
        local target = GetClosestPlayer()
        if not target then
            task.wait(1)
            continue
        end
        
        local char = LocalPlayer.Character
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        
        local targetRoot = target.Character:FindFirstChild(_G.AimPart) or target.Character:FindFirstChild("HumanoidRootPart")
        if not targetRoot then continue end
        
        -- Aimbot: xoay camera về target
        if _G.Aimbot then
            local camera = Workspace.CurrentCamera
            if camera then
                camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetRoot.Position)
            end
        end
        
        -- Silent Aim: tự động bắn vào target
        if _G.SilentAim then
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if remotes then
                local attack = remotes:FindFirstChild("Attack") or remotes:FindFirstChild("KeyEvent") or remotes:FindFirstChild("Mouse1")
                if attack then
                    attack:FireServer("Mouse1")
                    attack:FireServer("E")
                    attack:FireServer("F")
                end
            end
        end
        
        -- Di chuyển đến gần target (PVP)
        if _G.PVP then
            local dist = (root.Position - targetRoot.Position).Magnitude
            if dist > _G.Distance then
                root.CFrame = CFrame.new(targetRoot.Position) * CFrame.new(0, 0, -_G.Distance)
            end
            
            -- Tấn công liên tục
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if remotes then
                local attack = remotes:FindFirstChild("Attack") or remotes:FindFirstChild("KeyEvent") or remotes:FindFirstChild("Mouse1")
                if attack then
                    attack:FireServer("Mouse1")
                end
            end
        end
    end
end)

-- ============================================
-- AUTO FARM LOOP (NPC + BOSS)
-- ============================================
task.spawn(function()
    while true do
        task.wait(0.1)
        
        if not _G.AutoFarm and not _G.BossFarm then
            task.wait(1)
            continue
        end
        
        if not IsAlive() then
            task.wait(2)
            continue
        end
        
        local char = LocalPlayer.Character
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        
        local target
        if _G.BossFarm then
            target = GetClosestBoss()
        else
            target = GetClosestNPC()
        end
        
        if not target then
            task.wait(2)
            continue
        end
        
        local targetRoot = target:FindFirstChild("HumanoidRootPart")
        if not targetRoot then continue end
        
        local dist = (root.Position - targetRoot.Position).Magnitude
        if dist > _G.Distance then
            root.CFrame = CFrame.new(targetRoot.Position) * CFrame.new(0, 0, -_G.Distance)
        end
        
        local click = target:FindFirstChildOfClass("ClickDetector")
        if click then
            fireclickdetector(click)
        end
        
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes then
            local attack = remotes:FindFirstChild("Attack") or remotes:FindFirstChild("KeyEvent") or remotes:FindFirstChild("Mouse1")
            if attack then
                attack:FireServer("Mouse1")
            end
            
            if _G.UseSkills then
                local skill = remotes:FindFirstChild("Skill")
                if skill then
                    skill:FireServer(1)
                    task.wait(0.3)
                    skill:FireServer(2)
                    task.wait(0.3)
                    skill:FireServer(3)
                end
            end
        end
    end
end)

-- ============================================
-- AUTO HEAL
-- ============================================
task.spawn(function()
    while true do
        task.wait(0.5)
        if not _G.AutoHeal then continue end
        if not IsAlive() then continue end
        
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum and hum.Health < 50 then
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if remotes then
                local heal = remotes:FindFirstChild("Heal") or remotes:FindFirstChild("UsePotion")
                if heal then
                    heal:FireServer()
                end
            end
        end
    end
end)

-- ============================================
-- AUTO PICKUP
-- ============================================
task.spawn(function()
    while true do
        task.wait(0.5)
        if not _G.AutoPickup then continue end
        if not IsAlive() then continue end
        
        local items = GetItemsNearby()
        for _, item in pairs(items) do
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
