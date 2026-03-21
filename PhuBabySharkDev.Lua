repeat task.wait() until game:IsLoaded()

pcall(function()
    game.CoreGui:FindFirstChild("PhuBabyDevGUI"):Destroy()
end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

-- Character Safe Update
local Character = Player.Character or Player.CharacterAdded:Wait()
Player.CharacterAdded:Connect(function(c)
    Character = c
end)

-- GUI ROOT
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDevGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,380,0,240)
Main.Position = UDim2.new(0.5,-190,0.5,-120)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.BorderSizePixel = 0
Main.Active = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 2

-- RGB LOOP BORDER
task.spawn(function()
    while task.wait() do
        Stroke.Color = Color3.fromHSV((tick()%5)/5,1,1)
    end
end)

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextColor3 = Color3.new(1,1,1)

-- MINIMIZE BUTTON
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Main
MinBtn.Size = UDim2.new(0,35,0,35)
MinBtn.Position = UDim2.new(1,-45,0,5)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextScaled = true
MinBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
MinBtn.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner", MinBtn)

-- RESTORE BUTTON
local Restore = Instance.new("TextButton")
Restore.Parent = ScreenGui
Restore.Size = UDim2.new(0,45,0,45)
Restore.Position = UDim2.new(0.5,-22,0.85,0)
Restore.Text = "+"
Restore.Visible = false
Restore.Font = Enum.Font.GothamBold
Restore.TextScaled = true
Restore.BackgroundColor3 = Color3.fromRGB(20,20,20)
Restore.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner", Restore)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Restore.Visible = true
end)

Restore.MouseButton1Click:Connect(function()
    Main.Visible = true
    Restore.Visible = false
end)

-- DRAG SYSTEM MOBILE + PC
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

-- NOTIFY FUNCTION
local function notify(msg)
    pcall(function()
        game.StarterGui:SetCore("SendNotification",{
            Title = "PhuBaby Dev",
            Text = msg,
            Duration = 2
        })
    end)
end

-- TOGGLE BUTTON
local Toggle = Instance.new("TextButton")
Toggle.Parent = Main
Toggle.Size = UDim2.new(0,200,0,60)
Toggle.Position = UDim2.new(0.5,-100,0.5,-20)
Toggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
Toggle.Text = "Auto Jump OFF"
Toggle.Font = Enum.Font.GothamBold
Toggle.TextScaled = true
Toggle.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,16)

local enabled = false

Toggle.MouseButton1Click:Connect(function()
    enabled = not enabled

    if enabled then
        TweenService:Create(Toggle,TweenInfo.new(0.25),{
            BackgroundColor3 = Color3.fromRGB(0,255,120)
        }):Play()

        Toggle.Text = "Auto Jump ON"
        notify("Đã bật nhảy liên tục")
    else
        TweenService:Create(Toggle,TweenInfo.new(0.25),{
            BackgroundColor3 = Color3.fromRGB(255,0,0)
        }):Play()

        Toggle.Text = "Auto Jump OFF"
        notify("Đã tắt nhảy liên tục")
    end
end)

-- FULL AUTO JUMP FIX
task.spawn(function()
    while task.wait(0.12) do
        if enabled then
            local char = Player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    if hum.FloorMaterial ~= Enum.Material.Air then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end
    end
end)
