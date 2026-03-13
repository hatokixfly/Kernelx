--// KERNELX UI FRAMEWORK
--// Script By: KernelX

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer

-- Notification
local function notify(txt)
    pcall(function()
        StarterGui:SetCore("SendNotification",{
            Title = "KernelX",
            Text = txt,
            Duration = 3
        })
    end)
end

notify("Script By: KernelX")

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KernelX"

-- Logo button
local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,20,0.5,-25)
logo.Text = "K"
logo.TextColor3 = Color3.fromRGB(255,255,255)
logo.BackgroundColor3 = Color3.fromRGB(0,0,0)
logo.TextScaled = true
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

-- Main frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,500,0,320)
frame.Position = UDim2.new(0.5,-250,0.5,-160)
frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
frame.Visible = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

-- Title rainbow
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "Nguyen Thanh Phu"
title.BackgroundTransparency = 1
title.TextScaled = true

task.spawn(function()
    while true do
        for i=0,255,5 do
            title.TextColor3 = Color3.fromHSV(i/255,1,1)
            task.wait(0.03)
        end
    end
end)

-- Loading fake
local load = Instance.new("TextLabel", frame)
load.Size = UDim2.new(1,0,0,40)
load.Position = UDim2.new(0,0,0.4,0)
load.BackgroundTransparency = 1
load.TextColor3 = Color3.fromRGB(255,0,0)
load.TextScaled = true

task.spawn(function()
    frame.Visible = true
    for i=1,100 do
        load.Text = "Loading "..i.."%"
        task.wait(0.02)
    end
    load.Visible = false
end)

-- Drag
local dragging=false
local dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging=true
        dragStart=input.Position
        startPos=frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta=input.Position-dragStart
        frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=false
    end
end)

-- Toggle menu
logo.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Button creator
local function makeButton(txt,pos,callback)
    local b=Instance.new("TextButton", frame)
    b.Size=UDim2.new(0,220,0,35)
    b.Position=pos
    b.Text=txt
    b.BackgroundColor3=Color3.fromRGB(30,0,0)
    b.TextColor3=Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(callback)
end

-- Save Position
local savedPos=nil
makeButton("Save Position",UDim2.new(0,20,0,60),function()
    savedPos=player.Character.HumanoidRootPart.CFrame
    notify("Saved Position")
end)

-- Teleport Saved
makeButton("Tele Saved Position",UDim2.new(0,260,0,60),function()
    if savedPos then
        player.Character.HumanoidRootPart.CFrame=savedPos
        notify("Teleported")
    end
end)

-- Auto Jump
local jumping=false
makeButton("Auto Space",UDim2.new(0,20,0,110),function()
    jumping=not jumping
    notify(jumping and "Auto Space ON" or "Auto Space OFF")
    task.spawn(function()
        while jumping do
            player.Character.Humanoid.Jump=true
            task.wait(0.3)
        end
    end)
end)

-- Anti AFK
makeButton("Anti AFK",UDim2.new(0,260,0,110),function()
    local vu = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    notify("Anti AFK ON")
end)

-- Rejoin server
makeButton("Rejoin Server",UDim2.new(0,20,0,160),function()
    TeleportService:Teleport(game.PlaceId, player)
end)

-- Player list UI
local plrBox = Instance.new("TextLabel", frame)
plrBox.Size = UDim2.new(0,220,0,100)
plrBox.Position = UDim2.new(0,260,0,160)
plrBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
plrBox.TextColor3 = Color3.new(1,1,1)
plrBox.TextScaled = false
plrBox.TextYAlignment = Enum.TextYAlignment.Top

task.spawn(function()
    while true do
        local txt = ""
        for _,p in pairs(Players:GetPlayers()) do
            txt = txt..p.Name.."\n"
        end
        plrBox.Text = txt
        task.wait(2)
    end
end)
