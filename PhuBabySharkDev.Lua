--// PhuBaby Dev Premium GUI
--// Run Script By Nguyễn Thanh Phú

repeat task.wait() until game:IsLoaded()

-- Anti duplicate GUI
pcall(function()
    game.CoreGui:FindFirstChild("PhuBabyDevGUI"):Destroy()
end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

Player.CharacterAdded:Connect(function(c)
    Character = c
end)

-- GUI Root
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDevGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Loading Screen
local Loading = Instance.new("Frame")
Loading.Parent = ScreenGui
Loading.Size = UDim2.new(0, 320, 0, 160)
Loading.Position = UDim2.new(0.5, -160, 0.5, -80)
Loading.BackgroundColor3 = Color3.fromRGB(15,15,15)
Loading.BorderSizePixel = 0

local LoadCorner = Instance.new("UICorner", Loading)
LoadCorner.CornerRadius = UDim.new(0,16)

local LoadText = Instance.new("TextLabel")
LoadText.Parent = Loading
LoadText.Size = UDim2.new(1,0,0.5,0)
LoadText.BackgroundTransparency = 1
LoadText.Text = "Run Script By Nguyễn Thanh Phú"
LoadText.TextColor3 = Color3.fromRGB(255,255,255)
LoadText.Font = Enum.Font.GothamBold
LoadText.TextScaled = true

local Percent = Instance.new("TextLabel")
Percent.Parent = Loading
Percent.Size = UDim2.new(1,0,0.5,0)
Percent.Position = UDim2.new(0,0,0.5,0)
Percent.BackgroundTransparency = 1
Percent.TextColor3 = Color3.fromRGB(0,255,255)
Percent.Font = Enum.Font.GothamBold
Percent.TextScaled = true

for i = 1,100 do
    Percent.Text = i.."%"
    task.wait(0.015)
end

task.wait(0.3)
Loading:Destroy()

-- Main UI
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 420, 0, 300)
Main.Position = UDim2.new(0.5, -210, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.BorderSizePixel = 0

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0,18)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 2

-- RGB Border
task.spawn(function()
    while task.wait() do
        Stroke.Color = Color3.fromHSV(tick()%5/5,1,1)
    end
end)

-- Open animation
Main.Size = UDim2.new(0,0,0,0)
TweenService:Create(Main,TweenInfo.new(0.4),{
    Size = UDim2.new(0,420,0,300)
}):Play()

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Main
MinBtn.Size = UDim2.new(0,35,0,35)
MinBtn.Position = UDim2.new(1,-45,0,5)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextScaled = true
MinBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)

local MinCorner = Instance.new("UICorner", MinBtn)

local Restore = Instance.new("TextButton")
Restore.Parent = ScreenGui
Restore.Size = UDim2.new(0,45,0,45)
Restore.Position = UDim2.new(0.5, -22, 0.85, 0)
Restore.Text = "+"
Restore.Visible = false
Restore.Font = Enum.Font.GothamBold
Restore.TextScaled = true
Restore.BackgroundColor3 = Color3.fromRGB(20,20,20)
Restore.TextColor3 = Color3.fromRGB(255,255,255)

local RestoreCorner = Instance.new("UICorner", Restore)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Restore.Visible = true
end)

Restore.MouseButton1Click:Connect(function()
    Main.Visible = true
    Restore.Visible = false
end)

-- Drag System Mobile + PC
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
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Slider
local SliderFrame = Instance.new("Frame")
SliderFrame.Parent = Main
SliderFrame.Size = UDim2.new(0,320,0,10)
SliderFrame.Position = UDim2.new(0,50,0,90)
SliderFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)

local SliderCorner = Instance.new("UICorner", SliderFrame)

local Fill = Instance.new("Frame")
Fill.Parent = SliderFrame
Fill.Size = UDim2.new(0,0,1,0)
Fill.BackgroundColor3 = Color3.fromRGB(0,255,255)

local FillCorner = Instance.new("UICorner", Fill)

local SliderValue = Instance.new("TextLabel")
SliderValue.Parent = Main
SliderValue.Size = UDim2.new(0,200,0,30)
SliderValue.Position = UDim2.new(0,110,0,55)
SliderValue.BackgroundTransparency = 1
SliderValue.Text = "Jump Value: 20"
SliderValue.TextColor3 = Color3.fromRGB(255,255,255)
SliderValue.Font = Enum.Font.GothamBold
SliderValue.TextScaled = true

local jumpValue = 20

SliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        
        local move
        move = UIS.InputChanged:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch then
                
                local pos = math.clamp(
                    (i.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X,
                    0,1
                )
                
                Fill.Size = UDim2.new(pos,0,1,0)
                jumpValue = math.floor(20 + ((100000-20)*pos))
                SliderValue.Text = "Jump Value: "..jumpValue
            end
        end)

        UIS.InputEnded:Connect(function(endInput)
            if endInput.UserInputType == Enum.UserInputType.MouseButton1
            or endInput.UserInputType == Enum.UserInputType.Touch then
                move:Disconnect()
            end
        end)
    end
end)

-- Toggle
local Toggle = Instance.new("TextButton")
Toggle.Parent = Main
Toggle.Size = UDim2.new(0,160,0,45)
Toggle.Position = UDim2.new(0.5,-80,0,170)
Toggle.Text = "High Jump OFF"
Toggle.Font = Enum.Font.GothamBold
Toggle.TextScaled = true
Toggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
Toggle.TextColor3 = Color3.fromRGB(255,255,255)

local ToggleCorner = Instance.new("UICorner", Toggle)

local enabled = false

local function notify(text)
    game.StarterGui:SetCore("SendNotification",{
        Title = "PhuBaby Dev",
        Text = text,
        Duration = 2
    })
end

Toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    
    if enabled then
        TweenService:Create(Toggle,TweenInfo.new(0.25),{
            BackgroundColor3 = Color3.fromRGB(0,255,120)
        }):Play()
        Toggle.Text = "High Jump ON"
        notify("Đã bật High Jump")
    else
        TweenService:Create(Toggle,TweenInfo.new(0.25),{
            BackgroundColor3 = Color3.fromRGB(255,0,0)
        }):Play()
        Toggle.Text = "High Jump OFF"
        notify("Đã tắt High Jump")
    end
end)

-- High Jump Loop
RunService.RenderStepped:Connect(function()
    if enabled and Character and Character:FindFirstChildOfClass("Humanoid") then
        local Hum = Character:FindFirstChildOfClass("Humanoid")
        Hum.JumpPower = jumpValue
        Hum.Jump = true
    end
end)
