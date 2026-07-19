-- bytecode lua5.1
local _ScreenGui = Instance.new("ScreenGui")
_ScreenGui.Name = "KeyVerificationGUI"
_ScreenGui.ResetOnSpawn = false
_ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

local _Frame = Instance.new("Frame")
_Frame.Size = UDim2.new(0, 450, 0, 300)
_Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
_Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
_Frame.BorderSizePixel = 0
_Frame.Parent = _ScreenGui

local _TextButton = Instance.new("TextButton")
_TextButton.Size = UDim2.new(0, 30, 0, 30)
_TextButton.Position = UDim2.new(0, 5, 0, 0)
_TextButton.AnchorPoint = Vector2.new(0, 0)
_TextButton.Text = "X"
_TextButton.Font = Enum.Font.SourceSansBold
_TextButton.TextColor3 = Color3.fromRGB(255, 0, 0)
_TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_TextButton.BorderSizePixel = 0
_TextButton.TextSize = 18
_TextButton.Parent = _Frame
_TextButton.MouseButton1Click:Connect(function()
    _ScreenGui:Destroy()
end)

local _TextLabel = Instance.new("TextLabel")
_TextLabel.Size = UDim2.new(1, 0, 0, 40)
_TextLabel.Position = UDim2.new(0, 0, 0, 0)
_TextLabel.BackgroundTransparency = 1
_TextLabel.Text = "Key Verification"
_TextLabel.Font = Enum.Font.SourceSansBold
_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
_TextLabel.TextSize = 24
_TextLabel.Parent = _Frame

local _Frame2 = Instance.new("Frame")
_Frame2.Size = UDim2.new(0, 360, 0, 60)
_Frame2.Position = UDim2.new(0.1, 0, 0.25, 0)
_Frame2.AnchorPoint = Vector2.new(0, 0)
_Frame2.BackgroundTransparency = 0.8
_Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_Frame2.BorderSizePixel = 0
_Frame2.Parent = _Frame

local _TextBox = Instance.new("TextBox")
_TextBox.Size = UDim2.new(1, -25, 1, -10)
_TextBox.Position = UDim2.new(0, 5, 0, 5)
_TextBox.BackgroundTransparency = 1
_TextBox.PlaceholderText = "Enter the key"
_TextBox.Font = Enum.Font.SourceSans
_TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
_TextBox.TextSize = 18
_TextBox.Parent = _Frame2

local _TextLabel2 = Instance.new("TextLabel")
_TextLabel2.Size = UDim2.new(1, 0, 0, 30)
_TextLabel2.Position = UDim2.new(0, 0, 0.75, 0)
_TextLabel2.BackgroundTransparency = 1
_TextLabel2.Text = "Discord Link: discord.gg/87dGbU9t5W"
_TextLabel2.Font = Enum.Font.SourceSans
_TextLabel2.TextColor3 = Color3.fromRGB(0, 162, 255)
_TextLabel2.TextSize = 18
_TextLabel2.Parent = _Frame

local _TextButton2 = Instance.new("TextButton")
_TextButton2.Size = UDim2.new(0, 360, 0, 60)
_TextButton2.Position = UDim2.new(0.1, 0, 0.4, 10)
_TextButton2.AnchorPoint = Vector2.new(0, 0)
_TextButton2.Text = "Verify"
_TextButton2.Font = Enum.Font.SourceSansBold
_TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
_TextButton2.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
_TextButton2.BorderSizePixel = 0
_TextButton2.TextSize = 20
_TextButton2.Parent = _Frame

local KEY = "Kchungdz"
local notificationTimer = nil

