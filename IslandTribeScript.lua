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
local LocalPlayer = Players.LocalPlayer

-- Check if player is alive
local function IsPlayerAlive(player)
    return player and player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

-- Get the nearest storage chest
local function GetClosestChest()
    local closest
    local range = math.huge
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
                    range = dist
                    closest = chest
                end
            end
        end
    end

    return closest
end

local Button = MainTab:CreateButton({
   Name = "Ctrl + click TP",
   Callback = function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Click%20Teleport.txt"))()  
  end,
})

local Button = MainTab:CreateButton({
   Name = "Infinite yield",
   Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()  
  end,
})

local Button = MainTab:CreateButton({
   Name = "Dark Dex",
   Callback = function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
  end,
})

local Button = MainTab:CreateButton({
   Name = "ESP",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/ESP.lua"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Shiftlock Mobile (Open it to Aimbot Mobile)",
   Callback = function()
    loadstring(game:HttpGet("https://github.com/ltseverydayyou/uuuuuuu/blob/main/shiftlock?raw=true"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Big Hitbox",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Chungdz09/Script-chung-dz/refs/heads/main/Big%20Hitbox"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "AimBot Press Ctrl to lock",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Chungdz09/Script-chung-dz/refs/heads/main/KchungdzAimbot.lua"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Mobile Aimbot",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/MobileAimlock.lua"))()
   end,
})

local MainSection = MainTab:CreateSection("Toggles")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolActionEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ToolAction")
local LocalPlayer = Players.LocalPlayer

MainTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "AutoAttackPlayer",
    Callback = function(Value)
        AutoAttackPlayer = Value

        if AutoAttackPlayer then
            if KillAuraLoop then return end
            KillAuraLoop = task.spawn(function()
                while AutoAttackPlayer do
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

                    if HumanoidRootPart then
                        local closestPlayer = nil
                        local closestDistance = 30

                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHRP = player.Character.HumanoidRootPart
                                local dist = (targetHRP.Position - HumanoidRootPart.Position).Magnitude
                                if dist <= closestDistance then
                                    closestPlayer = player.Character
                                    closestDistance = dist
                                end
                            end
                        end

                        if closestPlayer then
                            ToolActionEvent:FireServer(closestPlayer)
                        end
                    end

                    task.wait(0.01)
                end
                KillAuraLoop = nil
            end)
        else
            if KillAuraLoop then
                task.cancel(KillAuraLoop)
                KillAuraLoop = nil
            end
        end
    end,
})

