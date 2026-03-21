repeat task.wait() until game:IsLoaded()

pcall(function()
    game.CoreGui:FindFirstChild("PhuBabyDevGUI"):Destroy()
end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

Player.CharacterAdded:Connect(function(c)
    Character = c
end)

-- GUI ROOT
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDevGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

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

-- RGB BORDER
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

-- TOGGLE BUTTON
local Toggle = Instance.new("TextButton")
Toggle.Parent = Main
Toggle.Size = UDim2.new(0,210,0,60)
Toggle.Position = UDim2.new(0.5,-105,0.5,-10)
Toggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
Toggle.Text = "Auto Jump OFF"
Toggle.Font = Enum.Font.GothamBold
Toggle.TextScaled = true
Toggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,16)

-- MIN BUTTON
local Min = Instance.new("TextButton")
Min.Parent = Main
Min.Size = UDim2.new(0,35,0,35)
Min.Position = UDim2.new(1,-45,0,5)
Min.Text = "-"
Min.Font = Enum.Font.GothamBold
Min.TextScaled = true
Min.BackgroundColor3 = Color3.fromRGB(30,30,30)
Min.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Min)

-- RESTORE
local Open = Instance.new("TextButton")
Open.Parent = ScreenGui
Open.Size = UDim2.new(0,45,0,45)
Open.Position = UDim2.new(0.5,-22,0.85,0)
Open.Text = "+"
Open.Visible = false
Open.Font = Enum.Font.GothamBold
Open.TextScaled = true
Open.BackgroundColor3 = Color3.fromRGB(20,20,20)
Open.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Open)

Min.MouseButton1Click:Connect(function()
    Main.Visible = false
    Open.Visible = true
end)

Open.MouseButton1Click:Connect(function()
    Main.Visible = true
    Open.Visible = false
end)

-- DRAG SYSTEM
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

-- NOTIFY
local function notify(msg)
    pcall(function()
        game.StarterGui:SetCore("SendNotification",{
            Title = "PhuBaby Dev",
            Text = msg,
            Duration = 2
        })
    end)
end

-- AUTO JUMP LOGIC
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

task.spawn(function()
    while task.wait(0.05) do
        if enabled then
            local char = Player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    hum.JumpPower = 70
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    hum.Jump = true
                end
            end
        end
    end
end)