local function ShowNotification(text, color)
    if notificationTimer then
        notificationTimer:Disconnect()
        notificationTimer = nil
    end
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Position = UDim2.new(0, 0, 0.85, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.SourceSansBold
    label.TextColor3 = color
    label.TextSize = 18
    label.Parent = _Frame
    notificationTimer = game:GetService("RunService").Stepped:Connect(function()
        wait(3)
        label:Destroy()
        notificationTimer = nil
    end)
end

local function OnVerify()
    if _TextBox.Text ~= KEY then
        ShowNotification("Incorrect key! Join Discord: discord.gg/87dGbU9t5W", Color3.fromRGB(255, 0, 0))
        return
    end
    ShowNotification("Correct key!", Color3.fromRGB(0, 255, 0))
    _ScreenGui:Destroy()

    -- Load main UI
    local orion = loadstring(game:HttpGet("https://raw.githubusercontent.com/whateverScripts/Others/refs/heads/main/source"))()
    local window = orion.MakeWindow({
        Name = "Whatever HUB discord.gg/87dGbU9t5W",
        IntroText = "Loading",
        IntroIcon = "rbxassetid://7743873443",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "OrionTest"
    })
    
    -- Main Tab
    local mainTab = window:MakeTab({Name = "Main", Icon = "rbxassetid://7733960981", PremiumOnly = false})
    mainTab:AddLabel("Wait till the game load then do anticheat bypass")
    mainTab:AddLabel("Sometimes u need to execute it 2-3 times to make it work")
    mainTab:AddButton({
        Name = "AntiCheatBypass",
        Callback = function()
            local old
            old = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if checkcaller() or tostring(self) ~= "Sonar" or method ~= "FireServer" then
                    return old(self, ...)
                end
                return
            end)
            task.wait(1)
            game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("Sonar"):FireServer()
        end
    })
    mainTab:AddBind({
        Name = "Auto Pickup",
        Default = Enum.KeyCode.X,
        Hold = false,
        Callback = function()
            spawn(function()
                local player = game.Players.LocalPlayer
                local char = player.Character
                if not char then return end
                local pos = char.PrimaryPart.Position
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj.PrimaryPart and (pos - obj.PrimaryPart.Position).Magnitude <= 5 then
                        pcall(function()
                            game:GetService("ReplicatedStorage").References.Comm.Events.ItemInteracted:FireServer(obj, "Pickup")
                        end)
                    end
                end
            end)
        end
    })
    
    -- Combat Tab
    local combatTab = window:MakeTab({Name = "Combat", Icon = "rbxassetid://7743872758", PremiumOnly = false})
    
    getgenv().MaxDistance = 50
    _G.KillAura = false
    _G.SilentAim = false
    
    local function GetClosestTorso()
        local player = game.Players.LocalPlayer
        local char = player.Character
        if not char then return nil end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local closest = nil
        local minDist = getgenv().MaxDistance
        for _, other in pairs(game.Players:GetPlayers()) do
            if other ~= player and other.Character then
                local otherRoot = other.Character:FindFirstChild("HumanoidRootPart")
                if otherRoot then
                    local dist = (otherRoot.Position - root.Position).Magnitude
                    if dist <= minDist and (not closest or dist < (closest.Position - root.Position).Magnitude) then
                        closest = otherRoot
                    end
                end
            end
        end
        return closest
    end
    
    combatTab:AddButton({
        Name = "Hidden Aimbot Script F1 to hide",
        Callback = function()
            local Players = game:GetService("Players")
            local UserInputService = game:GetService("UserInputService")
            local TweenService = game:GetService("TweenService")
            local LocalPlayer = Players.LocalPlayer
            local aiming = false
            local targetLocked = false
            local currentTarget = nil
            local aimEnabled = true
            local aimPart = "Head"
            local smoothness = 0
            local gui = Instance.new("ScreenGui")
            gui.Name = "AimbotGui"
            gui.Parent = game.CoreGui
            local frame = Instance.new("Frame")
            frame.Name = "AimbotFrame"
            frame.Size = UDim2.new(0, 230, 0, 120)
            frame.Position = UDim2.new(0.5, -100, 0.5, -60)
            frame.BorderSizePixel = 0
            frame.Visible = true
            frame.BackgroundColor3 = Color3.fromRGB(72, 119, 200)
            frame.Parent = gui
            local targetLabel = Instance.new("TextLabel")
            targetLabel.Name = "TargetLabel"
            targetLabel.Size = UDim2.new(0, 180, 0, 20)
            targetLabel.Position = UDim2.new(0, 10, 0, 30)
            targetLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            targetLabel.BackgroundTransparency = 1
            targetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            targetLabel.TextSize = 14
            targetLabel.TextXAlignment = Enum.TextXAlignment.Left
            targetLabel.Parent = frame
            local discordLabel = Instance.new("TextLabel")
            discordLabel.Name = "DiscordLabel"
            discordLabel.Size = UDim2.new(0, 180, 0, 20)
            discordLabel.Position = UDim2.new(0, 10, 0, 60)
            discordLabel.BackgroundColor3 = Color3.fromRGB(102, 255, 204)
            discordLabel.BackgroundTransparency = 1
            discordLabel.TextColor3 = Color3.fromRGB(102, 255, 204)
            discordLabel.TextSize = 14
            discordLabel.TextXAlignment = Enum.TextXAlignment.Left
            discordLabel.Text = "discord.gg/87dGbU9t5W"
            discordLabel.Parent = frame
            local controlLabel = Instance.new("TextLabel")
            controlLabel.Name = "ControlLabel"
            controlLabel.Size = UDim2.new(0, 180, 0, 20)
            controlLabel.Position = UDim2.new(0, 10, 0, 90)
            controlLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            controlLabel.BackgroundTransparency = 1
            controlLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            controlLabel.TextSize = 14
            controlLabel.TextXAlignment = Enum.TextXAlignment.Left
            controlLabel.Text = "CTRL to target"
            controlLabel.Parent = frame
            
            local dragging = false
            local dragStart = nil
            local startPos = nil
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = frame.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)
            frame.InputChanged:Connect(function(input)
                if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
                    local delta = input.Position - dragStart
                    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
            
            local function GetClosestPlayerToMouse()
                local closest = nil
                local minDist = math.huge
                local mousePos = UserInputService:GetMouseLocation()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local screenPos = workspace.CurrentCamera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
                        local dist = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                        if dist < minDist then
                            closest = player
                            minDist = dist
                        end
                    end
                end
                return closest
            end
            
            local hidden = false
            local function UpdateTargetLabel()
                if targetLocked then
                    targetLabel.Text = "Target: " .. currentTarget.Name
                    targetLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
                else
                    targetLabel.Text = "Target: None"
                    targetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
            
            local function HideGUI()
                frame.Visible = false
                hidden = true
            end
            local function ShowGUI()
                frame.Visible = true
                hidden = false
            end
            
            UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.LeftControl and aimEnabled and not aiming then
                    if targetLocked then
                        currentTarget = nil
                        targetLocked = false
                        UpdateTargetLabel()
                    else
                        currentTarget = GetClosestPlayerToMouse()
                        if currentTarget then
                            targetLocked = true
                            UpdateTargetLabel()
                        end
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    aiming = true
                elseif input.KeyCode == Enum.KeyCode.F1 then
                    hidden = not hidden
                    if hidden then HideGUI() else ShowGUI() end
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    aiming = false
                end
            end)
            
            game:GetService("RunService").RenderStepped:Connect(function()
                if aiming and aimEnabled and targetLocked then
                    local char = currentTarget.Character
                    if char and char:FindFirstChild(aimPart) then
                        local targetPos = char[aimPart].Position
                        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(smoothness, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetPos)
                        }):Play()
                    end
                end
            end)
            UpdateTargetLabel()
        end
    })
    
    combatTab:AddToggle({
        Name = "Kill Aura",
        Default = false,
        Callback = function(val)
            _G.KillAura = val
            if val then
                game:GetService("RunService").Stepped:Connect(function()
                    if _G.KillAura then
                        local target = GetClosestTorso()
                        if target then
                            local player = game.Players:GetPlayerFromCharacter(target.Parent)
                            if player then
                                game:GetService("ReplicatedStorage").References.Comm.Events.ToolAction:FireServer(player.Character)
                            end
                        end
                    end
                end)
            end
        end
    })
    
    combatTab:AddToggle({
        Name = "Silent Aim",
        Default = false,
        Callback = function(val)
            _G.SilentAim = val
            if val then
                spawn(function()
                    while _G.SilentAim do
                        local target = GetClosestTorso()
                        if target then
                            local player = game.Players:GetPlayerFromCharacter(target.Parent)
                            if player then
                                game:GetService("ReplicatedStorage").References.Comm.Events.ToolAction:FireServer(player.Character)
                            end
                        end
                        wait(0.7)
                    end
                end)
            end
        end
    })
    
    combatTab:AddButton({
        Name = "Hitbox Extender",
        Callback = function()
            _G.HeadSize = 20
            _G.Disabled = true
            game:GetService("RunService").RenderStepped:Connect(function()
                if _G.Disabled then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player.Name ~= game.Players.LocalPlayer.Name then
                            pcall(function()
                                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                if root then
                                    root.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                                    root.Transparency = 1
                                    root.CanCollide = false
                                end
                            end)
                        end
                    end
                end
            end)
        end
    })
    
    combatTab:AddButton({
        Name = "ESP 1",
        Callback = function()
            local fillColor = Color3.fromRGB(175, 25, 255)
            local depthMode = "AlwaysOnTop"
            local fillTrans = 0.5
            local outlineColor = Color3.fromRGB(255, 255, 255)
            local storage = Instance.new("Folder")
            storage.Parent = game.CoreGui
            storage.Name = "Highlight_Storage"
            local connections = {}
            
            local function AddHighlight(player)
                local highlight = Instance.new("Highlight")
                highlight.Name = player.Name
                highlight.FillColor = fillColor
                highlight.DepthMode = depthMode
                highlight.FillTransparency = fillTrans
                highlight.OutlineColor = outlineColor
                highlight.OutlineTransparency = 0
                highlight.Parent = storage
                if player.Character then
                    highlight.Adornee = player.Character
                end
                connections[player] = player.CharacterAdded:Connect(function(char)
                    highlight.Adornee = char
                end)
            end
            
            game.Players.PlayerAdded:Connect(AddHighlight)
            for _, player in pairs(game.Players:GetPlayers()) do
                AddHighlight(player)
            end
            game.Players.PlayerRemoving:Connect(function(player)
                if storage:FindFirstChild(player.Name) then
                    storage[player.Name]:Destroy()
                end
                if connections[player] then
                    connections[player]:Disconnect()
                    connections[player] = nil
                end
            end)
        end
    })
    
    combatTab:AddButton({
        Name = "Infinite-Yield",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })
    
    -- Instant Repair Tab
    local repairTab = window:MakeTab({Name = "Instant Repair", Icon = "rbxassetid://7734051454", PremiumOnly = false})
    repairTab:AddLabel("YOU NEED TO HAVE A WOOD CHEST PLACED!!")
    local selectedRepair = ""
    repairTab:AddDropdown({
        Name = "Armors",
        Default = "Moonstone Set with Moonstone Sword and Moonstone Sheild",
        Options = {
            "Moonstone Set with Moonstone Sword and Moonstone Sheild",
            "Obsidian Set with Obsidian Sword and Obsidian Sheild",
            "Lucky Sword and Lucky Shield",
            "All of the Wands",
            "All of the CrossBows",
            "All of the Sheilds"
        },
        Callback = function(val)
            selectedRepair = val
        end
    })
    repairTab:AddButton({
        Name = "Repair",
        Callback = function()
            local chest = workspace.Replicators.NonPassive["Wood Storage Chest"]
            local function RepairItem(itemId, take)
                game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest:FireServer(chest, take, itemId)
            end
            if selectedRepair == "Moonstone Set with Moonstone Sword and Moonstone Sheild" then
                orion:MakeNotification({Name = "", Content = "Repaired Moonstone set", Image = "rbxassetid://4483345998", Time = 5})
                RepairItem(369, true) RepairItem(369, false)
                RepairItem(366, true) RepairItem(366, false)
                RepairItem(365, true) RepairItem(365, false)
                RepairItem(363, true) RepairItem(363, false)
                RepairItem(364, true) RepairItem(364, false)
                RepairItem(367, true) RepairItem(367, false)
            elseif selectedRepair == "Obsidian Set with Obsidian Sword and Obsidian Sheild" then
                orion:MakeNotification({Name = "", Content = "Repaired Obsidian set", Image = "rbxassetid://4483345998", Time = 5})
                RepairItem(227, true) RepairItem(227, false)
                RepairItem(228, true) RepairItem(228, false)
                RepairItem(226, true) RepairItem(226, false)
                RepairItem(225, true) RepairItem(225, false)
                RepairItem(230, true) RepairItem(230, false)
                RepairItem(235, true) RepairItem(235, false)
            elseif selectedRepair == "Lucky Sword and Lucky Shield" then
                orion:MakeNotification({Name = "", Content = "Repaired Lucky Sword and Shield", Image = "rbxassetid://4483345998", Time = 5})
                RepairItem(173, true) RepairItem(173, false)
                RepairItem(219, true) RepairItem(219, false)
            elseif selectedRepair == "All of the Wands" then
                orion:MakeNotification({Name = "", Content = "Repaired all wands", Image = "rbxassetid://4483345998", Time = 5})
                RepairItem(162, true) RepairItem(162, false)
                RepairItem(289, true) RepairItem(289, false)
                RepairItem(290, true) RepairItem(290, false)
                RepairItem(291, true) RepairItem(291, false)
                RepairItem(292, true) RepairItem(292, false)
                RepairItem(293, true) RepairItem(293, false)
            elseif selectedRepair == "All of the CrossBows" then
                orion:MakeNotification({Name = "", Content = "Repaired all crossbows", Image = "rbxassetid://4483345998", Time = 5})
                RepairItem(197, true) RepairItem(197, false)
                RepairItem(198, true) RepairItem(198, false)
                RepairItem(199, true) RepairItem(199, false)
                RepairItem(376, true) RepairItem(376, false)
            elseif selectedRepair == "All of the Sheilds" then
                orion:MakeNotification({Name = "", Content = "Repaired all shields", Image = "rbxassetid://4483345998", Time = 5})
                RepairItem(379, true) RepairItem(379, false)
                RepairItem(209, true) RepairItem(209, false)
                RepairItem(210, true) RepairItem(210, false)
                RepairItem(219, true) RepairItem(219, false)
                RepairItem(211, true) RepairItem(211, false)
                RepairItem(235, true) RepairItem(235, false)
                RepairItem(367, true) RepairItem(367, false)
            end
        end
    })
    
    -- Drop Tab
    local dropTab = window:MakeTab({Name = "Drop", Icon = "rbxassetid://7733920226", PremiumOnly = false})
    
    local pumpkinSeedSpam = false
    local function PumpkinSeedDropLoop()
        while pumpkinSeedSpam do
            game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"):FireServer(381, "Drop")
            wait()
        end
    end
    dropTab:AddToggle({
        Name = "Pumpkin Seed Drop Spammer",
        Default = false,
        Callback = function(val)
            pumpkinSeedSpam = val
            if val then spawn(PumpkinSeedDropLoop) end
        end
    })
    
    local potatoSeedSpam = false
    local function PotatoSeedDropLoop()
        while potatoSeedSpam do
            game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"):FireServer(103, "Drop")
            wait()
        end
    end
    dropTab:AddToggle({
        Name = "Raw Potato Drop Spammer",
        Default = false,
        Callback = function(val)
            potatoSeedSpam = val
            if val then spawn(PotatoSeedDropLoop) end
        end
    })
    
    -- Auto Eat Tab
    local eatTab = window:MakeTab({Name = "Auto Eat", Icon = "rbxassetid://7733770843", PremiumOnly = false})
    local eatPumpkinSpam = false
    local function EatPumpkinLoop()
        while eatPumpkinSpam do
            game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"):FireServer(378, "Eat")
            wait()
        end
    end
    eatTab:AddToggle({
        Name = "Spam Pumpkins",
        Default = false,
        Callback = function(val)
            eatPumpkinSpam = val
            if val then spawn(EatPumpkinLoop) end
        end
    })
    eatTab:AddBind({
        Name = "Eat Pumpkin",
        Default = Enum.KeyCode.E,
        Hold = false,
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"):FireServer(378, "Eat")
        end
    })
    
    -- UNSAVE DATA Tab
    local unsaveTab = window:MakeTab({Name = "UNSAVE DATA", Icon = "rbxassetid://7734052335", PremiumOnly = false})
    unsaveTab:AddButton({
        Name = "DUPE EVERYTHING",
        Callback = function()
            local notif = Instance.new("ScreenGui")
            local label = Instance.new("TextLabel")
            label.Name = "Notification"
            label.Parent = notif
            label.BackgroundColor3 = Color3.new(0, 0, 0)
            label.BackgroundTransparency = 0.5
            label.BorderColor3 = Color3.new(1, 1, 1)
            label.BorderSizePixel = 2
            label.Position = UDim2.new(0.5, -100, 0.8, -50)
            label.Size = UDim2.new(0, 200, 0, 100)
            label.Font = Enum.Font.SourceSansBold
            label.Text = "Data is not going to be saved anymore / discord.gg/87dGbU9t5W"
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextScaled = true
            notif.Parent = game.Players.LocalPlayer.PlayerGui
            wait(3)
            notif:Destroy()
            game:GetService("ReplicatedStorage").References.Comm.Events.SetSettings:FireServer(workspace)
        end
    })
    unsaveTab:AddLabel("discord.gg/87dGbU9t5W")
    unsaveTab:AddLabel("We recommend using our special dupe hub")
    unsaveTab:AddParagraph("How This Works?", "Click DUPE, drop items to alt, pick up, exit main, rejoin. Boom! Items on both accounts.")
    unsaveTab:AddLabel("contact whatever2577 on discord if you need help")
    
    -- SOUL DUPE Tab
    local soulTab = window:MakeTab({Name = "SOUL DUPE", Icon = "rbxassetid://7733764083", PremiumOnly = false})
    soulTab:AddLabel("discord.gg/87dGbU9t5W")
    soulTab:AddLabel("Craft soul set on alt, put in chest, take on main. Boom!")
    soulTab:AddLabel("contact whatever2577 on discord if you need help")
    soulTab:AddLabel("SOUL CRAFT")
    local function CraftSoul(itemId)
        game:GetService("ReplicatedStorage").References.Comm.Events.CraftItem:FireServer(itemId)
    end
    soulTab:AddButton({Name = "Craft Soul Helmet", Callback = function() CraftSoul(201) end})
    soulTab:AddButton({Name = "Craft Soul Body", Callback = function() CraftSoul(202) end})
    soulTab:AddButton({Name = "Craft Soul Leg", Callback = function() CraftSoul(203) end})
    soulTab:AddButton({Name = "Craft Soul Boots", Callback = function() CraftSoul(204) end})
    soulTab:AddButton({Name = "Craft Soul Sheild", Callback = function() CraftSoul(218) end})
    soulTab:AddButton({Name = "Craft Soul Sword", Callback = function() CraftSoul(216) end})
    soulTab:AddLabel("YOU NEED TO HAVE A WOOD CHEST PLACED")
    soulTab:AddLabel("Chest Out")
    local function SoulChest(itemId, take)
        local chest = workspace.Replicators.NonPassive["Wood Storage Chest"]
        game:GetService("ReplicatedStorage").References.Comm.Events.UpdateStorageChest:FireServer(chest, take, itemId)
    end
    soulTab:AddButton({Name = "Soul Helmet In", Callback = function() SoulChest(201, true) end})
    soulTab:AddButton({Name = "Soul Body In", Callback = function() SoulChest(202, true) end})
    soulTab:AddButton({Name = "Soul Leg In", Callback = function() SoulChest(203, true) end})
    soulTab:AddButton({Name = "Soul Boot In", Callback = function() SoulChest(204, true) end})
    soulTab:AddButton({Name = "Soul Sheild In", Callback = function() SoulChest(218, true) end})
    soulTab:AddButton({Name = "Soul Sword In", Callback = function() SoulChest(216, true) end})
    soulTab:AddLabel("Chest Out")
    soulTab:AddButton({Name = "Soul Helmet Out", Callback = function() SoulChest(201, false) end})
    soulTab:AddButton({Name = "Soul Body Out", Callback = function() SoulChest(202, false) end})
    soulTab:AddButton({Name = "Soul Leg Out", Callback = function() SoulChest(203, false) end})
    soulTab:AddButton({Name = "Soul Boot Out", Callback = function() SoulChest(204, false) end})
    soulTab:AddButton({Name = "Soul Sheild Out", Callback = function() SoulChest(218, false) end})
    soulTab:AddButton({Name = "Soul Sword Out", Callback = function() SoulChest(216, false) end})
    
    -- Farm Tab
    local farmTab = window:MakeTab({Name = "Farm", Icon = "rbxassetid://7734056878", PremiumOnly = false})
    farmTab:AddLabel("MAYBE BUGGED")
    
    local obsidianGolemFarm = false
    local function ObsidianGolemLoop()
        while obsidianGolemFarm do
            local golem = workspace.Replicators.NonPassive["Obsidian Golem"]
            game:GetService("ReplicatedStorage").References.Comm.Events.ToolAction:FireServer(golem)
            wait()
        end
    end
    farmTab:AddToggle({
        Name = "Obsidian Golem",
        Default = false,
        Callback = function(val)
            obsidianGolemFarm = val
            if val then spawn(ObsidianGolemLoop) end
        end
    })
    
    local mushroomSpiritFarm = false
    local function MushroomSpiritLoop()
        while mushroomSpiritFarm do
            local spirit = workspace.Replicators.NonPassive["Mushroom Spirit"]
            game:GetService("ReplicatedStorage").References.Comm.Events.ToolAction:FireServer(spirit)
            wait()
        end
    end
    farmTab:AddToggle({
        Name = "Mushrumm Spirit",
        Default = false,
        Callback = function(val)
            mushroomSpiritFarm = val
            if val then spawn(MushroomSpiritLoop) end
        end
    })
    
    local zenyteGolemFarm = false
    local function ZenyteGolemLoop()
        while zenyteGolemFarm do
            local golem = workspace.Replicators.NonPassive["Zenyte Golem"]
            game:GetService("ReplicatedStorage").References.Comm.Events.ToolAction:FireServer(golem)
            wait()
        end
    end
    farmTab:AddToggle({
        Name = "Zenyte Golem",
        Default = false,
        Callback = function(val)
            zenyteGolemFarm = val
            if val then spawn(ZenyteGolemLoop) end
        end
    })
    
    local orangeSlimeFarm = false
    local function OrangeSlimeLoop()
        while orangeSlimeFarm do
            local slime = workspace.Replicators.Both["Orange Slime"]
            game:GetService("ReplicatedStorage").References.Comm.Events.ToolAction:FireServer(slime)
            wait()
        end
    end
    farmTab:AddToggle({
        Name = "Mob",
        Default = false,
        Callback = function(val)
            orangeSlimeFarm = val
            if val then spawn(OrangeSlimeLoop) end
        end
    })
    
    -- Auto Sell Tab (simplified)
    local sellTab = window:MakeTab({Name = "Auto Sell", Icon = "rbxassetid://7734056813", PremiumOnly = false})
    sellTab:AddLabel("Sheilds")
    local sellToggles = {}
    local function MakeSellToggle(name, trader, itemId)
        local running = false
        local function Loop()
            while running do
                game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("TradeTrader"):FireServer(trader, itemId)
                wait()
            end
        end
        sellTab:AddToggle({
            Name = name,
            Default = false,
            Callback = function(val)
                running = val
                if val then spawn(Loop) end
            end
        })
        return function() return running end
    end
    MakeSellToggle("Ruby Shield", "Armour Trader", 27)
    MakeSellToggle("Diamond Shield", "Armour Trader", 28)
    MakeSellToggle("Zenyte Shield", "Armour Trader", 29)
    MakeSellToggle("Obsidian Shield", "Armour Trader", 30)
    sellTab:AddLabel("Armours")
    MakeSellToggle("Ruby Helmet", "Armour Trader", 31)
    MakeSellToggle("Ruby Body", "Armour Trader", 32)
    MakeSellToggle("Ruby Legs", "Armour Trader", 33)
    MakeSellToggle("Ruby Boots", "Armour Trader", 34)
    MakeSellToggle("Diamond Helmet", "Armour Trader", 35)
    MakeSellToggle("Diamond Body", "Armour Trader", 36)
    MakeSellToggle("Diamond Leg", "Armour Trader", 37)
    MakeSellToggle("Diamond Boots", "Armour Trader", 38)
    MakeSellToggle("Zenyte Helmet", "Armour Trader", 39)
    MakeSellToggle("Zenyte Body", "Armour Trader", 40)
    MakeSellToggle("Zenyte Leg", "Armour Trader", 41)
    MakeSellToggle("Zenyte Boot", "Armour Trader", 42)
    MakeSellToggle("Obsidian Helmet", "Armour Trader", 43)
    MakeSellToggle("Obsidian Body", "Armour Trader", 44)
    MakeSellToggle("Obsidian Leg", "Armour Trader", 45)
    MakeSellToggle("Obsidian boot", "Armour Trader", 46)
    MakeSellToggle("Moonstone Helmet", "Armour Trader", 47)
    MakeSellToggle("Moonstone Body", "Armour Trader", 48)
    MakeSellToggle("Moonstone Leg", "Armour Trader", 49)
    MakeSellToggle("Moonstone Boot", "Armour Trader", 50)
    MakeSellToggle("Soul Boot / Lucky Boot", "Armour Trader", 51)
    sellTab:AddParagraph("Weapon Trader", "")
    MakeSellToggle("Silver Crossbow", "Weapon Trader", 10)
    MakeSellToggle("Silver Sword", "Weapon Trader", 11)
    MakeSellToggle("Golden Sword", "Weapon Trader", 12)
    MakeSellToggle("Golden Bow", "Weapon Trader", 13)
    MakeSellToggle("Ruby Sword", "Weapon Trader", 14)
    MakeSellToggle("Diamond Sword", "Weapon Trader", 15)
    MakeSellToggle("Diamond Crossbow", "Weapon Trader", 16)
    MakeSellToggle("Zenyte Sword", "Weapon Trader", 17)
    MakeSellToggle("Zenyte Crossbow", "Weapon Trader", 18)
    sellTab:AddParagraph("Resource Trader", "")
    MakeSellToggle("4 Silver = 1 Token", "Resource Trader", 14)
    MakeSellToggle("4 Slime Ball = 1 Token", "Resource Trader", 15)
    MakeSellToggle("2 Gold Bar = 1 Token", "Resource Trader", 16)
    MakeSellToggle("1 Ruby = 3 Token", "Resource Trader", 17)
    MakeSellToggle("1 Diamond = 4 Token", "Resource Trader", 18)
    MakeSellToggle("1 Zen = 6 Token", "Resource Trader", 19)
    MakeSellToggle("3 Pumpkin = 1 Token", "Resource Trader", 20)
    MakeSellToggle("5 Candy = 1 Token", "Resource Trader", 21)
    MakeSellToggle("1 Soul = 5 Token", "Resource Trader", 22)
    MakeSellToggle("1 Volcanic Ore = 15 Token", "Resource Trader", 23)
    MakeSellToggle("1 Obsidian = 20 Token", "Resource Trader", 24)
    MakeSellToggle("1 Lunar Ore = 25 Token", "Resource Trader", 25)
    MakeSellToggle("1 Moonstone = 30 Token", "Resource Trader", 26)
    
    -- Finder Tab (simplified)
    local finderTab = window:MakeTab({Name = "Finder", Icon = "rbxassetid://7734052925", PremiumOnly = false})
    finderTab:AddLabel("Events")
    local function FindAndTeleport(name, successMsg, failMsg)
        local target = nil
        local function Search(obj)
            for _, child in ipairs(obj:GetChildren()) do
                if child.Name == name then
                    target = child
                    return
                elseif child:IsA("Model") or child:IsA("Folder") then
                    Search(child)
                end
            end
        end
        Search(workspace)
        if target and target:IsDescendantOf(workspace) then
            local pos = target:GetBoundingBox().Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
            wait(0.5)
            orion:MakeNotification({Name = "Success!", Content = successMsg, Image = "rbxassetid://4483345998", Time = 5})
        else
            orion:MakeNotification({Name = "Failure!", Content = failMsg, Image = "rbxassetid://4483345998", Time = 5})
        end
    end
    finderTab:AddButton({Name = "Mega Candy Rock", Callback = function() FindAndTeleport("Mega Candy Rock", "Teleported to Mega Candy Rock", "No Mega Candy Rock found") end})
    finderTab:AddButton({Name = "Asteroid", Callback = function() FindAndTeleport("Asteroid", "Teleported to Asteroid", "No Asteroid found") end})
    finderTab:AddLabel("Items")
    finderTab:AddButton({Name = "Candy", Callback = function() FindAndTeleport("Candy", "Teleported to Candy", "No Candy found") end})
    finderTab:AddButton({Name = "Pile of Candy", Callback = function() FindAndTeleport("Pile of Candy", "Teleported to Pile of Candy", "No Pile of Candy found") end})
    finderTab:AddLabel("patches")
    finderTab:AddButton({Name = "Potato Patch", Callback = function() FindAndTeleport("Potato Patch", "Teleported to Potato Patch", "No Potato Patch found") end})
    finderTab:AddButton({Name = "Cabbage Patch", Callback = function() FindAndTeleport("Cabbage Patch", "Teleported to Cabbage Patch", "No Cabbage Patch found") end})
    finderTab:AddButton({Name = "Watermelon Patch", Callback = function() FindAndTeleport("Watermelon Patch", "Teleported to Watermelon Patch", "No Watermelon Patch found") end})
    finderTab:AddButton({Name = "Carrot Patch", Callback = function() FindAndTeleport("Carrot Patch", "Teleported to Carrot Patch", "No Carrot Patch found") end})
    finderTab:AddLabel("Boss")
    finderTab:AddButton({Name = "Obsidian Golem", Callback = function() FindAndTeleport("Obsidian Golem", "Teleported to Obsidian Golem", "No Obsidian Golem found") end})
    finderTab:AddButton({Name = "Ogre", Callback = function() FindAndTeleport("Ogre", "Teleported to Ogre", "No Ogre found") end})
    finderTab:AddButton({Name = "Lucky Slime", Callback = function() FindAndTeleport("Lucky Slime", "Teleported to Lucky Slime", "No Lucky Slime found") end})
    finderTab:AddLabel("Ores")
    finderTab:AddButton({Name = "Silver Rock", Callback = function() FindAndTeleport("Silver Rock", "Teleported to Silver Rock", "No Silver Rock found") end})
    finderTab:AddButton({Name = "Gold Rock", Callback = function() FindAndTeleport("Gold Rock", "Teleported to Gold Rock", "No Gold Rock found") end})
    finderTab:AddButton({Name = "Ruby Rock", Callback = function() FindAndTeleport("Ruby Rock", "Teleported to Ruby Rock", "No Ruby Rock found") end})
    finderTab:AddButton({Name = "Diamond Rock", Callback = function() FindAndTeleport("Diamond Rock", "Teleported to Diamond Rock", "No Diamond Rock found") end})
    finderTab:AddButton({Name = "Zenyte Rock", Callback = function() FindAndTeleport("Zenyte Rock", "Teleported to Zenyte Rock", "No Zenyte Rock found") end})
    finderTab:AddButton({Name = "Volcanic Rock", Callback = function() FindAndTeleport("Volcanic Rock", "Teleported to Volcanic Rock", "No Volcanic Rock found") end})
    finderTab:AddButton({Name = "Magic Rock", Callback = function() FindAndTeleport("Magic Rock", "Teleported to Magic Rock", "No Magic Rock found") end})
    
    -- Chest Tab
    local chestTab = window:MakeTab({Name = "Chest", Icon = "rbxassetid://7733917120", PremiumOnly = false})
    chestTab:AddButton({Name = "Buy Easy Chest", Callback = function() game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent"):FireServer(1) end})
    chestTab:AddButton({Name = "Buy Medium Chest", Callback = function() game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent"):FireServer(2) end})
    chestTab:AddButton({Name = "Buy Hard Chest", Callback = function() game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent"):FireServer(3) end})
    
    local dropCoalSpam = false
    local function DropCoalLoop()
        while dropCoalSpam do
            game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"):FireServer(63, "Drop")
            game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"):FireServer(160, "Drop")
            wait()
        end
    end
    chestTab:AddToggle({
        Name = "Drop Coal and Ruby Harvester",
        Default = false,
        Callback = function(val)
            dropCoalSpam = val
            if val then spawn(DropCoalLoop) end
        end
    })
    chestTab:AddButton({Name = "Open Easy Chest", Callback = function() game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"):FireServer(166, "Open") end})
    chestTab:AddButton({Name = "Open Medium Chest", Callback = function() game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"):FireServer(167, "Open") end})
    chestTab:AddButton({Name = "Open Hard Chest", Callback = function() game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction"):FireServer(168, "Open") end})
    
    chestTab:AddButton({
        Name = "Spam Med Chest and pickup very fast until token die!",
        Callback = function()
            local function FindChest()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj.Name == "Treasure Chest (Medium)" then
                        return obj
                    end
                end
                return nil
            end
            local function PickupChest(chest)
                local startPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                while chest and chest:IsDescendantOf(workspace) do
                    local pos = chest:GetBoundingBox().Position
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
                    wait(0.5)
                    local timeout = os.time() + 5
                    while os.time() < timeout do
                        game:GetService("ReplicatedStorage").References.Comm.Events.ItemInteracted:FireServer(chest.PrimaryPart, "Pickup")
                        wait(0.1)
                    end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startPos)
                    wait(0.5)
                    chest = FindChest()
                end
            end
            local function BuyAndPickup()
                game:GetService("ReplicatedStorage"):WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent"):FireServer(2)
                wait(0.5)
                local chest = FindChest()
                if chest and chest:IsDescendantOf(workspace) then
                    PickupChest(chest)
                    return true
                end
                return false
            end
            spawn(function()
                while BuyAndPickup() do end
            end)
            spawn(function()
                while true do
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        local pos = char.PrimaryPart.Position
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            if obj:IsA("Model") and obj.PrimaryPart and (pos - obj.PrimaryPart.Position).Magnitude <= 5 then
                                pcall(function()
                                    game:GetService("ReplicatedStorage").References.Comm.Events.ItemInteracted:FireServer(obj, "Pickup")
                                end)
                            end
                        end
                    end
                    wait()
                end
            end)
        end
    })
    
    chestTab:AddButton({Name = "Tp To Easy Chest", Callback = function() FindAndTeleport("Treasure Chest (Easy)", "Teleported to Easy Chest", "No Easy Chest found") end})
    chestTab:AddButton({Name = "Tp To Medium Chest", Callback = function() FindAndTeleport("Treasure Chest (Medium)", "Teleported to Medium Chest", "No Medium Chest found") end})
    chestTab:AddButton({Name = "Tp To Hard Chest", Callback = function() FindAndTeleport("Treasure Chest (Hard)", "Teleported to Hard Chest", "No Hard Chest found") end})
    
    -- Mic Tab
    local micTab = window:MakeTab({Name = "Mic", Icon = "rbxassetid://7733964719", PremiumOnly = false})
    micTab:AddButton({
        Name = "Equip / Unequip Obsidian Set",
        Callback = function()
            game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction:FireServer(225, "Equip")
            game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction:FireServer(226, "Equip")
            game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction:FireServer(227, "Equip")
            game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction:FireServer(228, "Equip")
        end
    })
    micTab:AddButton({
        Name = "Equip / Unequip Soul Set",
        Callback = function()
            game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction:FireServer(201, "Equip")
            game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction:FireServer(202, "Equip")
            game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction:FireServer(203, "Equip")
            game:GetService("ReplicatedStorage").References.Comm.Events.InventoryInteraction:FireServer(204, "Equip")
        end
    })
    micTab:AddButton({
        Name = "Anti-AFK script",
        Callback = function()
            local success, err = pcall(function()
                local vu = game:GetService("VirtualUser")
                game.Players.LocalPlayer.Idled:Connect(function()
                    vu:CaptureController()
                    vu:ClickButton2(Vector2.new())
                end)
            end)
            if success then
                orion:MakeNotification({Name = "", Content = "Anti-AFK script executed successfully.", Image = "rbxassetid://4483345998", Time = 5})
            else
                orion:MakeNotification({Name = "Error", Content = "Error: " .. tostring(err), Image = "rbxassetid://4483345998", Time = 5})
            end
        end
    })
end

_TextButton2.MouseButton1Click:Connect(OnVerify)