local Toggle = MainTab:CreateToggle({
   Name = "Toggle Inf Jump",
   CurrentValue = false,
   Flag = "Toggle1", 
   Callback = function(Value)
   loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Infinite%20Jump.txt"))()
   end,
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local CraftRemote = ReplicatedStorage
    :WaitForChild("References")
    :WaitForChild("Comm")
    :WaitForChild("Events")
    :WaitForChild("CraftItem")

local ITEM_ID = 264
local RANGE = 40

getgenv().AutoCraftClosestPlayer = false

local CraftToggle = MainTab:CreateToggle({
    Name = "Auto Craft Closest Player [R]",
    CurrentValue = false,
    Flag = "AutoCraftClosestPlayer",
    Callback = function(Value)
        getgenv().AutoCraftClosestPlayer = Value

        task.spawn(function()
            while getgenv().AutoCraftClosestPlayer do

                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

                if HumanoidRootPart then
                    local closestPlayer = nil
                    local closestDistance = RANGE

                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer
                        and player.Character
                        and player.Character:FindFirstChild("HumanoidRootPart") then

                            local targetHRP = player.Character.HumanoidRootPart
                            local dist = (targetHRP.Position - HumanoidRootPart.Position).Magnitude

                            if dist <= closestDistance then
                                closestPlayer = player.Character
                                closestDistance = dist
                            end
                        end
                    end

                    if closestPlayer then
                        local pos = closestPlayer.HumanoidRootPart.Position

                        local args = {
                            ITEM_ID,
                            vector.create(pos.X, pos.Y - 3, pos.Z),
                            0
                        }

                        CraftRemote:FireServer(unpack(args))

                        print("Crafted at", closestPlayer.Name)
                    end
                end

                task.wait(0.5)
            end
        end)
    end
})

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then
        return
    end

    if input.KeyCode == Enum.KeyCode.R then
        getgenv().AutoCraftClosestPlayer = not getgenv().AutoCraftClosestPlayer

        CraftToggle:Set(getgenv().AutoCraftClosestPlayer)

        print("AutoCraft:", getgenv().AutoCraftClosestPlayer)
    end
end)

local healingEnabled = false
local healTask = nil

local Button = MainTab:CreateToggle({
    Name = "Spam Pumpkin If <100HP",
    Default = false,
    Callback = function(state)
        healingEnabled = state

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local LocalPlayer = Players.LocalPlayer
        local Event = ReplicatedStorage.References.Comm.Events.InventoryInteraction
        local itemID = 378  -- Pumpkin ID
        local action = "Eat"
        local delayTime = 0.01 -- Thời gian chờ giữa mỗi lần kiểm tra (có thể chỉnh)

        local function IsPlayerAlive()
            return LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0
        end

        -- Nếu tắt toggle thì dừng vòng lặp
        if not healingEnabled then
            healTask = nil
            return
        end

        -- Nếu chưa có vòng lặp thì tạo mới
        if not healTask then
            healTask = task.spawn(function()
                while healingEnabled do
                    task.wait(delayTime)
                    if not IsPlayerAlive() then
                        break
                    end

                    local hum = LocalPlayer.Character.Humanoid
                    if hum.Health < 100 then
                        Event:FireServer(itemID, action)
                    end
                end
            end)
        end
    end
})

-- Biến toàn cục để bật/tắt auto pickup
local autoPickupEnabled = false

-- Hàm bật/tắt được gọi từ toggle GUI
local function ToggleAutoPickup(value)
    autoPickupEnabled = value
end

-- Tạo toggle GUI (giả sử bạn có biến MainTab, thay thế theo thư viện bạn dùng)
MainTab:CreateToggle({
    Name = "Auto Pickup",
    CurrentValue = false,
    Flag = "AutoPickupToggle",
    Callback = function(value)
        ToggleAutoPickup(value)
    end,
})

-- Các dịch vụ cần thiết
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local itemEvent = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ItemInteracted")
local pickupRadius = 18.5

-- Lấy vị trí nhân vật
local function getCharacterRoot()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("HumanoidRootPart")
end

-- Lấy vị trí gần đúng của model (dùng part đầu tiên tìm thấy)
local function getModelPosition(model)
    for _, part in pairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            return part.Position
        end
    end
    return nil
end

-- Hàm tự động nhặt đồ
local function autoPickup()
    local rootPart = getCharacterRoot()
    for _, itemModel in ipairs(workspace:GetDescendants()) do
        if itemModel:IsA("Model") and itemModel:FindFirstChildWhichIsA("BasePart") then
            local pos = getModelPosition(itemModel)
            if pos and (pos - rootPart.Position).Magnitude <= pickupRadius then
                itemEvent:FireServer(itemModel, "Pickup")
            end
        end
    end
end

-- Vòng lặp chạy nền kiểm tra toggle và tự nhặt đồ
task.spawn(function()
    while true do
        if autoPickupEnabled then
            pcall(autoPickup)  -- pcall để tránh lỗi dừng script
        end
        task.wait(0.5) -- chờ 1 giây trước khi quét lại
    end
end)
local MainSection = MainTab:CreateSection("Sliders")

local Slider = MainTab:CreateSlider({
   Name = "WalkSpeed Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderws", 
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "JumpPower Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderjp",
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})
    
local Tab2 = Window:CreateTab("🤑 Duping", nil)
local Section = Tab2:CreateSection("Start Duping items") 


local Button = Tab2:CreateButton({
    Name = "🏁 Start Dupe",
    Callback = function()
        -- Gửi thông báo khi nhấn Start Dupe
        game.StarterGui:SetCore("SendNotification", {
            Title = "Dupe Started",
            Text = "Dupe process has started successfully.",
            Duration = 4,  -- Thời gian hiển thị thông báo (4 giây)
        })
        
        -- Gửi sự kiện SetSettings đến server (điều này có thể liên quan đến dupe)
        getgenv().olddata = game:GetService("ReplicatedStorage").References.Comm.Events.SetSettings
        game:GetService("ReplicatedStorage").References.Comm.Events.SetSettings:FireServer(getgenv().olddata)
    end,
})

-- Thông báo thông báo khi script được tải thành công
game.StarterGui:SetCore("SendNotification", {
    Title = "Script Loaded",
    Text = "Dupe Script Loaded Successfully.",
    Duration = 4,
})

local Section = Tab2:CreateSection("Packs") 

local Button = Tab2:CreateButton({
    Name = "Snow Pack 500x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {346}
        
        for i = 1, 499 do
            table.insert(itemIDs, 346)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})


local Button = Tab2:CreateButton({
    Name = "PutOut Snow Pack 500x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {346}
        
        for i = 1, 499 do
            table.insert(itemIDs, 346)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putOut, itemID)
        end
    end,
})

