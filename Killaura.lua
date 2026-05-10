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
                        local closestDistance = 17

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

                    task.wait(0.001)
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