local Button = Tab2:CreateButton({
    Name = "Candy Poion 500x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end
            
        local putIn = true
        local itemIDs = {372}
        
        for i = 1, 499 do
            table.insert(itemIDs, 372)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab2:CreateButton({
    Name = "PutOut Candy Poion 500x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end
            
        local putIn = true
        local itemIDs = {372}
        
        for i = 1, 499 do
            table.insert(itemIDs, 372)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putOut, itemID)
        end
    end,
})

local Button = Tab2:CreateButton({
    Name = "📦Chest pack 500x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {382}
        
        for i = 1, 499 do
            table.insert(itemIDs, 382)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})
 
 local Button = Tab2:CreateButton({
    Name = "📦Putout Chest pack 25x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {382}
        
        for i = 1, 499 do
            table.insert(itemIDs, 382)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, PutOut, itemID)
        end
    end,
})
 
local Button = Tab2:CreateButton({
    Name = "🍭Candypack 500x 😊",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {188}
        
        for i = 1, 499 do
            table.insert(itemIDs, 188)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})
 
  
local Button = Tab2:CreateButton({
    Name = "🍭PutOut Candypack 500x 😊",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {188}
        
        for i = 1, 499 do
            table.insert(itemIDs, 188)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putOut, itemID)
        end
    end,
})

local Button = Tab2:CreateButton({
    Name = "🍉Fruit pack 25x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {325}
        
        for i = 1, 499 do
            table.insert(itemIDs, 325)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})
 
 local Button = Tab2:CreateButton({
    Name = "🍉PutOut Fruit pack 25x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {325}
        
        for i = 1, 499 do
            table.insert(itemIDs, 325)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putOut, itemID)
        end
    end,
})
 
local Button = Tab2:CreateButton({
    Name = "🛡️Prot. pack 25x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {317}
        
        for i = 1, 24 do
            table.insert(itemIDs, 317)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})
 
local Button = Tab2:CreateButton({
    Name = "🤺Warr. pack 25x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {318}
        
        for i = 1, 24 do
            table.insert(itemIDs, 318)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab2:CreateButton({
   Name = "Zen Pack 500x",
   Callback = function()
     local localChest = game:GetService("Workspace").Replicators.NonPassive["Obsidian Storage Chest"]
     local putIn = true
     local itemIDs = {327}
      
      for i = 1, 500 do
          table.insert(itemIDs, 327)
      end
      
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
      
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(localChest, putIn, itemID)
      end
 end,
})

local Button = Tab2:CreateButton({
   Name = "Diamond Pack 500x",
   Callback = function()
     local localChest = game:GetService("Workspace").Replicators.NonPassive["Obsidian Storage Chest"]
     local putIn = true
     local itemIDs = {326}
      
      for i = 1, 500 do
          table.insert(itemIDs, 326)
      end
      
      local Event = game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest
      
      for _, itemID in ipairs(itemIDs) do
          Event:FireServer(localChest, putIn, itemID)
      end
 end,
})

local Button = Tab2:CreateButton({
    Name = "🪓Fresh pack 25x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {111}
        
        for i = 1, 24 do
            table.insert(itemIDs, 111)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})
 
local Button = Tab2:CreateButton({
    Name = "Stone pack 25x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {112}
        
        for i = 1, 24 do
            table.insert(itemIDs, 112)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})
 
local Button = Tab2:CreateButton({
    Name = "Dupe All x500",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {203,204,216,188,325,272,301,271}
        
        for i = 1, 499 do
            table.insert(itemIDs, 203,204,216,188,325,272,301,271)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})
 
 local Button = Tab2:CreateButton({
    Name = "Dupe All2 x500",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {112,382,378,225,226,227,228,201,202}
        
        for i = 1, 499 do
            table.insert(itemIDs, 112,382,378,225,226,227,228,201,202)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Tab3 = Window:CreateTab("😵‍💫 Crazy Dupe", nil)
local Section = Tab3:CreateSection("Gliders 🪁")


 local Button = Tab3:CreateButton({
    Name = "🪁Easter Glider🪁",
    Callback = function()
         local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end
    
          local putIn = true
        local itemIDs = {272}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })


 local Button = Tab3:CreateButton({
    Name = "🪁Glider🪁",
    Callback = function()
         local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end
    
          local putIn = true
        local itemIDs = {301}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest
        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
 })

local Section = Tab3:CreateSection("Others")

local Button = Tab3:CreateButton({
    Name = "🌀Portal Book",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {313}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab3:CreateButton({
    Name = "🛡️Deflect Book",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {323}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab3:CreateButton({
    Name = "🥶Freezio Book",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {310}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab3:CreateButton({
    Name = "💀Oofio Book",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {309}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab3:CreateButton({
    Name = "🎃Pumpkin Shield 10x🎃",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {379}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

 
local Button = Tab3:CreateButton({
    Name = "Easter Candy 500x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {271}
        
        for i = 1, 499 do
            table.insert(itemIDs, 271)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab3:CreateButton({
    Name = "PutOut Easter Candy 500x",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {271}
        
        for i = 1, 499 do
            table.insert(itemIDs, 271)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putOut, itemID)
        end
    end,
})
 
 local Button = Tab3:CreateButton({
   Name =   "Pumpkin 500x",
   Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {378}
        
        for i = 1, 499 do
            table.insert(itemIDs, 378)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

 local Button = Tab3:CreateButton({
   Name =   "PutOut Pumpkin 500x",
   Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {378}
        
        for i = 1, 499 do
            table.insert(itemIDs, 378)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, PutOut, itemID)
        end
    end,
})
 
 local Button = Tab3:CreateButton({
   Name =   "Hard Chest 25x",
   Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {168}
        
        for i = 1, 24 do
            table.insert(itemIDs, 168)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

 local Button = Tab3:CreateButton({
   Name =   "PutOut Hard Chest 25x",
   Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {168}
        
        for i = 1, 24 do
            table.insert(itemIDs, 168)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, PutOut, itemID)
        end
    end,
})
 
local Tab4 = Window:CreateTab("Armor And Sword,Bow", nil)
local Section = Tab4:CreateSection("Armor")

local Button = Tab4:CreateButton({
    Name = "🌋Dupe Obsidian Armor",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {225,226,227,228,235}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab4:CreateButton({
    Name = "🦴Soul Duping",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {204, 202, 201, 203, 218, 216}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})
 
local Button = Tab4:CreateButton({
    Name = "MoonStone Set Duping",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {369, 366, 365, 364, 363}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab4:CreateButton({
    Name = "Starter Pack Duping",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {354, 355, 356, 357, 358, 359}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Section = Tab4:CreateSection("Sword And Bow")

local Button = Tab4:CreateButton({
    Name = "MoonSword And ObClub",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {369, 230,}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab4:CreateButton({
    Name = "MoonBow, ZenBow And DiaBow",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {199, 198,376}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab4:CreateButton({
    Name = "Vision Staff",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {293}
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Tab5 = Window:CreateTab("Open And Drop", nil)
local Section = Tab5:CreateSection("Open Chest")

 local Button = Tab5:CreateButton({
    Name = "Open Easy Chest",
    Callback = function()
        local chestID = 166
        local action = "Open"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Open Medium Chest",
    Callback = function()
        local chestID = 167
        local action = "Open"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Open Hard Chest",
    Callback = function()
        local chestID = 168
        local action = "Open"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

local Section = Tab5:CreateSection("Teleport")

 
 local Button = Tab5:CreateButton({
    Name = "Leaderboard Place",
    Callback = function()
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local myroot = player.Character.HumanoidRootPart
            myroot.CFrame = CFrame.new(5313, 4, -5508)
        else
            warn("Player is not alive or character is not fully loaded.")
        end
    end
})

 local Section = Tab5:CreateSection("Drop")

local Button = Tab5:CreateButton({
    Name = "Glider",
    Callback = function()
        local chestID = 301
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

local Button = Tab5:CreateButton({
    Name = "Candy Pack",
    Callback = function()
        local chestID = 188
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

local Button = Tab5:CreateButton({
    Name = "Warrior Pack",
    Callback = function()
        local chestID = 318
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

local Button = Tab5:CreateButton({
    Name = "Fruit Pack",
    Callback = function()
        local chestID = 325
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

local Button = Tab5:CreateButton({
    Name = "Chest Pack",
    Callback = function()
        local chestID = 382
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Drop Easy Chest",
    Callback = function()
        local chestID = 166
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Drop Medium Chest",
    Callback = function()
        local chestID = 167
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Drop Hard Chest",
    Callback = function()
        local chestID = 168
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

 local Button = Tab5:CreateButton({
    Name = "Drop Lunar Arrow",
    Callback = function()
        local chestID = 377
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

local Button = Tab5:CreateButton({
    Name = "Ob Snowball",
    Callback = function()
        local chestID = 352
        local action = "Drop"
        local Event = game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction

        Event:FireServer(chestID, action)
    end
})

local Tab6 = Window:CreateTab("Other", nil)
local Section = Tab6:CreateSection("Moon And Ob")

local Button = Tab6:CreateButton({
    Name = "Volcanic Ore x200",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {223}
        
        for i = 1, 200 do
            table.insert(itemIDs, 223)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab6:CreateButton({
    Name = "Obsidian x200",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {224}
        
        for i = 1, 200 do
            table.insert(itemIDs, 224)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab6:CreateButton({
    Name = "Lunar Ore x200",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {360}
        
        for i = 1, 200 do
            table.insert(itemIDs, 360)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab6:CreateButton({
    Name = "PutOut Lunar Ore x200",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {360}
        
        for i = 1, 200 do
            table.insert(itemIDs, 360)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putOut, itemID)
        end
    end,
})

local Button = Tab6:CreateButton({
    Name = "MoonStone x200",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {361}
        
        for i = 1, 200 do
            table.insert(itemIDs, 361)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab6:CreateButton({
    Name = "jack lantern",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {337}
        
        for i = 1, 200 do
            table.insert(itemIDs, 337)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, putIn, itemID)
        end
    end,
})

local Button = Tab6:CreateButton({
    Name = "Snowball Drop",
    Callback = function()
        local chest = GetClosestChest()
        if not chest then
            warn("No nearby chest found.")
            return
        end

        local putIn = true
        local itemIDs = {352,353}
        
        for i = 1, 500 do
            table.insert(itemIDs, 352,353)
        end
        local Event = ReplicatedStorage.References.Comm.Events.UpdateStorageChest

        for _, itemID in ipairs(itemIDs) do
            Event:FireServer(chest, Drop, itemID)
        end
    end,
})

local Section = Tab6:CreateSection("Spawn And Craft")

local Button = Tab6:CreateButton({
   Name = "Craft Pumpshield",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stallion2108/Script-chung-dz/refs/heads/main/pump"))()
  end,
})
